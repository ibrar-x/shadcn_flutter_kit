# Core Concepts

Source: `shadcn_flutter_cli/doc/site/concepts.md`

## Registry

The registry defines components and shared helpers.
CLI can resolve local or remote registries.

## Paths

- Install path: where component files are copied
- Shared path: where shared helpers are copied

Defaults come from `components.json` and can be overridden in `.shadcn/config.json`.

## Config and State

- `.shadcn/config.json`: user preferences (paths, registry mode, aliases)
- `.shadcn/state.json`: managed dependency and sync metadata

## Manifests

- `<installPath>/components.json`: installed component metadata
- `.shadcn/components/<id>.json`: per-component install metadata

## Schema Validation

`components.json` is validated against schema to ensure structural consistency.

## JSON Output Envelope

Commands that support `--json` return:
- `status`
- `command`
- `data`
- `errors`
- `warnings`
- `meta`

## Offline Mode

Use `--offline` to disable network and rely on cached registry/index data.
