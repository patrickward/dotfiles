---
title: "Decision Record: Storage Migration"
author: Devyn
date: 2026-09-01
subject: "Infrastructure / Platform Engineering"
distribution: "Eng leadership, Finance"
status: "Decided"
---

## Problem

The primary Postgres volume on **db-prod-01** reached 78% utilization this
week and is growing approximately 2% per week (driven mainly by the new
event-audit tables — see MEMO-2026-041). At the current trajectory we
exhaust capacity in early November. Running above 85% triggers our
documented vendor slowness threshold, and an unplanned volume resize was
measured at 18 minutes of write-outage during the July rehearsal.

We have roughly six weeks of comfortable runway.

## Options evaluated

| Option                       | 12-mo cost | Downtime | Risk profile                          |
|------------------------------|-----------:|----------|---------------------------------------|
| A. Vertical resize to 2 TB   |  $4,080    | ~15 min  | Buys 9 months; same problem recurs    |
| B. Replica + monthly partitioning | $2,280 | None    | New operational surface; well-understood pattern |
| C. Archive cold data to S3   |  $  940    | None     | Doesn't stop growth; delays, not solves |

## Analysis

Option A is the fastest fix but is pure deferral — growth continues, and
we'd re-run this exercise in Q1 at higher stakes. Option C addresses only
the audit tables, which are 40% of current volume but not the growth driver.

Option B decomposes the problem: partitions bound any single table's size,
the replica absorbs read traffic freed by offloading reporting queries,
and the migration path is incremental (one partition per maintenance
window, rollback trivial at each step). The added operational surface is
one more service in an area the team already owns.

## Decision

Adopt Option B, beginning with the two highest-growth schemas.
Charlie will own the partitioning runbook; targeting first migration
window the week of September 15.

Budget impact: net **−$180/mo** versus status quo, reflected in the
October forecast revision.

## Appendix: rejection notes

- *Option A rejected*: revisit only if partitioning slips past October.
- *Option C rejected as primary*: retained as a complementary measure
  for pre-2024 audit data (separate micro-decision, no exec review needed).