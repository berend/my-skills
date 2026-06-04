---
name: multi-service-mr-review
description: Review several checked-out merge requests across connected microservices in sibling git repositories. Use when the user wants a cross-service MR review that compares each service branch to master/main, finds service-local and cross-service inconsistencies, and produces major and minor review issues.
---

# Multi-Service MR Review

Use this skill when the workspace has this shape:

```text
/
/microservice1
/microservice2
/...
```

Each microservice directory is its own git repository, and the merge request branch to review is already checked out.

## Process

### 1. Discover service repositories

Find immediate child directories that contain `.git`.

For each service, capture:

- current branch
- clean/dirty working tree state
- comparison base, preferring `master`, then `origin/master`, then `main`, then `origin/main`
- changed files and diff summary against the comparison base

If no comparison base can be found for a service, ask the user which base branch to use before reviewing that service.

### 2. Review each service locally

For every service, compare the checked-out branch to the base branch.

Look for:

- correctness bugs
- security issues
- data loss or migration risks
- backward/forward compatibility problems
- API contract changes
- event/message schema changes
- auth, permissions, tenancy, and privacy mistakes
- missing feature flags or rollout controls
- test coverage gaps for risky behavior
- operational risks such as logging, metrics, retries, timeouts, idempotency, and deployment order

Prefer concrete evidence from diffs and surrounding code over speculation. Use file paths relative to the service directory.

### 3. Review across services

After reviewing each service locally, compare the changes between services.

Look for inconsistencies in:

- naming, types, validation rules, defaults, and enum values
- endpoint paths, request/response DTOs, status codes, error shapes, and pagination
- event names, topics, payload schemas, producers, and consumers
- database migrations, model assumptions, seed data, and cleanup jobs
- feature flags, configuration keys, environment variables, and rollout behavior
- auth scopes, permissions, tenant boundaries, and ownership checks
- backwards compatibility, deployment sequencing, and partial rollout behavior
- duplicated logic that has diverged in a meaningful way

Treat cross-service mismatches as high signal. A change that is safe inside one service can still be a major issue if another service expects a different contract.

### 4. Triage candidate issues interactively

Build a list of candidate issues from the local and cross-service review. Do not put every candidate directly into the final review.

You must step through every candidate issue one by one before writing the final review text. Do not summarize all candidates at once. Do not skip the triage loop. Do not produce the final review until every candidate has been explicitly classified as skipped, minor, or major.

For each candidate, present a broad but concrete description:

- candidate number, for example `Candidate 3 of 8`
- short title
- affected service(s)
- affected file(s)
- what changed
- why it might matter
- what would make it a real merge blocker

Use this candidate prompt shape:

```md
**Candidate 3 of 8: Inconsistent Customer Status Handling**
services: customer-service, billing-service
files: [./customer-service/src/status.go](./customer-service/src/status.go), [./billing-service/src/customer_status.go](./billing-service/src/customer_status.go)

What changed: customer-service now emits a new status, while billing-service still has the old status mapping.

Why it might matter: a partial deployment could make billing treat an unknown suspended status as active.

Merge-blocker threshold: this is major if billing can receive the new value before it is updated, or if unknown statuses default to active behavior.
```

Use interactive tooling when available to offer exactly these choices:

1. Skip this issue for the review
2. Create a one-liner for this issue in the final review text
3. Major issue, drill down deeper here with follow-up questions to create a major issue

Then stop and wait for the user's choice before moving to the next candidate. If interactive tooling is not available, ask the user to choose `1`, `2`, or `3` and wait for their answer.

If the user chooses `1`, discard the candidate.

If the user chooses `2`, add it to the minor issues/warnings section as a one-liner.

If the user chooses `3`, investigate deeper before writing it up:

- read the relevant surrounding code
- inspect callers, callees, tests, schemas, migrations, config, and consumers/producers as needed
- check whether the issue is service-local or cross-service
- ask follow-up questions only when the code cannot answer the question

After the deeper pass, show the user the refined finding and ask whether to keep it as a major issue, downgrade it to a minor one-liner, or skip it. Only keep it as a major issue if the deeper pass confirms it needs to be fixed before merge and the user accepts that classification.

### 5. Write the final review text

The final answer should be review text that the user can paste into the merge request discussion.

Use two sections:

```text
Major issues

...

Minor issues / warnings

...
```

Major issues must follow this format:

```md
**Possible SQL Injection:**
files: [./src/my_first_orm_wrapper.go](./src/my_first_orm_wrapper.go), [./src/orm_string_helpers.go](./src/orm_string_helpers.go)

User input is not filtered, escaped or parametrized when building SQL commands. This is a real security issue and needs to be fixed urgently.
```

Use Markdown formatting so the review is visually scannable in Codex output:

- major issue headlines must be bold: `**Possible SQL Injection:**`; in Codex this renders as a white bold headline
- file names must be Markdown links: `[./src/file.go](./src/file.go)`; in Codex these render as light-blue linked paths
- keep the `files:` label plain
- keep the issue body as normal text

For cross-service major issues, include service names in the title or file paths, for example:

```md
**Inconsistent Customer Status Contract:**
files: [./customer-service/src/status.go](./customer-service/src/status.go), [./billing-service/src/customer_status.go](./billing-service/src/customer_status.go)

The customer service now emits `suspended_pending_review`, but billing still treats unknown customer states as active. This can allow suspended customers to continue billing-sensitive flows after a partial deployment.
```

Minor issues/warnings should be one-liners unless the user asks for more detail.

If no major issues are confirmed, write `No major issues found.` under `Major issues`. If no minor issues are selected, write `No minor issues selected.` under `Minor issues / warnings`.
