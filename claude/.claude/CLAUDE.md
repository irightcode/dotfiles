# Claude Personal Configuration

## Introduction

This is your global configuration file for Claude Code. These guidelines apply across all projects and override default behavior. Claude Code will adhere to these instructions for every session.

## Project-Specific claude.md Files

When creating project-specific `claude.md` files, place them in a `docs/` folder within the project directory, not in the root.

**Structure:**
```
project-root/
├── docs/
│   └── claude.md
└── ... other project files
```

**Guidelines:**
- Create the `docs/` directory if it doesn't exist
- Place `claude.md` inside `docs/claude.md`
- Never create `claude.md` in the project root

This keeps AI-related context organized in a dedicated folder, separate from main project files.

## Philosophy

**Core Principles:**

- **Incremental progress over big bangs** - Small changes that compile and pass tests
- **Learning from existing code** - Study and plan before implementing
- **Pragmatic over dogmatic** - Adapt to project reality
- **Clear intent over clever code** - Be boring and obvious
- **Single responsibility** per function/class
- **Avoid premature abstractions** - Don't abstract until you have 3+ use cases
- **No clever tricks** - Choose the boring solution
- **If you need to explain it, it's too complex** - Simplify

## Technical Standards

### Architecture Principles

- **Composition over inheritance** - Use dependency injection
- **Interfaces over singletons** - Enable testing and flexibility
- **Explicit over implicit** - Clear data flow and dependencies
- **Test-driven when possible** - Never disable tests, fix them

### Error Handling

- **Fail fast** with descriptive messages
- **Include context** for debugging (variable values, state, operation being performed)
- **Handle errors** at appropriate level (UI errors vs system errors)
- **Never** silently swallow exceptions

## Project Integration

### Learn the Codebase

Before implementing:
- Find similar features/components to understand patterns
- Identify common patterns and conventions
- Use same libraries/utilities when possible
- Follow existing test patterns and assertion styles

### Tooling

- Use project's existing build system
- Use project's existing test framework
- Use project's formatter/linter settings
- Don't introduce new tools without strong justification

### Code Style

- Follow existing conventions in the project
- Refer to linter configurations and .editorconfig, if present
- Text files should always end with an empty line

## Workflow Guidance

### When to Plan vs Execute

**Use plan mode for:**
- Multi-file changes or refactoring
- New features with architectural decisions
- Complex bug fixes requiring investigation
- Tasks with multiple valid approaches

**Execute directly for:**
- Single-file changes
- Simple bug fixes with clear solutions
- Typos, formatting, or documentation updates

### Commit Strategy

- Commit working code incrementally
- Each commit should compile and pass tests
- Update documentation as you go, not after

## Critical Reminders

**NEVER:**
- Use `--no-verify` to bypass commit hooks
- Disable tests instead of fixing them
- Commit code that doesn't compile
- Silently swallow exceptions
- Make assumptions - verify with existing code

**ALWAYS:**
- Read files before modifying them
- Learn from existing implementations first
- Ask clarifying questions when requirements are ambiguous
- Stop after 3 failed attempts and reassess approach
- Commit working code incrementally
