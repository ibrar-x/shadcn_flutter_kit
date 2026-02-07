# Configuration

Source: this skill reference set and command help output.

## Primary Files

- `.shadcn/config.json`: install/shared paths, registry mode, aliases, theme settings
- `.shadcn/state.json`: managed dependency/sync metadata
- `<installPath>/components.json`: installed component metadata
- `.shadcn/components/<id>.json`: per-component install metadata

## Safe Configuration Flow

1. Update settings using CLI commands (`init`, `platform`, `theme`) where possible.
2. If manual edits are needed, reapply with:

```bash
flutter_shadcn sync
```

3. Validate after sync:

```bash
flutter_shadcn doctor
flutter_shadcn validate
```
