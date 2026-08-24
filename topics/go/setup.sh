#!/usr/bin/env bash
# topics/go/setup.sh
#
# Install golangci-lint using go install (uses Go's module verification,
# safer than curl | sh).

. "$DOTFILES/lib/utils.sh"

if ! command -v go &>/dev/null; then
    warn "Go not found — install Go first (mise install go), then re-run zdot setup go"
    exit 0
fi

if ! command -v golangci-lint &>/dev/null; then
    info "Installing golangci-lint..."
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    okay "golangci-lint installed"
else
    okay "golangci-lint already installed ($(golangci-lint --version 2>/dev/null | head -1))"
fi
