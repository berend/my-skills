# My skills

since I wanted to manage my agentioc coding skills in git to install them via skills.sh, I am setting them up here.


### Inspiration:
All this was copied from https://github.com/mattpocock/skills and then adjusted

### My variant

I wanted my agentic coding to be simple, markdown file based and easy to reproduce/understand.

In this agentic coding flow one PRD (product requirements document) is created.
From that, several ISSUE files are created. Then in a ralüh loop, one issue after another is given to the AI to tackle.

Install skills via
```
npx skills@latest add berend/my-skills/grill-me
npx skills@latest add berend/my-skills/write-a-prd
npx skills@latest add berend/my-skills/prd-to-issues
npx skills@latest add berend/my-skills/grill-me-context
npx skills@latest add berend/my-skills/aicommit
npx skills@latest add berend/my-skills/multi-service-mr-review
```

and copy the `ralph` script into your `~/bin` (or something that is in your path)
Here is a normal workflow:

1. open your coding harness of choise (this repo is currently tailored for `claude`)
2. identify a work item/problem to solve
3. start claude in your project folder
4. "/grill-me I want to switch from sqlite to postgres. Walk me throguh this"
5. You will get asked a lot of questions. Take your time, answer them all.
6. "/write-PRD"
7. the AI creates a file in .PRD/<some-fitting-name>.md
8. read it, adjust if needed, most times you can just continue
9. "/prd-to-issues"
10. the AI create a list of smaller, broken down todos from the PRD file
11. close coding harness
12. start the `ralph` loop

After a run, you are still left with the PRD file, all completed ISSUES are deleted once they are completed. 

every issue should be in one git commit.

# Note

claude is somehow deprecated since Anthropic remove `-p` from subscription plans. I switched to OpenAIs chatGPT models for now. The `ralph-claude` is there for reference.

# AI commit overview

Use `glab-ai-overview` inside a GitLab project to summarize how many recent commits are marked with `AI-Assisted: true`.

```sh
./glab-ai-overview --since-days 14
```

To scan all non-archived GitLab projects where your `glab` user is a member:

```sh
./glab-ai-overview --all-projects --since-days 14
```

Note: For --all-projects to work, you also need to be in a git repo, because the server is determined by the origin from the current repo.



Example output:

```text
Date range: 2026-05-15 to 2026-05-29
Projects with commits: 12
Total commits: 42
AI-assisted commits: 31
AI-assisted share: 73.8%

AI-Model:
  openai/gpt-5.5: 55.0%
  openai/gpt-5.4: 45.0%

AI-Agent:
  opencode: 80.0%
  codex: 10.0%
  <unknown>: 10.0%
```

Without `--since-days`, the script defaults to the last 7 days. Without `--all-projects`, it only scans the current GitLab project. It uses `glab api`, so authentication is handled by the installed `glab` CLI.
