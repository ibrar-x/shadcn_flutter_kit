# CLI-Accurate Examples

## New Project Setup

```bash
dart pub global activate flutter_shadcn_cli
flutter_shadcn init --yes
```

## Component Discovery to Install

```bash
flutter_shadcn search button
flutter_shadcn info button
flutter_shadcn dry-run button
flutter_shadcn add button
```

## Theme and Assets

```bash
flutter_shadcn theme --list
flutter_shadcn theme --apply modern-minimal
flutter_shadcn assets --fonts
```

## Validate After Changes

```bash
flutter_shadcn doctor --json
flutter_shadcn validate --json
flutter_shadcn deps --json
flutter_shadcn audit --json
```

## Skills Installation

```bash
flutter_shadcn install-skill --available
flutter_shadcn install-skill --skill flutter-shadcn-ui --model .claude
```

## Offline Discovery

```bash
flutter_shadcn list --offline
flutter_shadcn info button --offline
```
