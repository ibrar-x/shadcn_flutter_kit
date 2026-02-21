# Common Helpers

Shared utility code used by multiple tool scripts.

## Files

- `registry_component_metadata.dart`
  - Centralizes component metadata paths.
  - Handles canonical (`component/registry/*.json`) vs legacy (`component/*.json`) read/write mirroring.
  - Provides file filtering helpers for manifest generation.

## Usage

This folder is imported by scripts in:

- `tool/registry`
- `tool/theme`

You do not run files in this folder directly.
