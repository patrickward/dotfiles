---
title: "Engagement Quote — Billing Reconciliation Service"
subtitle: "Proposal No. OCT-2026-114"
author: "FooBar, Inc."
date: 2026-09-01
client: "Meridian Financial Group"
contact: "J. Okafor, VP Engineering"
valid_until: "2026-09-30"
---

## Background

During the August 12 discovery call, your team identified that invoice
discrepancies between Meridian's billing platform and its payment processor
are currently reconciled by hand — approximately 20 hours per month of
senior-accountant time, with an estimated 3–5% residual error rate. This
quote covers the discovery and delivery of an automated reconciliation
service addressing that workflow.

## Scope of Work

### Phase 1 — Discovery and Specification (fixed fee)

A two-week engagement producing:

- A documented map of all data flows between your billing platform,
  the processor's settlement reports, and your ledger
- An agreed reconciliation rule set (tolerances, exception categories,
  escalation thresholds), reviewed and signed off by your finance team
- A technical specification for the reconciliation service, suitable
  for competitive bidding if you choose not to proceed with Phase 2

### Phase 2 — Implementation (estimated)

Build and deployment of the reconciliation service per the Phase 1
specification, including:

- Ingestion of daily settlement reports (SFTP and API pull)
- Rule-based matching engine with configurable tolerances
- Exception queue with email notification and a simple web UI for
  your finance staff to review and resolve discrepancies
- Monthly reconciliation report (PDF) archived to your document store

## Pricing

| Line item                                         | Type     | Amount      |
|---------------------------------------------------|----------|-------------|
| Phase 1 — Discovery and specification             | Fixed    | $ 9,600     |
| Phase 2 — Implementation (estimate, 120 h @ $185) | Capped   | $22,200     |
| Optional: 3-month support retainer (10 h/mo)      | Optional | $ 5,550     |
| **Total (Phases 1–2)**                            |          | **$31,800** |

Phase 2 is billed against the estimate at actual hours, capped as shown —
you will not be invoiced above the cap without written change approval.

## Terms

- **Validity:** This quote is valid through September 30, 2026.
- **Payment:** Phase 1 invoiced on signing, net 15. Phase 2 invoiced
  biweekly against reported hours.
- **Schedule:** Phase 1 can begin within two weeks of acceptance.
  Phase 2 starts on Phase 1 sign-off; estimated duration 8 weeks.
- **Out of scope:** Processor-side API changes, ERP integration,
  historical data migration (quotable separately).

## Acceptance

Signature below constitutes acceptance of the scope and terms above.

Client: _________________________  Date: ___________
FooBar: ______________  Date: ___________