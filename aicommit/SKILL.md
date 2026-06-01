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

Also include `AI-Agent` and `AI-Model` when they can be resolved by the Harness Identity Resolution rules.

Prefer this form when all values are available:

```sh
git commit -m "Commit message" \
  --trailer "AI-Assisted=true" \
  --trailer "AI-Agent=<resolved-agent>" \
  --trailer "AI-Model=<resolved-model>"
```

Omit only the unresolved trailer if either `AI-Agent` or `AI-Model` cannot be resolved.

## Harness Identity Resolution

Before committing, derive trailer values from explicit coding harness context.

Use `AI-Agent` when the harness explicitly names the coding agent or product identity. Normalize to a stable lowercase identifier when the identity is unambiguous.

Examples:

- "You are Codex" -> `AI-Agent: codex`
- "You are opencode" -> `AI-Agent: opencode`

Use `AI-Model` when the harness explicitly names the model identity. Prefer canonical provider/model IDs when the provider is explicit or obvious from the harness.

Examples:

- "based on GPT-5" in an OpenAI/Codex harness -> `AI-Model: openai/gpt-5`
- "openai/gpt-5.5" -> `AI-Model: openai/gpt-5.5`
- "claude-sonnet-4" in an Anthropic harness -> `AI-Model: anthropic/claude-sonnet-4`

If either value is not explicitly available from the harness context, omit only that trailer. Do not infer values from general knowledge, marketing names, or user preference unless the user explicitly provides the trailer value for this commit.

## Commit Message Example

```text
Commit message

AI-Assisted: true
AI-Agent: <resolved-agent>
AI-Model: <resolved-model>
```

## Rules

- Keep the trailers at the very end of the commit message.
- Prefer `git commit --trailer` over writing trailer lines manually.
- Use exactly `AI-Assisted`, `AI-Agent`, and `AI-Model` as trailer keys.
- Do not add `Co-authored-by` unless the user explicitly asks for it.
- Do not commit secrets, generated junk, or unrelated files.
- If tests or checks were run, mention the result to the user after committing, not in the trailers.
