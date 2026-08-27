#!/usr/bin/env bash
# topics/go/update.sh

. "$DOTFILES/lib/utils.sh"

if ! command -v go &>/dev/null; then
    warn "Go not found"
    exit 0
fi

info "Updating golangci-lint..."
# /v2 is required — the unversioned module path stops at v1.64.8
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
okay "golangci-lint updated"
