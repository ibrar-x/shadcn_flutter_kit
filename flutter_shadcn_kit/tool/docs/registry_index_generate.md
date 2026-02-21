# registry_index_generate.dart

Builds `index.json` from `components.json` and `meta.json`.

## Inputs
- `components.json`
- `meta.json`
- `<id>.meta.json` (optional, for README-derived docs)

## Outputs
- `flutter_shadcn_kit/lib/registry/index.json`

## Usage
```bash
dart run tool/registry/registry_index_generate.dart
```
