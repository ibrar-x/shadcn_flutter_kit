# Registry Scripts

Scripts for building and validating registry metadata/manifests.

## Main Workflow

1. `dart run tool/registry/registry_readme_meta.dart`
2. `dart run tool/registry/registry_sync_all.dart --force`
3. `dart run tool/registry/registry_index_generate.dart`
4. `dart run tool/registry/registry_verify.dart`

## Scripts

- `registry_sync_all.dart`
  - Syncs component metadata + `components.json` + docs snapshot.
- `registry_components_manifest.dart`
  - Rebuilds `components.json` from component metadata and filesystem.
- `registry_meta_update.dart`
  - Updates existing component `meta.json` files (files/deps/version/api merge).
- `registry_readme_meta.dart`
  - Generates `<id>.meta.json` from README content.
- `registry_index_generate.dart`
  - Generates `lib/registry/index.json`.
- `registry_verify.dart`
  - Validates manifest/files/dependencies consistency.
- `registry_shared_manifest.dart`
  - Generates `shared_manifest.json` from `registry/shared`.
- `registry_skill_bundle.dart`
  - Creates skill snapshot bundles under `skills/`.
- `registry_tool.dart`
  - Interactive helper (`init`, `sync`, `add-impl`).
- `generate_available_components.dart`
  - Generates available components listing.

## Help

Each script supports:

- `-h`
- `--help`
