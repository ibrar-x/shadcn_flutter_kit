# registry_shared_manifest.dart

Generates `shared_manifest.json` from `registry/shared` and `components.json`.

## Inputs
- `registry/shared/**`
- `components.json` (shared grouping)

## Outputs
- `flutter_shadcn_kit/lib/registry/shared/shared_manifest.json`

## Usage
```bash
dart run tool/registry/registry_shared_manifest.dart
```

## Flags
- `--bump-manifest-version`
- `--set-manifest-version 2`
- `--force`
- `-h`, `--help`
