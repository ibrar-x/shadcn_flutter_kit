# registry_skill_bundle.dart

## Purpose
Creates a portable `skills/<name>` bundle containing registry snapshot files for AI tooling.

## Script
`tool/registry/registry_skill_bundle.dart`

## Command
`dart run tool/registry/registry_skill_bundle.dart <skill-name> [--out=skills] [--registry=<dir>] [--force]`

## Inputs
- Registry root (default `flutter_shadcn_kit/lib/registry`)

## Outputs
- `<out>/<skill-name>/registry_snapshot/**`
- `<out>/<skill-name>/manifest.json`
- `<out>/<skill-name>/schemas/manifest.schema.json`
- `SKILL.md` and `skill.prompt.json` templates (if missing)

## Notes
- `--force` refreshes snapshot/schema/manifest while preserving existing SKILL prompt files.
- Use `--info` to print full behavior.

## Example
`dart run tool/registry/registry_skill_bundle.dart screen_builder --out=skills --force`
