# topics/go/go.zsh
#
# Go language configuration.
# Managed via mise for version management: mise install go

if command -v go &>/dev/null; then
    export GOPATH="$(go env GOPATH)"
    path=("$GOPATH/bin" $path)
fi

# GOPRIVATE: set in ~/.localrc for private module paths
# export GOPRIVATE=github.com/myorg/*

alias gotask='go tool task'  # Run go tool task
