# tstack

The agent skills I use every day, cleaned up so anyone can use them.

This fork runs on Claude alone: every reviewer is a Claude subagent, so one
Claude subscription is all it needs. Upstream
([t3dotgg/tstack](https://github.com/t3dotgg/tstack)) mixes in GPT and Gemini
reviewers and supports Codex. Some skills use
[T3 Code](https://github.com/pingdotgg/t3code) features when they are
available and fall back to Claude Code's native tools when they are not.

## Skills

| Skill | Say | What it does |
|---|---|---|
| `full-send` | "full send" | Takes a change to a merged PR with nobody watching: proves it, reviews it, files it, babysits it, merges it. |
| `full-stop` | "full stop" | Same as `full-send`, but stops when the PR is ready for you to merge. |
| `council` | "council" | Gets review from three Claude models (Opus, Fable, Sonnet), each with its own lens, and loops until they agree. |
| `review-loop` | "review loop" | Reviews a change with a fresh Claude Opus subagent in a loop until both agents agree. |
| `file-pr` | "file a PR" | Files a short PR that leads with the problem, not an inventory of changes. |
| `takeover` | "take over" | Finishes someone else's PR, branch, or agent thread, and keeps their credit. |
| `babysit-pr` | "babysit" | Watches a PR through CI and review bots, and fixes the real findings. |
| `modernize` | "modernize" | Rebases an old PR and decides if it should still exist. |
| `leaving-pr-comments` | (automatic) | Formats comments that an agent posts on your behalf. |

Some skills call others. Install the ones they need too:

- `full-send` uses `review-loop`, `file-pr`, and `babysit-pr`.
- `full-stop` uses `full-send`.
- `takeover` uses `modernize`, `file-pr`, `babysit-pr`, and `leaving-pr-comments`.
- `file-pr`, `babysit-pr`, and `modernize` use `leaving-pr-comments`.

## Install

```bash
git clone https://github.com/johnmmcg/tstack
tstack/install.sh
```

`install.sh` symlinks each skill into `~/.claude/skills`, so a `git pull` in
the clone updates them all. It won't replace a skill you already have; pass
`--force` to replace one that's a symlink to somewhere else.

## Requirements

- An authenticated [GitHub CLI](https://cli.github.com) (`gh`).
- `python3` for `babysit-pr`'s `pr-wait` script.
- `council` and `review-loop` start subagents with the Agent tool's `model`
  override (`opus`, `fable`, `sonnet`). No other provider is needed.

## Pulling upstream

`main` tracks upstream; the Claude-only changes live on `claude-only`.

```bash
git fetch upstream && git switch main && git merge upstream/main
git switch claude-only && git rebase main
```

## Make them yours

These are starting points. Edit them. Put personal settings, like which models
sit on your council, in your `CLAUDE.md` or `AGENTS.md`, so you can update the
skills without losing them.

## License

[MIT](LICENSE)
