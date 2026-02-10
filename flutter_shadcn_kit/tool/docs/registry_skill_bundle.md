# registry_skill_bundle.dart

Creates a registry snapshot + manifest for AI tooling.

## Inputs
- `index.json`
- `components.json`
- Schemas (if present)
- `registry/shared/**` (if present)
- `meta.json` files
- `<id>.meta.json` files (optional)

## Outputs
- `skills/<name>/registry_snapshot/**`
- `skills/<name>/manifest.json`
- `skills/<name>/schemas/manifest.schema.json`
- `skills/<name>/SKILL.md`
- `skills/<name>/skill.prompt.json`

## Usage
```bash
dart run ../tool/registry_skill_bundle.dart <skill-name> [--out=skills] [--force]
```

## Flags
- `--out=DIR`
- `--registry=DIR`
- `--force`
- `--info`
