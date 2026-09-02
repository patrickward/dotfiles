---
title: "FooBar Engineering Handbook"
subtitle: "Conventions, tooling, and procedures"
author: "FooBar, Inc."
date: 2026-09-01
version: "2.1"
---

# Toolchain

## Required versions

Go ≥ 1.23, pandoc ≥ 3.5, TeX Live 2025+. Verify with `./scripts/check-env.sh`.

## pandoc conventions

All client PDFs are built via `mkpdf <brand> <preset>`. Never invoke
pandoc directly for branded output — brand identity lives only in
`brands/*.yaml`.

# Go Style

## Project layout

Standard layout; internal packages under `internal/`. No god objects,
no interface proliferation — define interfaces at the consumer.

# Release Process

1. Tag on main: `git tag -s v<semver>`
2. CI builds and attaches artifacts
3. Draft release notes from merged PRs; edit for humans, not robots
