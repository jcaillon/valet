# Valet contributor's guide

In this page, you will find instructions on how to report issues, suggest new features, and submit contributions via Pull Requests (PRs).

---

## Before you start, file an issue

Please follow this simple rule to help us eliminate any unnecessary wasted effort & frustration, and ensure an efficient and effective use of everyone's time - yours, ours, and other community members':

> 👉 If you have a question, think you've discovered an issue, would like to propose a new feature, etc., then find/file an issue **BEFORE** starting work to fix/implement it.

### Search existing issues first

Before filing a new issue, search existing open and closed issues first.

If no existing item describes your issue/feature, great - please file a new issue:

### File a new Issue

- Don't know whether you're reporting an issue or requesting a feature? File an issue
- Have a question that you don't see answered in docs, videos, etc.? File an issue
- Want to know if we're planning on building a particular feature? File an issue
- Got a great idea for a new feature? File an issue/request/idea
- Don't understand how to do something? File an issue
- Found an existing issue that describes yours? Great - upvote and add additional commentary / info / repro-steps / etc.

When you hit "New Issue", select the type of issue closest to what you want to report/ask/request.

### Complete the template

**Complete the information requested in the issue template, providing as much information as possible**.

The more information you provide, the more likely your issue/ask will be understood and implemented.

- Don't assume we're experts in setting up YOUR environment and don't assume we are experts in `<your distro/tool of choice>`. Teach us to help you!
- **We LOVE detailed repro steps!** What steps do we need to take to reproduce the issue? Assume we love to read repro steps. As much detail as you can stand is probably _barely_ enough detail for us!
- If you're reporting a particular character/glyph not rendering correctly, the specific Unicode codepoint would be MOST welcome (e.g. U+1F4AF, U+4382)
- Prefer error message text where possible or screenshots of errors if text cannot be captured
- We MUCH prefer text command-line script than screenshots of command-line script.
- **If you intend to implement the fix/feature yourself then say so!** If you do not indicate otherwise we will assume that the issue is our to solve.

---

## Development

### Fork, Clone, Branch and Create your PR

Once you've discussed your proposed feature/fix/etc. with a team member, and you've agreed an approach, it's time to start development:

1. Fork the repo if you haven't already
2. Clone your fork locally
3. Create & push a feature branch
4. Create a [Draft Pull Request (PR)](https://github.blog/2019-02-14-introducing-draft-pull-requests/)
5. Work on your changes
6. Build and see if it works.

> [!IMPORTANT]
> Please check [docs/working-on-bash-scripts.md](docs/working-on-bash-scripts.md) to learn more about working on bash scripts and create performant scripts.

### Testing

Testing is a key component in the development workflow. In this project, we use the approval test approach to validate changes and make sure we did not break an existing feature.

Any new feature that you implement should be accompanied with a test suite.

- If you are modifying an example, then you can implement or modify a test under `examples.d/.tests.d/`.
- If you are modifying valet itself, then you can implement or modify a test under `tests.d/`.

In any cases, you must then run all the tests to make sure nothing broke:

```bash
VALET_USER_DIRECTORY=examples.d valet self test --auto-approve --with-core
```

### Code Review

When you'd like the team to take a look, (even if the work is not yet fully-complete), mark the PR as 'Ready For Review' so that the team can review your work and provide comments, suggestions, and request changes. It may take several cycles, but the end result will be solid, testable, conformant code that is safe for us to merge.

### Merge

Once your code has been reviewed and approved by the requisite number of team members, it will be merged into the main branch. Once merged, your PR will be automatically closed.

---

## Thank you

Thank you in advance for your contribution!
