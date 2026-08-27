#!/usr/bin/env bash
# topics/go/setup.sh
#
# Install golangci-lint using go install (uses Go's module verification,
# safer than curl | sh).
#
# Note the /v2 in the module path: the unversioned path
# (github.com/golangci/golangci-lint/cmd/...) stops at v1.64.8 and will
# silently install a stale v1 release.

. "$DOTFILES/lib/utils.sh"

if ! command -v go &>/dev/null; then
    warn "Go not found — install Go first (mise install go), then re-run zdot setup go"
    exit 0
fi

if ! command -v golangci-lint &>/dev/null; then
    info "Installing golangci-lint..."
    go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
    okay "golangci-lint installed"
else
    okay "golangci-lint already installed ($(golangci-lint --version 2>/dev/null | head -1))"
fi
