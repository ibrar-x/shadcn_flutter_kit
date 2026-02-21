# registry_tool.dart

## Purpose
Interactive utility for component bootstrapping, syncing, and `_impl` stub creation.

## Script
`tool/registry/registry_tool.dart`

## Command
`dart run tool/registry/registry_tool.dart <command>`

## Commands
- `init`: scaffold a component/composite interactively
- `sync`: normalize taxonomy + refresh manifest file lists
- `add-impl`: add a new `_impl/<bucket>/<file>.dart` stub and part directive

## Inputs
- Interactive terminal prompts
- Registry filesystem

## Outputs
- New/updated component files
- Updated `components.json`

## Example
`dart run tool/registry/registry_tool.dart init`
