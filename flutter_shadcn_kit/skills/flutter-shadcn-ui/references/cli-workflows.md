# CLI Workflows For UI Agents

## Context

```bash
flutter_shadcn registries --json
flutter_shadcn default
flutter_shadcn doctor --json
```

## Discovery

```bash
flutter_shadcn list @shadcn --json
flutter_shadcn search @shadcn button --json
flutter_shadcn info @shadcn/button --json
```

## Install

```bash
flutter_shadcn dry-run @shadcn/card @shadcn/button --json
flutter_shadcn add @shadcn/card @shadcn/button
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

## Remove

```bash
flutter_shadcn remove @shadcn/dialog
```

Use `--force` only after confirming dependency consequences.

## Refresh Components

There is no dedicated update command:

```bash
flutter_shadcn dry-run @shadcn/button --json
flutter_shadcn add @shadcn/button
flutter_shadcn audit --json
flutter_shadcn deps --json
```

## Skill Install

```bash
flutter_shadcn --advanced install-skill --available
flutter_shadcn --advanced install-skill --skill flutter-shadcn-ui --model .codex
```
