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
