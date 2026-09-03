# Show the current Finder window directory (macOS)
pfd() {
    [[ "$OSTYPE" != darwin* ]] && { echo "pfd is macOS only"; return 1; }

    osascript 2>/dev/null <<EOF
tell application "Finder"
    return POSIX path of (target of first window as text)
end tell
EOF
}

# Show the current Finder selection (macOS)
pfs() {
    [[ "$OSTYPE" != darwin* ]] && { echo "pfs is macOS only"; return 1; }

    osascript 2>&1 <<EOF
tell application "Finder" to set the_selection to selection
if the_selection is not {}
    repeat with an_item in the_selection
        log POSIX path of (an_item as text)
    end repeat
end if
EOF
}
