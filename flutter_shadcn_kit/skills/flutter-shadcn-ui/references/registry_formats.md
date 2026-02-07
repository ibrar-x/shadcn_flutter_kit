# Registry Formats

Source: this skill reference set and CLI registry behavior.

## `index.json`

Used for fast discovery commands (`list`, `search`, `info`).
Contains lightweight component metadata.

## `components.json`

Canonical install metadata.
Used by install/lifecycle commands (`init`, `add`, `dry-run`, `remove`, `sync`).

Includes:
- component ids and metadata
- file mappings
- shared helper requirements
- component dependencies (`dependsOn`)
- package dependencies (`pubspec.dependencies`)
- optional assets/fonts/platform/post-install metadata

## Manifest and State Files

- `<installPath>/components.json`: installed components in project
- `.shadcn/components/<id>.json`: per-component install state
- `.shadcn/state.json`: sync/dependency management metadata
