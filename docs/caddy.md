# Caddy local development cheatsheet

This topic configures Caddy as the local HTTPS reverse proxy for `*.test` sites.

The dotfiles manage the shared infrastructure:

- the base Caddyfile
- the Caddy service
- the local Caddy certificate authority
- the directory where per-project site files live

Individual project sites are not tracked in this repo. They are local machine config.

## Where site files live

Per-project Caddy snippets live here:

    $(brew --prefix)/etc/caddy/sites/

Each project usually gets one file:

    $(brew --prefix)/etc/caddy/sites/myapp.caddy

The base Caddyfile imports all files matching:

    $(brew --prefix)/etc/caddy/sites/*.caddy

A fresh install with an empty `sites/` directory is valid. Caddy will start, but it will
not serve anything on ports 80 or 443 until at least one site file exists.

## Basic workflow

Create or edit a site file:

    $EDITOR "$(brew --prefix)/etc/caddy/sites/myapp.caddy"

Format it:

    caddy fmt --overwrite "$(brew --prefix)/etc/caddy/sites/myapp.caddy"

Validate the full Caddy config:

    caddy validate --config "$(brew --prefix)/etc/Caddyfile"

Reload Caddy:

    caddy reload --config "$(brew --prefix)/etc/Caddyfile"

Or restart the service:

    brew services restart caddy

## Static site

Example file:

    $(brew --prefix)/etc/caddy/sites/mysite.caddy

Contents:

    mysite.test {
        root * /Users/yourname/code/mysite
        file_server
        encode gzip
    }

Open:

    https://mysite.test

## PHP site with php-fpm

Example file:

    $(brew --prefix)/etc/caddy/sites/myapp.caddy

Contents:

    myapp.test {
        root * /Users/yourname/code/myapp/public
        php_fastcgi 127.0.0.1:9000
        file_server
        encode gzip
    }

Check php-fpm:

    brew services list | grep php

Restart php-fpm:

    brew services restart php

## Reverse proxy site

Use this for Go, Node, Python, Rust, or anything else running its own local server.

Example file:

    $(brew --prefix)/etc/caddy/sites/myapi.caddy

Contents:

    myapi.test {
        reverse_proxy 127.0.0.1:8080
        encode gzip
    }

Start your app on port 8080, then open:

    https://myapi.test

## Multiple hostnames

You can put more than one hostname on the same site block:

    myapp.test www.myapp.test {
        reverse_proxy 127.0.0.1:8080
    }

## Project-owned snippets

Most site files can live only in the Caddy sites directory.

For complicated projects, it can be useful to keep the Caddy snippet in the project repo
and symlink it into the sites directory:

    ln -sf "$PWD/dev/myapp.caddy" "$(brew --prefix)/etc/caddy/sites/myapp.caddy"
    caddy reload --config "$(brew --prefix)/etc/Caddyfile"

Use this only when the Caddy config is meaningfully part of the project. Otherwise, keep
site files local and untracked.

## Useful commands

List configured sites:

    ls -1 "$(brew --prefix)/etc/caddy/sites"

Edit the base Caddyfile:

    $EDITOR "$(brew --prefix)/etc/Caddyfile"

Validate the base Caddyfile:

    caddy validate --config "$(brew --prefix)/etc/Caddyfile"

Reload Caddy:

    caddy reload --config "$(brew --prefix)/etc/Caddyfile"

Restart Caddy:

    brew services restart caddy

Check Caddy service status:

    brew services list | grep caddy

View Caddy logs:

    brew services info caddy

Check whether a hostname resolves locally:

    ping -c1 myapp.test

Check whether Caddy is listening:

    lsof -nP -iTCP:443 -sTCP:LISTEN

## Troubleshooting

### Host does not resolve

Check that dnsmasq is working:

    ping -c1 anything.test

It should resolve to `127.0.0.1`.

If DNS was recently changed, restart dnsmasq and flush the macOS resolver cache:

    sudo brew services restart dnsmasq
    flush-dns

### Browser shows certificate warnings

Caddy's local CA needs to be trusted in the macOS System Keychain.

Re-run the Caddy setup:

    zdot setup caddy

Or run manually:

    caddy trust

### Caddy serves nothing

That is expected if there are no files in:

    $(brew --prefix)/etc/caddy/sites/

Add a `.caddy` file and reload Caddy.

### Config change did not apply

Caddy does not watch site files automatically.

After every add/edit/delete in the sites directory, run:

    caddy reload --config "$(brew --prefix)/etc/Caddyfile"

### Reload fails

Validate first:

    caddy validate --config "$(brew --prefix)/etc/Caddyfile"

If validation fails, fix the reported site file and reload again. Caddy reloads are
atomic: a failed reload does not replace the currently running config.
