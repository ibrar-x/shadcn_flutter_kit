# registry_verify.dart

Validates `components.json` against the filesystem and dependency references.

## Checks
- Missing/extra/duplicate component entries
- File list mismatches
- `meta.json` presence and id/category alignment
- Shared/component/pubspec dependency references
- Docs snapshot consistency

## Usage
```bash
dart run tool/registry/registry_verify.dart
```

## Flags
- `-h`, `--help`
