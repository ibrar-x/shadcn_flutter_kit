# Advanced Usage

## JSON-First Automation

For scripting or CI, prefer JSON output where supported.

```bash
flutter_shadcn list --json
flutter_shadcn info button --json
flutter_shadcn dry-run button --json
flutter_shadcn doctor --json
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```

## Offline-Mode Workflows

Use cached registry/index data when network access is restricted.

```bash
flutter_shadcn list --offline
flutter_shadcn search button --offline
flutter_shadcn info button --offline
flutter_shadcn dry-run button --offline
flutter_shadcn doctor --offline
```

If offline cache is missing, run once without `--offline` to populate it.

## Safer Change Planning

Before installation/removal in shared repos:

```bash
flutter_shadcn dry-run <component>
flutter_shadcn deps --json
flutter_shadcn audit --json
```
