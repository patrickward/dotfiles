# Local Dev Infrastructure

This directory manages the Homebrew package set and post-install wiring for the full local development stack. The stack is:

| Tool                                                         | Role                                                          |
|--------------------------------------------------------------|---------------------------------------------------------------|
| **[dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html)**    | Resolves `*.test` → `127.0.0.1` system-wide                   |
| **[Caddy](https://caddyserver.com/docs/)**                   | Local HTTPS reverse proxy; routes `*.test` to local processes |
| **[php-fpm](https://www.php.net/manual/en/install.fpm.php)** | FastCGI backend for PHP projects                              |
| **[Mailpit](https://mailpit.axllent.org/docs/)**             | Catches all outbound SMTP in a local web UI                   |
| **[Redis](https://redis.io/docs/latest/)**                   | In-memory store; started on demand                            |
| **[mise](https://mise.jdx.dev)**                             | Runtime version manager (Go, Node, Python, Rust)              |
| **[OrbStack](https://orbstack.dev/docs)**                    | Docker runtime for containerised services                     |
| **[Tailscale](https://tailscale.com/kb)**                    | Mesh VPN for device-to-device dev access                      |
| **[ngrok](https://ngrok.com/docs)**                          | Public tunnel for webhook testing and external sharing        |

Two of these are not Homebrew-managed: **mise** is installed via `mise.run` in
`bootstrap.sh` (the Brewfile's supply-chain policy keeps runtimes out of brew), and
**Tailscale** is installed separately (Mac App Store or tailscale.com). Everything
else comes from `Brewfile`.

**Scope**: dotfiles provide the *infrastructure* — DNS, TLS, the reverse proxy, and
the backing services. Individual `*.test` sites are not tracked here; they differ per
machine and per project. See [Adding a new *.test site](#adding-a-new-test-site).

---

## How dnsmasq works

`dnsmasq` is a lightweight DNS server. `setup.sh` does three things:

1. Appends `address=/.test/127.0.0.1` to `$(brew --prefix)/etc/dnsmasq.conf` — this makes dnsmasq resolve every `*.test` hostname to `127.0.0.1`.
2. Writes `/etc/resolver/test` containing `nameserver 127.0.0.1` — this tells macOS to send all `.test` DNS queries to dnsmasq instead of your upstream resolver.
3. Starts dnsmasq as a **system** (root) launchd service so it's available at boot.

To verify it's working:

```sh
ping -c1 anything.test          # should resolve to 127.0.0.1
scutil --dns | grep -A3 test    # should show nameserver 127.0.0.1
```

Because dnsmasq runs as a root service, `brew services list` (without sudo) reports it
as `none` — that only means it isn't running in *your* user domain. Use
`sudo brew services list` to see its real status.

After editing `dnsmasq.conf` or `/etc/resolver/test`, restart dnsmasq and clear the
OS resolver cache:

```sh
sudo brew services restart dnsmasq
flush-dns                       # bin/flush-dns
```

---

## How Caddy works

Caddy acts as a reverse proxy, routing `*.test` hostnames to local processes. Once at
least one site is configured it listens on 443 (HTTPS) and 80 (HTTP → redirects to
HTTPS).

**A fresh install serves nothing, and that's expected.** The base `Caddyfile` contains
only global options plus an `import` glob, so with an empty `sites/` directory Caddy has
no site blocks and binds only its admin API on `127.0.0.1:2019` — nothing on 80 or 443.
A glob matching zero files is not an error. Add your first `.caddy` file and reload, and
the listeners appear.

**Local CA**: Caddy generates its own certificate authority the first time it serves a
site with `local_certs`; `caddy trust` installs that CA into the macOS Keychain so
browsers and `curl` accept `*.test` certs without warnings. `topics/caddy/setup.sh` runs
`caddy trust` for you (once, guarded by a Keychain check).

**Per-site configs**: The base `Caddyfile` imports everything in `$(brew --prefix)/etc/caddy/sites/*.caddy`. Drop a `.caddy` file there for each project. Caddy does **not** watch for file changes — after adding or modifying a site file, reload explicitly:

```sh
caddy reload --config "$(brew --prefix)/etc/Caddyfile"
# or restart the service
brew services restart caddy
```

Docs: [Caddyfile reference](https://caddyserver.com/docs/caddyfile) · [reverse_proxy](https://caddyserver.com/docs/caddyfile/directives/reverse_proxy) · [php_fastcgi](https://caddyserver.com/docs/caddyfile/directives/php_fastcgi)

---

## Adding a new *.test site

Site configs live in `$(brew --prefix)/etc/caddy/sites/<project>.caddy` — outside this
repo, by design. Which projects exist is a property of the machine, not of the dotfiles.

Each block below is a complete file. After adding or editing one, reload Caddy (see
[reload](#how-caddy-works)).

### 1. Static site

```caddy
# $(brew --prefix)/etc/caddy/sites/mysite.caddy
mysite.test {
    root * /Users/yourname/code/mysite
    file_server
    encode gzip
}
```

### 2. PHP project (via php-fpm)

php-fpm listens on `127.0.0.1:9000` by default (started by `setup.sh`).

```caddy
# $(brew --prefix)/etc/caddy/sites/myapp.caddy
myapp.test {
    root * /Users/yourname/code/myapp/public
    php_fastcgi 127.0.0.1:9000
    file_server
    encode gzip
}
```

Verify php-fpm is running:
```sh
brew services list | grep php
```

### 3. Go / Python / Node app (reverse proxy)

Run your app on a local port, then proxy it:

```caddy
# $(brew --prefix)/etc/caddy/sites/myapi.caddy
myapi.test {
    reverse_proxy 127.0.0.1:8080
}
```

Then reload Caddy:
```sh
caddy reload --config "$(brew --prefix)/etc/Caddyfile"
```

---

## Per-language project setup

### Go

Runtime managed by mise. Tooling (`golangci-lint`) via `topics/go/setup.sh`.

```sh
# Install a Go version globally
mise use --global go@latest

# Pin Go version for a project (commit .mise.toml)
cat > .mise.toml << 'EOF'
[tools]
go = "1.23"
EOF
mise install

# Run locally
go run ./cmd/server
# Add a Caddy reverse_proxy block for HTTPS
```

Docs: [mise Go plugin](https://mise.jdx.dev/lang/go.html)

### Python

```sh
# Pin Python version for a project
cat > .mise.toml << 'EOF'
[tools]
python = "3.12"
EOF
mise install

# Virtual env (mise doesn't create one automatically)
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Run dev server (e.g. FastAPI/uvicorn)
uvicorn main:app --port 8000
# Caddy: reverse_proxy 127.0.0.1:8000
```

Docs: [mise Python plugin](https://mise.jdx.dev/lang/python.html)

### Node / Bun

```sh
# Pin Node version for a project
cat > .mise.toml << 'EOF'
[tools]
node = "22"
EOF
mise install

npm install
npm run dev                        # e.g. Vite on 5173
# Caddy: reverse_proxy 127.0.0.1:5173
```

Docs: [mise Node plugin](https://mise.jdx.dev/lang/node.html)

### Rust

mise manages Rust by wrapping `rustup` under the hood — you get mise's `.mise.toml` pinning on top of the standard Rust toolchain manager.

```sh
# Install Rust via mise (installs rustup + stable toolchain)
mise use --global rust@stable

# Pin for a project
cat > .mise.toml << 'EOF'
[tools]
rust = "stable"
EOF
mise install

# Toolchain targets (still use rustup for these)
rustup target add wasm32-unknown-unknown
```

Docs: [mise Rust plugin](https://mise.jdx.dev/lang/rust.html)

### PHP

PHP is installed via Homebrew (not mise) because it's a system service (php-fpm) rather than a per-project runtime. [Composer](https://getcomposer.org/doc/) manages per-project dependencies.

```sh
composer install
php -S 0.0.0.0:8080 -t public/   # quick dev server (no FPM)
# Or use Caddy + php_fastcgi for full FPM setup (recommended)
```

---

## Mailpit (local SMTP)

[Mailpit](https://mailpit.axllent.org/docs/) catches all outbound email so nothing escapes to real addresses during development.

- **SMTP**: `127.0.0.1:1025` — configure your app to use this
- **Web UI**: `http://localhost:8025` — view all caught emails

Configure your app:

```sh
# Laravel / PHP (.env)
MAIL_MAILER=smtp
MAIL_HOST=127.0.0.1
MAIL_PORT=1025
MAIL_SCHEME=smtp      # Laravel 11+; on Laravel 9/10 use MAIL_ENCRYPTION=null

# Go (net/smtp)
smtp.SendMail("127.0.0.1:1025", nil, "from@test", []string{"to@test"}, msg)

# Python (smtplib)
server = smtplib.SMTP("127.0.0.1", 1025)
```

---

## Redis (on demand)

[Redis](https://redis.io/docs/latest/) is not auto-started. Start it when you need it:

```sh
brew services start redis     # start as background service
brew services stop redis      # stop
redis-server                  # foreground / one-off

# Default: 127.0.0.1:6379, no auth
```

---

## External access: Tailscale and ngrok

These two tools are **complementary**, not alternatives to each other.

### Tailscale — device-to-device (mesh VPN)

[Tailscale](https://tailscale.com/kb) creates a secure [WireGuard](https://www.wireguard.com)-based VPN between all your devices. Once your Mac and iPhone are both on the tailnet, your iPhone can reach `http://mac.tail….ts.net:8080` directly — no public exposure needed.

**When to use Tailscale:**
- Testing on your own iPhone, iPad, or another laptop
- Accessing your dev machine from a coffee shop
- Team members on the same tailnet reaching your local server

**[Tailscale Funnel](https://tailscale.com/kb/1223/funnel)** — public tunnel (ngrok alternative):

```sh
tailscale funnel 8080           # expose port 8080 publicly via a stable *.ts.net URL
tailscale funnel --bg 8080      # background mode
tailscale funnel off            # stop
```

Funnel is simpler than ngrok for basic cases, but lacks request inspection and replay.

Install: not managed by this repo — install from the Mac App Store or
[tailscale.com/download](https://tailscale.com/download).

### ngrok — public tunnels for webhook testing

[ngrok](https://ngrok.com/docs) creates a temporary public URL pointing to a local port. Best for external services that need to reach your machine (Stripe webhooks, GitHub webhooks, Twilio, etc.) or sharing a preview with someone who isn't on your tailnet.

**Setup** (one-time):
```sh
ngrok config add-authtoken <your-token>   # from dashboard.ngrok.com
```

**Usage**:
```sh
ngrok http 8080                              # tunnel to local port (preferred)
ngrok http --domain=yourname.ngrok.app 8080  # reserved domain (paid)
```

**Point ngrok at the app's port, not at the `*.test` hostname.** `ngrok http myapp.test`
resolves to `http://myapp.test:80`, where Caddy immediately redirects to HTTPS and the
tunnel breaks. Fronting Caddy requires rewriting the Host header *and* getting ngrok to
accept Caddy's local CA:

```sh
ngrok http https://myapp.test --host-header=myapp.test
```

That's rarely worth it — bypass Caddy and tunnel the port directly. The exception is an
app that only works behind its real hostname (absolute URL generation, cookie domains),
in which case reach for Tailscale Funnel instead.

The ngrok web UI at `http://localhost:4040` shows all requests and lets you replay them — useful for debugging webhook payloads.

**Summary**:

| Scenario                                 | Use                         |
|------------------------------------------|-----------------------------|
| Test on your iPhone                      | Tailscale                   |
| Access dev machine from another location | Tailscale                   |
| Stripe / GitHub webhook                  | ngrok (or Tailscale Funnel) |
| Share preview with external collaborator | ngrok                       |
| Need request inspection / replay         | ngrok                       |

---

## mise — runtime version manager

[mise](https://mise.jdx.dev) replaces nvm, pyenv, rbenv, asdf, etc. with a single tool. Installed via `mise.run` in `bootstrap.sh`; activated per-shell in `topics/mise.zsh`.

```sh
# See available versions
mise ls-remote go
mise ls-remote python

# Set a global default (stored in ~/.config/mise/config.toml)
mise use --global go@latest
mise use --global python@3.12

# Set a per-project version (stored in .mise.toml — commit this file)
mise use go@1.23
mise use python@3.12

# Install all tools pinned in .mise.toml
mise install

# List what's active and where it's set
mise ls
```

mise activates automatically in each directory. No shell reload needed after `mise use`.

Docs: [Getting started](https://mise.jdx.dev/getting-started.html) · [Configuration (.mise.toml)](https://mise.jdx.dev/configuration.html) · [All supported runtimes](https://mise.jdx.dev/plugins.html)

---

## Service management cheatsheet

```sh
# Status of all brew-managed services
brew services list

# Individual services
brew services start|stop|restart caddy
brew services start|stop|restart php
brew services start|stop|restart mailpit
brew services start|stop|restart redis

# dnsmasq runs as a system (root) service
sudo brew services start|stop|restart dnsmasq
```

---

## What's NOT handled here

- **PostgreSQL**: Use [Postgres.app](https://postgresapp.com) for multi-version support.
  `setup.sh` writes `/etc/paths.d/postgresapp` so `psql`, `pg_dump`, etc. resolve. Two
  related pieces *are* tracked here: `pgcli` (Brewfile) for a REPL with autocomplete, and
  `topics/postgresql/psqlrc.symlink` → `~/.psqlrc` for `psql` defaults (auto-expanded
  output, per-database history, `ON_ERROR_STOP`).
- **MySQL**: Run via Docker/OrbStack: `docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:8`
- **SSL for external access**: Caddy's local CA is not trusted by external parties — use ngrok or Tailscale Funnel.
- **LAN access from other devices**: Tailscale is the cleanest solution; manual firewall rules and DNS otherwise.
