# Common Helpers

Shared utility code used by multiple tool scripts.

## Files

- `registry_component_metadata.dart`
  - Centralizes component metadata paths.
  - Treats component top-level `meta.json`, `<id>.meta.json`, and `theme.schema.json` as the production canonical files.
  - Recognizes nested `component/registry/*.json` files only as legacy metadata that should be removed after migration.
  - Provides file filtering helpers for manifest generation.

## Usage

This folder is imported by scripts in:

- `tool/registry`
- `tool/theme`

You do not run files in this folder directly.
