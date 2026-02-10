# Flutter Shadcn CLI Command Reference (CLI-Accurate)
    
Source: this skill reference set plus CLI `--help` output.

## Discovery

### `list` (`ls`)

```bash
flutter_shadcn list [--refresh] [--json]
```

### `search`

```bash
flutter_shadcn search <query> [--refresh] [--json]
```

### `info` (`i`)

```bash
flutter_shadcn info <component-id> [--refresh] [--json]
```

Global flag for discovery commands:

```bash
--offline
```

## Install and Lifecycle

### `init`

```bash
flutter_shadcn init [options] [components...]
```

Documented options:
- `--yes`
- `--install-fonts`
- `--install-icons`
- `--install-path`
- `--shared-path`
- `--include-readme`
- `--include-meta`
- `--include-preview`
- `--prefix`
- `--theme`
- `--alias`

### `add`

```bash
flutter_shadcn add <component> [more...] [options]
```

Documented options:
- `--all`

### `dry-run`

```bash
flutter_shadcn dry-run <component> [--json]
flutter_shadcn dry-run --all [--json]
```

Documented options:
- `--all`
- `--json`
- `--offline` (global)

### `remove` (`rm`)

```bash
flutter_shadcn remove <component> [options]
```

Documented options:
- `--all`
- `--force`

### `sync`

```bash
flutter_shadcn sync
```

## Styling and Platform

### `theme`

```bash
flutter_shadcn theme [--list|--apply <id>|--apply-file <path>|--apply-url <url>]
```

### `assets`

```bash
flutter_shadcn assets [--icons|--fonts|--typography|--all]
```

### `platform`

```bash
flutter_shadcn platform [--set key=value] [--reset key] [--list]
```

## Diagnostics and Validation

### `doctor`

```bash
flutter_shadcn doctor [--json]
```

### `validate`

```bash
flutter_shadcn validate [--json]
```

### `audit`

```bash
flutter_shadcn audit [--json]
```

### `deps`

```bash
flutter_shadcn deps [--all] [--json]
```

## Skills and Maintenance

### `install-skill`

```bash
flutter_shadcn install-skill [--skill <id>] [--model <name>] [options]
```

Documented options:
- `--skill`
- `--model`
- `--list`
- `--available`
- `--interactive`
- `--symlink`

### `version`

```bash
flutter_shadcn version [--check]
```

### `upgrade`

```bash
flutter_shadcn upgrade [--force]
```

### `feedback`

```bash
flutter_shadcn feedback [--type ... --title ... --body ...]
```

### `docs`

```bash
flutter_shadcn docs [--generate]
```

## Accuracy Rule

If a flag is not in this skill and not in command `--help`, do not assume it exists.
