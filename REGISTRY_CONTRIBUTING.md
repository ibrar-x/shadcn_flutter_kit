# Registry Contributing: Getting Started

This guide is for contributors working on the registry source used by the docs app and CLI.

## Scope

The registry lives in:

- `shadcn_flutter_kit/flutter_shadcn_kit/lib/registry`

Key paths:

- `components/` component source by category
- `composites/` composite source by category
- `shared/` shared primitives, tokens, theme, and utils
- `components.json` install manifest
- `components.schema.json` manifest schema
- `index.json` docs/index metadata

## Prerequisites

- Flutter SDK installed and on `PATH`
- Dart SDK `3.10.7` (or compatible with `flutter_shadcn_kit/pubspec.yaml`)
- `python3` (for docs helper scripts)

Optional but useful:

- `flutter_shadcn` CLI installed for docs refresh:
  - from repository root: `make cli-install`

## First-Time Setup

1. Install dependencies for the registry package:

```bash
cd shadcn_flutter_kit/flutter_shadcn_kit
flutter pub get
```

2. Validate registry state before making changes:

```bash
dart run tool/registry_verify.dart
```

3. (Optional) Run the validator app locally:

```bash
flutter run -d chrome
```

## Typical Contributor Workflow

1. Edit registry files in:
   - `lib/registry/components/...`
   - `lib/registry/composites/...`
   - `lib/registry/shared/...`

2. Refresh metadata/manifests:

```bash
dart run tool/registry_sync_all.dart
dart run tool/registry_index_generate.dart
```

3. Verify consistency:

```bash
dart run tool/registry_verify.dart
```

4. If docs need refresh, run from `shadcn_flutter_kit/docs`:

```bash
make docs-refresh
```

Then run docs locally:

```bash
flutter run -d chrome
```

## Adding a New Component

Option A: Scaffold from script (fastest)

```bash
cd shadcn_flutter_kit/flutter_shadcn_kit
dart run scripts/new_component.dart button --category control --description "Shadcn-style button." --sync
```

Option B: Interactive helper

```bash
cd shadcn_flutter_kit/flutter_shadcn_kit
dart run tool/registry_tool.dart init
```

Important:

- `scripts/new_component.dart` updates manifests and can overwrite `lib/main.dart` for preview wiring.
- After scaffolding, always run:
  - `dart run tool/registry_index_generate.dart`
  - `dart run tool/registry_verify.dart`

## Script Cheat Sheet

Run from `shadcn_flutter_kit/flutter_shadcn_kit` unless noted.

- `dart run tool/registry_sync_all.dart`
  - One-shot meta + manifest sync.
- `dart run tool/registry_meta_update.dart`
  - Refresh `meta.json` fields.
- `dart run tool/registry_components_manifest.dart`
  - Rebuild `components.json` and docs snapshot.
- `dart run tool/registry_shared_manifest.dart`
  - Rebuild `shared_manifest.json`.
- `dart run tool/registry_readme_meta.dart`
  - Generate optional `<id>.meta.json` from README files.
- `dart run tool/registry_index_generate.dart`
  - Rebuild `index.json`.
- `dart run tool/registry_verify.dart`
  - Validate filesystem, dependencies, meta alignment, and snapshot consistency.
- `dart run tool/registry_tool.dart <command>`
  - Interactive `init`, `sync`, and `add-impl`.
- `dart run scripts/new_component.dart ...`
  - Component scaffold/create/remove workflow.

Docs-side helpers (run from `shadcn_flutter_kit/docs`):

- `make docs-install`
- `make docs-generate`
- `make docs-barrel`
- `make docs-refresh`

## Manifest Guard Notes

If `manifestVersion > 1`, manifest scripts can refuse to run unless you pass one of:

- `--bump-manifest-version`
- `--set-manifest-version <int>`
- `--force`

Use `--help` on any script for full flags:

```bash
dart run tool/registry_sync_all.dart --help
```

## Pre-PR Checklist

- Run `dart run tool/registry_verify.dart`
- Run `flutter analyze` in:
  - `shadcn_flutter_kit/flutter_shadcn_kit`
  - `shadcn_flutter_kit/docs` (if docs changed)
- If you add/remove files, ensure manifests are regenerated and committed
- If UI behavior changed, validate in docs app (`flutter run -d chrome`)
