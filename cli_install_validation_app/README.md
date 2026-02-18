# CLI Install Validation App

This app is a sandbox for validating `flutter_shadcn` installs against the local registry.

## What this validates
- Component files are copied from the registry with exact byte parity.
- Installed component analyzer status is reported after install.

## Local paths used by default
- CLI entry: `../../shadcn_flutter_cli/bin/shadcn.dart`
- Registry root: `../flutter_shadcn_kit/lib`

Override either path with environment variables:

```bash
CLI_ENTRY=/abs/path/to/shadcn.dart REGISTRY_ROOT=/abs/path/to/lib tool/install_and_check.sh button
```

## Quick usage
From this folder:

```bash
tool/install_and_check.sh gooey_toast
```

That command runs:
1. `flutter pub get`
2. `flutter_shadcn init` (local registry mode)
3. `flutter_shadcn add <component>`
4. `dart run tool/verify_install.dart` (byte parity check)
5. `flutter analyze` (reports whether install introduced issues)

If analyze fails, the script exits non-zero after printing the result.

## Manual verifier usage

```bash
dart run tool/verify_install.dart \
  --component gooey_toast \
  --registry-root ../flutter_shadcn_kit/lib
```
