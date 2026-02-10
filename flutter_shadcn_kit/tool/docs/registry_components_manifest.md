# registry_components_manifest.dart

Generates `components.json` and the docs snapshot, and refreshes shared entries.

## Inputs
- `registry/components/**`
- `registry/composites/**`
- `registry/shared/**`
- `meta.json` files

## Outputs
- `flutter_shadcn_kit/lib/registry/components.json`
- `docs/assets/registry/components.json` (if present)

## Usage
```bash
dart run ../tool/registry_components_manifest.dart
```

## Flags
- `--components button,toast`
- `--set-component-version 1.2.0`
- `--component-version button=1.2.0 --component-version toast=1.3.0`
- `--bump-manifest-version`
- `--set-manifest-version 2`
- `--force`
- `-h`, `--help`

## Notes
- This script does **not** generate `components_1.json`.
