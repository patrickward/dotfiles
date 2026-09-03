# Homebrew
<!-- zref: Useful Homebrew commands for -->

A few useful brew commands for comparing what's installed vs what's in the Brewfile.

### See what's installed but not in your Brewfile:

```bash
brew bundle cleanup --file=topics/homebrew/Brewfile
```

This lists what would be removed (doesn't actually remove anything without --force).

### See what's in your Brewfile but not installed:

```bash
brew bundle check --file=topics/homebrew/Brewfile
```

Reports any missing entries.

### See all installed casks:

```bash
brew list --cask
```

### See all installed formulae:

```bash
brew list --formula
```

### Dump everything currently installed into a Brewfile (useful for comparing):

```bash
brew bundle dump --file=/tmp/Brewfile.current
diff topics/homebrew/Brewfile /tmp/Brewfile.current
```

The dump file can be used to compare against the Brewfile. DIFF will show you what's different.

For example, if you run `diff topics/homebrew/Brewfile /tmp/Brewfile.current`, you'll see a list of differences between the Brewfile and the dump file. This can help you identify any packages that are installed but not tracked in the Brewfile, or any packages that are in the Brewfile but no longer installed.
