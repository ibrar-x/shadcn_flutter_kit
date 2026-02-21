# registry_verify.dart

## Purpose
Validates registry consistency across filesystem, metadata, dependencies, and docs snapshots.

## Script
`tool/registry/registry_verify.dart`

## Command
`dart run tool/registry/registry_verify.dart`

## Checks
- Duplicate/missing/extra component entries
- File-list mismatches
- Metadata presence and id/category alignment
- Dependency integrity (`shared`, `components`, `pubspec`)
- Shared-file coverage and duplicate assignments
- Docs snapshot parity

## Output
- Summary counts and detailed lists for any failures
- Exit code `2` when mismatches are found

## Example
`dart run tool/registry/registry_verify.dart`
