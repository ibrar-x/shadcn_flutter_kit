---
name: flutter-shadcn-ui
description: Use when installing, composing, styling, replacing Material/Cupertino widgets with, or troubleshooting Flutter shadcn registry components in an application.
---

# Flutter shadcn UI

Use `flutter_shadcn` as the source of truth for installing, removing, discovering, theming, and validating Flutter shadcn components. Do not copy registry files by hand unless the CLI has no supported path for the operation.

## First Commands In A Target App

```bash
flutter_shadcn registries --json
flutter_shadcn default
flutter_shadcn doctor --json
```

If a component name may exist in multiple registries, use `@namespace/component`.

## Non-Negotiables

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
flutter_shadcn search @shadcn dialog --json
flutter_shadcn info @shadcn/dialog --json
flutter_shadcn dry-run @shadcn/dialog --json
flutter_shadcn add @shadcn/dialog
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

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
