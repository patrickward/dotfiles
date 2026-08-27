# PHP

This topic manages machine-level PHP runtime setup: global PHP extensions and
tooling that Composer cannot install.

PHP itself is installed by Homebrew. Composer remains responsible for
per-project PHP dependencies.

---

## Scope

This topic is for global/native PHP requirements such as PECL extensions:

- `imagick`
- `redis`
- optionally `xdebug`, `pcov`, `grpc`, etc. if you decide to add them later

It is **not** for project packages such as Laravel, Symfony, Pest, Guzzle, or
Intervention Image. Those belong in each project's `composer.json`.

---

## Composer vs PECL

Composer installs PHP libraries into a project:

```sh
composer install
composer require vendor/package
```

Composer can also declare that a project needs a PHP extension:

```json
{
  "require": {
    "ext-imagick": "*",
    "ext-redis": "*"
  }
}
```

But Composer does not install those extensions. It only checks whether the
currently active PHP runtime has them loaded.

PECL installs native PHP extensions into the PHP runtime:

```sh
pecl install imagick
pecl install redis
```

So the division is:

| Layer | Tool | Example |
|---|---|---|
| System package | Homebrew | `php`, `imagemagick` |
| PHP extension | PECL | `imagick`, `redis` |
| Project package | Composer | `laravel/framework`, `guzzlehttp/guzzle` |
| Project requirement check | Composer | `ext-imagick`, `ext-redis` |

---

## Default extensions

`setup.sh` installs a conservative global extension set:

| Extension | Why |
|---|---|
| `imagick` | Common image-processing extension; requires ImageMagick libraries |
| `redis` | Common cache/session/queue extension for Laravel and other PHP apps |

If a project needs one of these, still declare it in that project's
`composer.json`:

```json
{
  "require": {
    "ext-imagick": "*",
    "ext-redis": "*"
  }
}
```

That way the project documents its real runtime requirements, and Composer can
fail early if a machine is missing something.

---

## Native dependencies

Some PECL extensions need system libraries to build.

For `imagick`, ImageMagick must be installed with Homebrew before running the PHP
topic:

```ruby
brew "imagemagick"
```

Verify Homebrew sees it:

```sh
brew list --formula imagemagick
brew --prefix imagemagick
```

Then run the normal dotfiles setup again.

---

## Verify PHP extensions

List loaded extensions:

```sh
php -m
```

Check a specific extension:

```sh
php -r 'var_dump(extension_loaded("imagick"));'
php -r 'var_dump(extension_loaded("redis"));'
```

Show PHP configuration files:

```sh
php --ini
```

Show the extension scan directory:

```sh
php -r 'echo PHP_CONFIG_FILE_SCAN_DIR ?: "(none)"; echo PHP_EOL;'
```

Show the extension directory:

```sh
php -i | grep extension_dir
```

---

## php-fpm

After installing or changing extensions, `setup.sh` restarts Homebrew's PHP
service so `php-fpm` sees the new extension state.

Check service status:

```sh
brew services list | grep php
```

Restart manually:

```sh
brew services restart php
```

---

## Adding another extension

Add another call in `setup.sh`:

```sh
install_pecl_extension "pcov"
```

For packages where the PECL package name differs from the loaded extension name,
pass both names:

```sh
install_pecl_extension "some_extension_name" "some-pecl-package"
```

Keep the default list small. If an extension is only needed by one project, it may
be better to document it in that project's setup notes and require it via
`composer.json` as `ext-*`.