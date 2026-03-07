---
name: flutter-shadcn-ui
description: Manages flutter_shadcn CLI workflows for Flutter projects - initialization, registry selection, component discovery, dry-run planning, installation and removal, theming, diagnostics, and AI skill installation. Use when working with flutter_shadcn, .shadcn/config.json, components.json, multi-registry namespaces, or overlay-dependent shadcn Flutter components.
user-invocable: false
---

# Flutter shadcn CLI

`flutter_shadcn` is the source of truth for installing and managing shadcn Flutter components.

## Current Project Context

Run these first in the target project:

```bash
flutter_shadcn registries --json
flutter_shadcn default
flutter_shadcn doctor --json
```

## Principles

1. CLI first. Use CLI commands before manually editing registry files.
2. No guessed flags. Use only `flutter_shadcn --help` and command help output.
3. Preview before install. Use `dry-run` before `add` in non-trivial changes.
4. Keep registries explicit. Use namespace-qualified IDs when ambiguous.
5. Respect overlay requirements. Keep `ShadcnApp`/`ShadcnLayer`/`OverlayManagerLayer` around overlay-driven components.

## Critical Rules

### Styling & Theme -> [rules/styling.md](./rules/styling.md)

- Apply theme changes with `flutter_shadcn theme`, not ad-hoc edits first.
- Keep install/shared paths under `lib/`.
- Prefer semantic theme usage in app code over hardcoded visual values.

### Forms & Inputs -> [rules/forms.md](./rules/forms.md)

- Install the form stack as a set (`form`, `form_field`, `input`, `select`, etc.) instead of one-off improvisation.
- Run `dry-run` first for large form bundles.
- Keep validation behavior in form primitives/components, not duplicated wrapper logic.

### Component Composition -> [rules/composition.md](./rules/composition.md)

- Overlay-heavy components require one of the wrapper layers at app scope.
- Prefer existing shadcn components before rebuilding with raw Material/Cupertino widgets.
- Always check [references/COMMON_PATCHED_WIDGETS_README.md](./references/COMMON_PATCHED_WIDGETS_README.md) before introducing custom widgets.
- Use `remove --force` only when dependency constraints are intentionally overridden.

### Icons & Assets -> [rules/icons.md](./rules/icons.md)

- Install icon and typography assets through `flutter_shadcn assets`.
- Do not hand-edit font assets or `pubspec.yaml` when CLI asset flows exist.

### Namespace Resolution -> [rules/base-vs-radix.md](./rules/base-vs-radix.md)

- Unqualified IDs resolve through default and enabled registries and can become ambiguous.
- Use `@namespace/component` in automation, docs, and scripts.
- Keep default namespace intentional with `flutter_shadcn default`.

## Key Patterns

```bash
# Discovery
flutter_shadcn list @shadcn --json
flutter_shadcn search @shadcn button --json
flutter_shadcn info @shadcn/dialog --json

# Plan + install
flutter_shadcn dry-run @shadcn/dialog --json
flutter_shadcn add @shadcn/dialog @shadcn/button

# Cleanup
flutter_shadcn remove @shadcn/dialog
# Use only when intentionally bypassing dependency safety:
flutter_shadcn remove @shadcn/dialog --force

# Theme + verification
flutter_shadcn theme --list
flutter_shadcn theme --apply slate
flutter_shadcn doctor --json
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

## Component Selection

| Need | Use |
| --- | --- |
| Discover available components | `list`, `search`, `info` |
| Preview impact before install | `dry-run` |
| Install/remove components | `add`, `remove` |
| Keep config changes applied | `sync` |
| Theme presets/custom JSON | `theme` |
| Icon/font assets | `assets` |
| Platform target overrides | `platform` |
| Registry health checks | `doctor`, `validate`, `audit`, `deps` |
| AI model skill setup | `install-skill` |

## Key Files

- `.shadcn/config.json` - CLI config (registry mode, namespace defaults, paths, aliases)
- `.shadcn/state.json` - managed state and dependency bookkeeping
- `<installPath>/components.json` - installed component manifest
- `.shadcn/components/*.json` - per-component install metadata

## Workflow

1. Get registry context with `registries`, `default`, and `doctor`.
2. Discover candidates with `list`, `search`, and `info`.
3. Preview change impact with `dry-run`.
4. Install with `add` using explicit namespaces where needed.
5. Verify overlay wrappers for overlay or overlay-dependent components.
6. Run diagnostics (`validate`, `audit`, `deps`) after changes.
7. Apply theme/assets/platform changes through CLI commands.
8. Re-apply config-wide changes with `sync`.
9. Use `install-skill` to deploy this skill into model folders.

## Updating Components

`flutter_shadcn` has no dedicated `update` command. To refresh component source:

1. Run `dry-run` for the target component(s).
2. Review dependency and file changes.
3. Re-run `add` for those component(s).
4. Validate with `audit` and `deps`.

## Quick Reference

```bash
# bootstrap
flutter_shadcn init @shadcn --yes

# multi-registry controls
flutter_shadcn registries --json
flutter_shadcn default shadcn

# core workflow
flutter_shadcn search @shadcn card
flutter_shadcn dry-run @shadcn/card --json
flutter_shadcn add @shadcn/card
flutter_shadcn remove @shadcn/card

# maintenance
flutter_shadcn version --check
flutter_shadcn upgrade
flutter_shadcn feedback --type bug --title "..." --body "..."
```

## Detailed References

- [cli.md](./cli.md) - full command and flag reference
- [customization.md](./customization.md) - theming, assets, platform customization
- [mcp.md](./mcp.md) - MCP status and alternatives
- [rules/forms.md](./rules/forms.md) - form install/composition rules
- [rules/composition.md](./rules/composition.md) - overlay and composition rules
- [rules/icons.md](./rules/icons.md) - icon/font asset rules
- [rules/styling.md](./rules/styling.md) - theme/style rules
- [rules/base-vs-radix.md](./rules/base-vs-radix.md) - namespace and registry resolution patterns
- [references/COMMON_PATCHED_WIDGETS_README.md](./references/COMMON_PATCHED_WIDGETS_README.md) - required Material/Cupertino replacement map
