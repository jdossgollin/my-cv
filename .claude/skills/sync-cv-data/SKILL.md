---
name: sync-cv-data
description: Use when the user wants to refresh my-cv-data/ from sibling repos (proposals, peer-review). Reads each source's own aggregated form, diffs against current CV data, surfaces discrepancies as questions, and only writes with user approval.
---

# Sync CV data

Sibling repos are canonical for their domains. This skill pulls their already-aggregated outputs into `my-cv-data/`. One-way (source → CV) unless explicitly noted.

## Sources

Try each path in order; first existing wins. If none exist, collect the miss and ask once at the end (batched), not per-source.

| Name | Candidate paths | Source file | Feeds CV file | Direction |
|---|---|---|---|---|
| proposals | `~/Documents/proposals` | `registry.yml` (already aggregated by `scripts/sync_proposals.py`) | `my-cv-data/grants.yml` | one-way, **funded only** (`status` ∈ {`active`, `complete`}) |
| peer-review | `~/Documents/peer-review` | year folders (one dir per review) | `my-cv-data/review.yml` | one-way |
| career-dossier | `~/Documents/personal/career-dossier` | TBD | TBD | **pending — do not sync** |

Path fallbacks are a list so the same skill works across machines. If a path misses, ask the user once for the correct location (or permission to search), then add it to the list in this file.

## Workflow

1. **Probe.** For each source, check candidate paths. Collect misses.
2. **Batch-ask misses.** If anything is missing, ask the user in one message: "Couldn't find X, Y. Where are they, or should I search?" Update the paths list in this file with their answer.
3. **Per active source, diff.**
   - `proposals`: load `proposals/registry.yml` and `my-cv-data/grants.yml`. Match on `id`. Report: new in source, missing from source, fields changed.
   - `peer-review`: enumerate unique venues across year folders. Compare to names in `review.yml`. Report: venues reviewed-for but not listed.
4. **Present findings, ask before writing.** Group by source. For each change, state what would change and why. Get explicit approval before editing `my-cv-data/`.
5. **Handle conflicts as questions.** If both sides changed the same field differently, do not auto-resolve — ask.
6. **Never write back to a source repo** unless the user says so and the source's `direction` allows it.

## When not to run

- Don't run on every conversation — this is an explicit "sync my CV data" task.
- Don't touch `career-dossier` until its role is decided.

## Updating this skill

When paths change, sources are added, or a sync surfaces a recurring convention (e.g., a field mapping proposals→grants that should always apply), edit this file directly. The table is the config.
