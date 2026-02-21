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
  - `<component>/registry/<id>.meta.json`
- Legacy mirror for compatibility:
  - `<component>/<id>.meta.json`

## Notes
- Script validates generated schema structure before writing.
- Components with malformed README headings are reported as errors.

## Example
`dart run tool/registry/registry_readme_meta.dart`
