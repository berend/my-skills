---
name: aicommit
description: Create git commits with AI-Assisted trailers for later analysis. Use when the user asks to commit, create a git commit, or mark a commit as AI-assisted.
---

# AI-Assisted Commit

Use this skill when creating a git commit that should be marked as AI-assisted.

## Goal

Create normal, high-quality git commits while adding stable commit trailers that make AI-assisted commits easy to analyze later.

## Required Workflow

Before committing:

1. Inspect the working tree with `git status`.
2. Inspect the changes with `git diff` and, if relevant, staged changes with `git diff --staged`.
3. Inspect recent commit style with `git log --oneline -10`.
4. Stage only the files that belong to the requested change.
5. Do not stage unrelated user changes.
6. Write a concise commit message matching the repository's existing style.
7. Add the AI trailers with `git commit --trailer` when available. If `--trailer` is unavailable, place the same trailer lines manually at the very end of the commit message.

## Trailer Format

Always include:

```text
AI-Assisted: true
```

Include `AI-Agent` only when the coding harness explicitly provides the agent identity. Do not guess.

```text
AI-Agent: opencode
```

Include `AI-Model` only when the coding harness explicitly provides the model identity. Do not guess. Prefer canonical provider/model IDs over marketing names.

```text
AI-Model: openai/gpt-5.5
```

If the agent or model identity is not available from the harness, omit that trailer rather than inventing a value.

Prefer this form when committing:

```sh
git commit -m "Add skill for AI-assisted commits" \
  --trailer "AI-Assisted=true" \
  --trailer "AI-Agent=opencode" \
  --trailer "AI-Model=openai/gpt-5.5"
```

Omit `AI-Agent` or `AI-Model` from the command if the harness does not explicitly provide those values.

## Commit Message Example

```text
Add skill for AI-assisted commits

AI-Assisted: true
AI-Agent: opencode
AI-Model: openai/gpt-5.5
```

## Rules

- Keep the trailers at the very end of the commit message.
- Prefer `git commit --trailer` over writing trailer lines manually.
- Use exactly `AI-Assisted`, `AI-Agent`, and `AI-Model` as trailer keys.
- Do not add `Co-authored-by` unless the user explicitly asks for it.
- Do not commit secrets, generated junk, or unrelated files.
- If tests or checks were run, mention the result to the user after committing, not in the trailers.
