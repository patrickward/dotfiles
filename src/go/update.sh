#!/usr/bin/env bash

# If golangci-lint doesn't exist in "$(go env GOPATH)/bin" then add it
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin" v1.60.2

