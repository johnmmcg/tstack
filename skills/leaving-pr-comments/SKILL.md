---
name: leaving-pr-comments
description: Use whenever leaving comments on GitHub.
---

# Leaving PR Comments

End every agent-authored comment left on the user's behalf with a blank line
and this footer, on its own line:

```md
Actual comment here.

_Co-written with Claude Code_
```

Keep it to that one footer. Do not add a note callout, horizontal rule,
heading, signature, or a second attribution.

The comment goes out under the user's name, so never claim they did work an
agent did. "I checked", "I traced" and "I verified" are only for what the user
did themselves. Name the agent for its work ("Claude traced...", "Claude
checked on the branch..."), and keep "I" for the user's own calls and
commitments.

Apply this format to top-level PR comments, inline review comments, replies to
bots or reviewers, and written explanations used before resolving or
dismissing feedback. Do not add it to PR descriptions, commit messages, or text
the user explicitly asked to post verbatim without attribution.

Write the comment itself in a direct style:

- Lead with the conclusion.
- Cite the relevant code, behavior, check, or reproduction.
- Keep it concise and avoid filler, canned thanks, or status narration.
- Distinguish verified facts from judgment.

Preview the final Markdown before posting so quoting and blank lines render as
shown. After posting, verify that GitHub returned the comment or review URL.
Resolve a review thread only after its response was posted successfully.
