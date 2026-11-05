---
name: council
description: Trigger this if the user says 'council'.
---

# Council

Before an audit, address outstanding PR comments, fix known issues, and run
relevant checks. Give council the updated implementation; do not defer known
fixes until reviews return. If the user wants to discard the implementation
and explore new ideas, skip fixes to code being replaced.

Bring in three delegates to help with the user's request, usually for review
or feedback. This fork is Claude-only, so the council is three Claude models:
Opus, Fable, and Sonnet. If the user's instructions name council members, use
those.

Three Claude models share more blind spots than three providers would, so give
each one a lens as well as the shared request:

- **Opus: correctness.** Bugs, broken callers, wrong behavior in the intended
  case.
- **Fable: the user's goal.** Does the change do what was asked, and nothing
  more? Flag scope creep and missing pieces.
- **Sonnet: the reader.** Is it simple, idiomatic for this repo, and easy to
  maintain? Prefer findings that delete code.

Each delegate still reports anything serious outside its lens.

Start them with the Agent tool, all three in one message so they run in
parallel: `subagent_type: "general-purpose"`, `model: "opus"` / `"fable"` /
`"sonnet"`, `run_in_background: false`. Do not use a fork; forks inherit your
context and your conclusions. In T3 Code, use the same native Agent tool (a
Claude child needs no `delegate_task`). If a model is unavailable, report it
instead of substituting.

Give each delegate the request and relevant context. For review or feedback,
keep their work read-only. Collect their responses and summarize the useful
findings, disagreements, and recommended next steps.

For a code review, ask each delegate for a score out of 10.
Count each full review pass as one round.
A fresh review after fixes starts a new round.

If the work ends in a pull request, put the results in the PR description.
Put this section before the model and harness line at the end:

```markdown
## Council review

Rounds: 2

| Delegate | Round 1 | Round 2 |
| --- | --- | --- |
| Claude Opus (correctness) | 7/10 | 9/10 |
| Claude Fable (goal) | 8/10 | 10/10 |
| Claude Sonnet (reader) | 7/10 | 9/10 |
```

If a delegate gives no score, write `no score`. Do not invent one.
If the PR is open, edit the description. Do not post a comment for this.
If there is no PR, put the same results in the final reply only.

If you agree with their recommendations, make the changes and request a fresh
review after. Continue this process until all delegates are satisfied with the
outcome.

Do not let repeated reviews result in scope creep. It is your job to fight to
keep scope limited.
