# registry_readme_meta.dart

Generates documentation metadata (`<id>.meta.json`) from component README.md files.

## Inputs
- `registry/components/**/README.md`
- `registry/composites/**/README.md`

## Outputs
- `<id>.meta.json` next to each README

## Usage
```bash
dart run ../tool/registry_readme_meta.dart
```

## Notes
- This is optional if you do not want `<id>.meta.json` files.
