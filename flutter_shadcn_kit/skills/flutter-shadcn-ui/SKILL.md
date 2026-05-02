---
name: flutter-shadcn-ui
description: Use when installing, composing, styling, replacing Material/Cupertino widgets with, or troubleshooting Flutter shadcn registry components in an application.
---

# Flutter shadcn UI

Use `flutter_shadcn` as the source of truth for initializing a Flutter project, installing components, removing components, discovering registry content, applying themes, and validating project state. Do not copy registry files by hand unless the CLI has no supported path for the operation.

This skill is for component installation and usage inside a Flutter app. It is not for maintaining the CLI package itself.

## Required Install Order

Do not jump straight to `add`.

For a real project, the order is:

1. Confirm the project is a Flutter app and run `flutter pub get` if needed.
2. Initialize shadcn in that project with `flutter_shadcn init --yes` or `flutter_shadcn init <namespace> --yes`.
3. Verify registry and project state with `registries`, `default`, and `doctor --json`.
4. Discover the target component with `list`, `search`, and `info`.
5. Preview the install with `dry-run --json`.
6. Install with `add`.
7. Validate with `validate --json`, `audit --json`, and `deps --json`.
8. Only then move on to theming, composition, widget usage, or removal.

`init` is required because it creates `.shadcn/config.json`, `.shadcn/state.json`, shared install paths, and inline bootstrap files that components expect to exist before installation.

## First Commands In A Target App

```bash
flutter pub get
flutter_shadcn init --yes
flutter_shadcn registries --json
flutter_shadcn default
flutter_shadcn doctor --json
```

If you need a specific namespace:

```bash
flutter_shadcn init shadcn --yes
```

If a component name may exist in multiple registries, use `@namespace/component`.

## Non-Negotiables

- Init first: do not run `add` in a project that has not been initialized.
- CLI first: use `flutter_shadcn` commands before manual edits.
- No guessed flags: check `flutter_shadcn --help` and command help.
- Namespace explicit: use `@shadcn/button` style references in automation.
- Preview first: run `dry-run --json` before non-trivial installs.
- Prefer existing registry components and shared primitives before creating custom widgets.
- Keep overlay managers at app scope for dialog, drawer, menu, tooltip, toast, popover, refresh, and hover-card flows.
- Hide conflicting Material/Cupertino symbols instead of aliasing registry imports.
- Theme through CLI and theme tokens before hardcoded colors.

## Install Flow

```bash
flutter pub get
flutter_shadcn init --yes
flutter_shadcn registries --json
flutter_shadcn default
flutter_shadcn doctor --json
flutter_shadcn search @shadcn dialog --json
flutter_shadcn info @shadcn/dialog --json
flutter_shadcn dry-run @shadcn/dialog --json
flutter_shadcn add @shadcn/dialog
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

If `doctor --json` shows broken config or missing bootstrap files, stop and fix initialization before installing components.

## Component Selection

Use [references/component-catalog.md](references/component-catalog.md) for every available component category and [references/replacement-map.md](references/replacement-map.md) before replacing Material/Cupertino widgets or adding custom components.

## Composition

Use [references/composition.md](references/composition.md) for overlay wrappers, import conflict handling, dependency-safe removal, and component-first app structure.

## Forms

Use [references/forms.md](references/forms.md) for form bundles, validation ownership, date/time/color/file inputs, and field composition.

## Theme, Assets, Platform

Use [references/theming-assets.md](references/theming-assets.md) for theme presets, widget-level overrides, icon/font assets, and platform path overrides.

## CLI Workflows

Use [references/cli-workflows.md](references/cli-workflows.md) for discovery, install, remove, diagnostics, updates, and skill installation commands.
