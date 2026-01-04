
---
allowed-tools: AskUserQuestion, Read, Glob, Grep, Write, Edit
argument-hint: [spec-file]
description: Interview me to expand the spec
---

Here's the current spec:

@$ARGUMENTS

Interview me in detail using the AskUserQuestion tool about literally anything: technical implementation, UI & UX, concerns, tradeoffs, etc. but make sure the questions are not obvious.

Be very in-depth and continue interviewing me until it's complete, then write the spec back to $ARGUMENTS.
