#!/usr/bin/env python3
#
# Check expiration of SSL certificates
#
# Based on: https://github.com/cudeso/tools/blob/master/ceds.py
#
# Config located in: $XDG_CONFIG_HOME ||  $HOME/.config/pw/certificate_checker.cfg
#
# Uses config or defaults:
#
# domains: $XDG_DATA_HOME || $HOME/.local/share/pw/certificate_checker/domains.txt
# email_from: None
# email_to: None

import os
import sys

from OpenSSL import SSL
from OpenSSL import crypto
import ssl
import socket
import datetime
from postmarker.core import PostmarkClient
from configparser import ConfigParser


class CertificateChecker:

    def __init__(self):

        self.date_format = r'%b %d %H:%M:%S %Y %Z'

        self.default_config = ("[certificates]\n"
                               "show_all=0\n"
                               "alert_days=5\n\n"
                               "[postmark]\n"
                               "server_token=None\n"
                               "account_token=None\n"
                               "from=None\n"
                               "to=None")

        config_file = os.getenv('XDG_CONFIG_HOME', '%s/.config' % os.getenv('HOME'))
        config_file = '%s/pw' % config_file

        domain_list = os.getenv('XDG_DATA_HOME', '%s/.local/share' % os.getenv('HOME'))
        domain_list = '%s/pw/certificate_checker' % domain_list

        if not os.path.exists(config_file):
            os.makedirs(config_file)

        if not os.path.exists(domain_list):
            os.makedirs(domain_list)

        config_file = '%s/certificate_checker.cfg' % config_file
        domain_list = '%s/domains.txt' % domain_list

        if not os.path.exists(config_file):
            print("Creating default config...")
            file = open(config_file, 'w')
            file.write(self.default_config)
            file.close()

        if os.path.exists(config_file):
            print("Reading from certificate_checker.cfg")
            config = ConfigParser()
            config.read(config_file)
            self.show_all = bool(config.get('certificates', 'show_all'))
            self.alert_days = int(config.get('certificates', 'alert_days'))
            self.email_from = config.get('postmark', 'from')
            self.email_to = config.get('postmark', 'to')
            self.server_token = config.get('postmark', 'server_token')
            self.account_token = config.get('postmark', 'account_token')

        if not os.path.exists(domain_list):
            print('No domains list found. Please add to: \n%s' % domain_list)
            sys.exit()

        self.response = ''
        self.cert_tested = 0
        self.current_utc = datetime.datetime.utcnow()
        self.domains = open(domain_list, 'r')

    def get_certificate(self, host_port):

        host = host_port.strip().split(':')[0]
        port = int(host_port.strip().split(':')[1])

        try:

            context = ssl.create_default_context()
            connection = context.wrap_socket(
                socket.socket(socket.AF_INET),
                server_hostname=host
            )

            # Set a timeout
            connection.settimeout(3.0)

            connection.connect((host, port))

            cert = connection.getpeercert()

            # Get the expiry date from the cert string
            expires = datetime.datetime.strptime(cert['notAfter'], self.date_format)

            days_to_expire = int((expires - self.current_utc).days)
            self.cert_tested = self.cert_tested + 1
            if days_to_expire < 0:
                self.response = self.response + "\n %s : %s EXPIRED" % (host, port)
            elif self.alert_days > days_to_expire:
                self.response = self.response + "\n %s : %s expires in %s days " % (host, port, days_to_expire)
            elif self.show_all:
                self.response = self.response + "\n %s : %s OK" % (host, port)

        except ssl.SSLError as e:
            strerror = e.strerror.lower()
            if 'expired' in strerror:
                self.response = self.response + "\n %s:%s EXPIRED" % (host, port)
            elif 'wrong version number' in strerror:
                self.response = self.response + "\n %s:%s WRONG VERSION NUMBER" % (host, port)
            elif 'hostname mismatch' in strerror:
                self.response = self.response + "\n %s:%s HOSTNAME MISMATCH" % (host, port)
            elif 'unable to get local issuer certificate' in e.strerror:
                self.response = self.response + "\n %s:%s UNABLE TO GET CERT" % (host, port)
            else:
                self.response = self.response + "\n %s:%s INVALID %s" % (host, port, e.strerror)
        except Exception as e:
            self.response = self.response + "\n Unable to connect to %s:%s %s" % (host, port, e)

    def run(self):

        for host in self.domains:
            self.get_certificate(host)

        if self.response:
            self.response = self.response + "\n\nTotal certificates tested : %s \n" % self.cert_tested
            print(self.response)
        else:
            print("No response to report.")

        self.send()

    def send(self):
        if None not in (self.email_from, self.email_to, self.server_token, self.account_token):
            print("Sending email...")
            postmark = PostmarkClient(server_token=self.server_token, account_token=self.account_token)

            postmark.emails.send(
                From=self.email_from,
                To=self.email_to,
                Subject='Domain Certificates Check',
                TextBody=self.response
            )


if __name__ == "__main__":
    checker = CertificateChecker()
    checker.run()

