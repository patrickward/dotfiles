#!/usr/bin/env bash
# topics/go/update.sh

. "$DOTFILES/lib/utils.sh"

if ! command -v go &>/dev/null; then
    warn "Go not found"
    exit 0
fi

info "Updating golangci-lint..."
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
okay "golangci-lint updated"
