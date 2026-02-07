# Troubleshooting

Source: this skill reference set and CLI troubleshooting behavior.

## Common Issues

### Flag not found

Refresh command snapshots and reactivate CLI:

```bash
rm -f ~/.pub-cache/hosted/*/bin/cache/flutter_shadcn_cli/* || true
rm -f .dart_tool/pub/bin/flutter_shadcn_cli/*.snapshot || true
dart pub global activate flutter_shadcn_cli
```

### Registry not found

Set a valid local or remote registry target in command options/config.

### Offline cache missing

Run once without `--offline` to populate cache.

### Schema validation failure

```bash
flutter_shadcn doctor
flutter_shadcn validate
```

### Theme file not found

Run `init` first to create shared theme files.

## Fallback Rule

Manual registry/file inspection is fallback-only and should be used only when CLI execution is failing.
