---
title: "API Platform Redesign Proposal"
subtitle: "Phase 1 — Authentication and Core Services"
author: "FooBar, Inc."
date: September 2026
client: "Company1"
version: "1.2"
---

# Executive Summary

Scope, timeline, and cost for migrating the legacy auth service to an
OAuth 2.1 / OIDC platform, delivered in three phases over 14 weeks.

# Objectives

1. Eliminate the custom session-token implementation
2. Enable SSO for enterprise customers
3. Reduce auth-related incident load (currently 4–6 tickets/month)

# Why Now

The legacy auth service reached end of vendor support in June. Every
additional month extends exposure to unpatched CVEs and increases the
migration surface as customer count grows. Starting in October completes
the work before your January enterprise renewals — after which SSO
requirements from three pending deals become contractual commitments.

# Approach

We propose a strangler-pattern migration rather than a cutover: the new
OIDC broker sits in front of the legacy service, accepts traffic
incrementally, and the legacy service is decommissioned only after a
full billing cycle of zero-session fallback. This trades two weeks of
extra build time for the ability to roll back at any point — which,
given the July incident history in this subsystem, we consider mandatory.

# Phased Delivery

## Phase 1 — Foundation (weeks 1–5)

Identity provider selection, OIDC broker service, token introspection
endpoint. Exit criteria: two internal services authenticating via OIDC.

## Phase 2 — Migration (weeks 6–11)

Client migration with dual-read fallback...

# Investment

| Item                        | Type  | Estimate    |
|-----------------------------|-------|-------------|
| Phase 1 — Foundation fiddle faddle foobar       | Fixed | $28,000     |
| Phase 2 — Migration  fiddle faddle foobar       | Fixed | $34,000     |
| Phase 3 — Harden & hand off | Fixed | $16,000     |
| **Total**                   | Fixed | **$78,000** |

# Assumptions and Exclusions

- Client provides staging environment access by kickoff
- Scope excludes legacy SAML support (quoted separately)
