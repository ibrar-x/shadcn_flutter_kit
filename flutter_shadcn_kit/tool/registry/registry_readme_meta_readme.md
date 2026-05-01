# registry_readme_meta.dart

## Purpose
Generates `<id>.meta.json` from each component README.

## Script
`tool/registry/registry_readme_meta.dart`

## Command
`dart run tool/registry/registry_readme_meta.dart`

## Inputs
- `README.md` in component/composite folders

## Outputs
- Canonical readme metadata:
  - `<component>/<id>.meta.json`

## Notes
- Script validates generated schema structure before writing.
- Components with malformed README headings are reported as errors.
- Nested `<component>/registry/<id>.meta.json` copies are legacy and should be removed.

## Example
`dart run tool/registry/registry_readme_meta.dart`
