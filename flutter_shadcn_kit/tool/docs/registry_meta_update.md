# registry_meta_update.dart

Updates existing `meta.json` files with file lists, dependencies, API, and version.

## Inputs
- `registry/components/**/meta.json`
- `registry/composites/**/meta.json`
- `components.json` (for dependency backfill)
- `<id>.meta.json` (optional, for `api` field)

## Outputs
- Updated `meta.json` files (in place)

## Usage
```bash
dart run tool/registry/registry_meta_update.dart
```

## Flags
- `--components button,toast`
- `--set-component-version 1.2.0`
- `--component-version button=1.2.0 --component-version toast=1.3.0`
- `--default-version 1.0.0`
- `-h`, `--help`

## Notes
- Existing versions are preserved unless you set them explicitly.
