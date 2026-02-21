# generate_available_components.dart

## Purpose
Scans `lib/registry/components` and writes a sorted component id list.

## Script
`tool/registry/generate_available_components.dart`

## Command
`dart run tool/registry/generate_available_components.dart [--output <path>]`

## Inputs
- Filesystem under `lib/registry/components`

## Options
- `--output <path>`: output file path
- `-h`, `--help`: usage

## Output
- Default: `lib/registry/available_components.txt`

## Example
`dart run tool/registry/generate_available_components.dart --output lib/registry/available_components.txt`
