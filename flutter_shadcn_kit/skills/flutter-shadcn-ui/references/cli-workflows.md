# CLI Workflows For UI Agents

## Initialization

Always initialize a target Flutter project before installing components.

```bash
flutter pub get
flutter_shadcn init --yes
```

For a specific namespace:

```bash
flutter_shadcn init shadcn --yes
```

`init` creates `.shadcn/config.json`, `.shadcn/state.json`, shared install paths, and inline bootstrap files required by later `add` operations.

## Context Validation

```bash
flutter_shadcn registries --json
flutter_shadcn default
flutter_shadcn doctor --json
```

Do not continue to `add` if initialization or `doctor --json` reports broken setup.

## Discovery

```bash
flutter_shadcn list @shadcn --json
flutter_shadcn search @shadcn button --json
flutter_shadcn info @shadcn/button --json
```

## Install

```bash
flutter_shadcn dry-run @shadcn/button --json
flutter_shadcn add @shadcn/button
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

For multi-component screens:

```bash
flutter_shadcn dry-run @shadcn/card @shadcn/button --json
flutter_shadcn add @shadcn/card @shadcn/button
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

## Required Agent Order

1. `flutter pub get`
2. `flutter_shadcn init --yes`
3. `flutter_shadcn registries --json`
4. `flutter_shadcn default`
5. `flutter_shadcn doctor --json`
6. `flutter_shadcn list` / `search` / `info`
7. `flutter_shadcn dry-run ... --json`
8. `flutter_shadcn add ...`
9. `flutter_shadcn validate --json`
10. `flutter_shadcn audit --json`
11. `flutter_shadcn deps --json`

## Remove

```bash
flutter_shadcn remove @shadcn/dialog
```

Use `--force` only after confirming dependency consequences.

## Refresh Components

There is no dedicated update command:

```bash
flutter_shadcn init --yes
flutter_shadcn doctor --json
flutter_shadcn dry-run @shadcn/button --json
flutter_shadcn add @shadcn/button
flutter_shadcn audit --json
flutter_shadcn deps --json
```
