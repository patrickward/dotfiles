# infocmp -x | ssh myserver -- tic -x -

# zref: Sets the terminfo on a remote ssh host to the current terminfo
# Use when you get the error 'unknown terminal type' message on a remote host
terminfo-on-remote() {
  if [[ $# -lt 1 ]]; then
    echo "usage: terminfo-on-remote <host>" >&2
    echo "Uses ssh to copy the terminfo to the remote host" >&2
    echo "Use when you get the error 'unknown terminal type' message on a remote host" >&2
    return 2
  fi

  host="$1"
  infocmp -x | ssh "$host" -- tic -x -
}
