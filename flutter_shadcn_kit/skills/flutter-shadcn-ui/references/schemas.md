# Schemas and Validation

## Purpose

Schema validation ensures registry metadata is structurally correct before installation.

## Command

```bash
flutter_shadcn validate
# or
flutter_shadcn validate --json
```

## What `validate` Checks

- `components.json` schema conformance
- missing `files.source` paths
- missing `dependsOn` component ids
- missing `files.dependsOn` paths (required/optional handling)

## Related Commands

- `doctor`: environment and registry resolution checks
- `audit`: installed files/manifests vs registry metadata
- `deps`: dependency requirements vs `pubspec.yaml`

## Relevant Exit Codes

- `20`: schema invalid
- `30`: component missing
- `31`: file missing
- `41`: offline cache unavailable
- `50`: validation failed
