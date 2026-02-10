# registry_sync_all.dart

One-shot sync for meta, components manifest, and shared entries.

## Inputs
- `registry/components/**`
- `registry/composites/**`
- `registry/shared/**`
- `meta.json`

## Outputs
- `flutter_shadcn_kit/lib/registry/components.json`
- `docs/assets/registry/components.json` (if present)
- Updated `meta.json` files

## Usage
```bash
dart run ../tool/registry_sync_all.dart
```

## Flags
- `--bump-manifest-version`
- `--set-manifest-version 2`
- `--force`
- `-h`, `--help`
