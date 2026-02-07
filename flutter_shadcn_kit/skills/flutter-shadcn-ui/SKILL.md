---
name: flutter-shadcn-ui
description: CLI-first guidance for using flutter_shadcn in Flutter projects. Prefer documented CLI workflows for discovery, install, theming, validation, and skill setup. Use manual/file-inspection fallback only when CLI execution is unavailable or fails.
compatibility: Requires Flutter/Dart tooling and flutter_shadcn_cli. Network is required for remote registry operations unless --offline is used.
---

# Flutter Shadcn UI Skill

## Mission

Use `flutter_shadcn` as the primary interface for all shadcn component work in Flutter projects.
Treat this skill bundle and CLI `--help` output as canonical in runtime environments.

## Operating Rules

1. CLI first. Use commands before reading or editing registry/component files directly.
2. No guessed flags. Only use syntax documented in this skill or command `--help` output.
3. Manual fallback only when CLI is unavailable or broken.
4. If fallback is used, state why CLI could not be used and return to CLI flow once recovered.

## Canonical Sources

- `SKILL.md`
- `references/commands.md`
- `references/core_concepts.md`
- `references/configuration.md`
- `references/troubleshooting.md`
- `flutter_shadcn --help` and `flutter_shadcn <command> --help`

## Core CLI Workflow

1. Install and verify CLI

```bash
dart pub global activate flutter_shadcn_cli
flutter_shadcn version
```

2. Initialize project

```bash
flutter_shadcn init
# or
flutter_shadcn init --yes
```

3. Discover components

```bash
flutter_shadcn list
flutter_shadcn search <query>
flutter_shadcn info <component-id>
flutter_shadcn dry-run <component>
```

4. Install and manage components

```bash
flutter_shadcn add <component>
flutter_shadcn remove <component>
flutter_shadcn sync
```

5. Configure theme/assets/platform

```bash
flutter_shadcn theme --list
flutter_shadcn assets --all
flutter_shadcn platform --list
```

6. Validate health and integrity

```bash
flutter_shadcn doctor
flutter_shadcn validate
flutter_shadcn audit
flutter_shadcn deps
```

## Command Surface (Documented)

- Discovery: `list`, `search`, `info`
- Setup/Install: `init`, `add`, `dry-run`, `remove`, `sync`
- Customization: `theme`, `assets`, `platform`
- Diagnostics: `doctor`, `validate`, `audit`, `deps`
- Skill tooling: `install-skill`
- CLI maintenance: `version`, `upgrade`, `feedback`, `docs`

## Base Components and Overlay Wrappers

When using overlay-capable components, ensure the widget tree is wrapped with one of:
- `ShadcnApp` (recommended app-level wrapper)
- `ShadcnLayer`
- `OverlayManagerLayer`

Registry-backed wrapper guidance:
- `app` composite provides `ShadcnApp` and already wires `OverlayManagerLayer`.
- `scaffold` is a base layout component and depends on `drawer` (overlay category).
- `app_bar` is a base composite export over `AppBar` + outline primitives.
- `card` exposes `Card` and `SurfaceCard` as base surface widgets.

Overlay category components in the registry:
- `alert_dialog`, `context_menu`, `dialog`, `drawer`, `dropdown_menu`, `eye_dropper`
- `hover_card`, `menu`, `menubar`, `overlay`, `popover`, `popup`
- `refresh_trigger`, `sheet`, `swiper`, `toast`, `tooltip`

Non-overlay components that currently depend on overlay components:
- `color_input`, `color_picker`, `command`, `error_system`, `form_field`
- `item_picker`, `material`, `navigation_menu`, `scaffold`, `select`, `tracker`

Rule: if `dry-run` shows overlay-category dependencies, require one of the wrappers above.

## JSON and Offline Modes

Use `--json` on commands that document JSON output.
Use `--offline` on commands that document offline support.

## Fallback Path (Only if CLI Fails)

Use this path only when `flutter_shadcn` cannot run or a command is failing due environment/tooling issues.

1. Diagnose failure cause

```bash
flutter_shadcn doctor --json
```

2. If command or cache issue, follow troubleshooting reset guidance in:
`references/troubleshooting.md`

3. As a temporary manual fallback, inspect only these files:

- `.shadcn/config.json`
- `.shadcn/state.json`
- `<installPath>/components.json`
- `.shadcn/components/*.json`
- Registry `index.json` and `components.json`

4. Once CLI is healthy, stop manual flow and continue with standard CLI commands.

## References in This Skill

- `references/commands.md`
- `references/core_concepts.md`
- `references/configuration.md`
- `references/common_tasks.md`
- `references/advanced_usage.md`
- `references/themes.md`
- `references/troubleshooting.md`
- `references/INSTALLATION.md`
- `references/registry_formats.md`
- `references/schemas.md`
- `references/best_practices.md`
- `references/examples.md`
