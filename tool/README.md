# Registry Generation Tools

This directory contains Dart scripts for generating structured metadata from the Flutter shadcn registry.

## Scripts

### `generate_readme_meta.dart`

Extracts structured metadata from component README.md files.

**What it does:**
- Scans all component/composite README.md files in the registry
- Parses standardized README sections (When to use, Install, API, etc.)
- Generates `<id>.meta.json` files with structured, machine-readable metadata
- Validates output against `readme_meta.schema.json`

**Output:** `{id}.meta.json` files alongside each README.md

**Usage:**
```bash
dart tool/generate_readme_meta.dart
```

**Schema:** `flutter_shadcn_kit/lib/registry/readme_meta.schema.json`

---

### `generate_registry_index.dart`

Creates a unified index of all components with combined metadata.

**What it does:**
- Reads component list from `components.json`
- Loads both `meta.json` (authoritative) and `{id}.meta.json` (documentation)
- Combines metadata intelligently
- Generates a single `index.json` with all components
- Validates output against `index.schema.json`

**Output:** `flutter_shadcn_kit/lib/registry/index.json`

**Usage:**
```bash
dart tool/generate_registry_index.dart
```

**Schema:** `flutter_shadcn_kit/lib/registry/index.schema.json`

---

## Workflow

1. **Update component READMEs** following the template structure
2. **Run `generate_readme_meta.dart`** to extract documentation metadata
3. **Run `generate_registry_index.dart`** to build the unified index

---

## Schema Validation

Both scripts validate their output against JSON schemas before writing files:

- **`readme_meta.schema.json`** - Validates individual component metadata
  - Required fields: `schemaVersion`, `id`, `name`, `description`, `install`, `import`, `examples`, `api`
  - API must include `constructors` and `callbacks` arrays
  - Supports optional sections: `whenToUse`, `patterns`, `theming`, `accessibility`, `do`, `dont`, `related`, `registryRules`

- **`index.schema.json`** - Validates the unified component index
  - Top-level: `schemaVersion`, `generatedAt`, `components` array
  - Each component: `id`, `name`, `category`, `description`, `tags`, `install`, `import`, `importPath`, `api`, `examples`, `dependencies`, `related`
  - Ensures consistency across all 138+ components

Validation errors will prevent file generation and display detailed error messages.

---

## Generated Files

All generated JSON files include a `$schema` reference for IDE validation and autocomplete:

```json
{
  "$schema": "../readme_meta.schema.json",
  "schemaVersion": 1,
  "id": "button",
  ...
}
```

---

## Error Handling

Both scripts:
- ✅ Skip missing components with warnings
- ✅ Validate structure before writing
- ✅ Provide detailed error messages
- ✅ Exit with non-zero status on validation failures

This ensures only valid, schema-compliant metadata is generated.
