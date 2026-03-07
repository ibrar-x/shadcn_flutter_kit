# flutter_shadcn CLI Reference

> IMPORTANT: Only use commands and flags documented here or in `flutter_shadcn <command> --help`. Do not invent flags.

## Contents

- Global flags
- Registry and namespace conventions
- Command reference
- Common workflows

---

## Global Flags

These can be used before the command:

```bash
flutter_shadcn [global-flags] <command> [command-flags]
```

| Flag | Meaning |
| --- | --- |
| `--verbose`, `-v` | Verbose logging |
| `--offline` | Disable network calls and use cached registry/index data |
| `--wip` | Enable WIP features |
| `--experimental` | Enable experimental features |
| `--registry auto|local|remote` | Registry mode |
| `--registry-name <namespace>` | Select registry namespace (for example `shadcn`) |
| `--registry-path <path>` | Local registry path |
| `--registry-url <url>` | Remote registry base URL |
| `--skip-integrity` | Skip SHA-256 registry integrity checks (dev only) |
| `--registries-url <url>` | Remote `registries.json` URL |
| `--registries-path <path>` | Local `registries.json` file or directory |
| `--dev` | Persist local registry for dev mode |
| `--dev-path <path>` | Local registry path for dev mode |

---

## Registry and Namespace Conventions

- Explicit component reference: `@namespace/component` (recommended)
- Legacy add syntax: `namespace:component` (still supported by `add`)
- Default namespace can be set with `flutter_shadcn default <namespace>`
- Registry summary can be viewed with `flutter_shadcn registries --json`

---

## Commands

### `init`

Initialize namespace bootstrap actions.

```bash
flutter_shadcn init [@namespace|namespace] [--yes]
```

Options:
- `--yes`, `-y` non-interactive defaults

### `theme`

Manage global and widget-level themes.

```bash
flutter_shadcn theme [--list] [--refresh] [--apply <id>]
flutter_shadcn theme [--apply-file <path> | --apply-url <url>] --experimental
flutter_shadcn theme widget [@namespace] <component> --list-targets
flutter_shadcn theme widget [@namespace] <component> [--apply-file <path> | --apply-url <url> | --reset]
```

Top-level options:
- `--list`
- `--refresh`
- `--apply`, `-a`
- `--apply-file` (requires global `--experimental`)
- `--apply-url` (requires global `--experimental`)

`theme widget` options:
- `--list`
- `--list-targets`
- `--apply-file`
- `--apply-url`
- `--reset`

### `add`

Install components and dependencies.

```bash
flutter_shadcn add <component...>
flutter_shadcn add <@namespace/component...>
```

Options:
- `--all`, `-a`
- `--include-files <readme|preview|meta>` (repeatable/comma-separated)
- `--exclude-files <readme|preview|meta>` (repeatable/comma-separated)

### `dry-run`

Preview installation actions without writing files.

```bash
flutter_shadcn dry-run <component...> [--json]
flutter_shadcn dry-run --all [--json]
```

Options:
- `--all`, `-a`
- `--json`

### `remove` (alias: `rm`)

Remove installed components.

```bash
flutter_shadcn remove <component...>
flutter_shadcn remove --all
```

Options:
- `--all`, `-a`
- `--force`, `-f`

### `sync`

Re-apply `.shadcn/config.json` paths and theme settings.

```bash
flutter_shadcn sync
```

### `doctor`

Diagnostics for registry resolution, schema validation, and local config paths.

```bash
flutter_shadcn doctor [--json]
```

Options:
- `--json`

### `validate`

Validate registry/component structure and dependencies.

```bash
flutter_shadcn validate [--json]
```

Options:
- `--json`

### `audit`

Audit installed components against registry metadata and local files.

```bash
flutter_shadcn audit [--json]
```

Options:
- `--json`

### `deps`

Compare registry dependency requirements against `pubspec.yaml`.

```bash
flutter_shadcn deps [--all] [--json]
```

Options:
- `--all`, `-a`
- `--json`

### `docs`

Regenerate CLI docs site.

```bash
flutter_shadcn docs [--generate]
```

Options:
- `--generate`, `-g`

### `assets`

Install icon and typography asset bundles.

```bash
flutter_shadcn assets [--icons | --typography | --fonts | --all]
flutter_shadcn assets --list
```

Options:
- `--icons`
- `--typography`
- `--fonts` (alias for `--typography`)
- `--all`, `-a`
- `--list`

### `platform`

Manage platform target path overrides.

```bash
flutter_shadcn platform --list
flutter_shadcn platform --set ios.infoPlist=ios/Runner/Info.plist
flutter_shadcn platform --reset ios.infoPlist
```

Options:
- `--set <platform.section=path>` (repeatable)
- `--reset <platform.section>` (repeatable)
- `--list`

### `registries`

List configured/discoverable registries.

```bash
flutter_shadcn registries [--json]
```

Options:
- `--json`

### `default`

Show or set default namespace.

```bash
flutter_shadcn default
flutter_shadcn default <namespace>
```

### `list` (alias: `ls`)

List components from index data.

```bash
flutter_shadcn list [--refresh] [--json]
flutter_shadcn list @<namespace> [--refresh] [--json]
```

Options:
- `--refresh`
- `--json`

### `search`

Search by name/description/tags.

```bash
flutter_shadcn search <query> [--refresh] [--json]
flutter_shadcn search @<namespace> [query] [--refresh] [--json]
```

Options:
- `--refresh`
- `--json`

### `info` (alias: `i`)

Show detailed component metadata.

```bash
flutter_shadcn info <component-id> [--refresh] [--json]
flutter_shadcn info @<namespace>/<component-id> [--refresh] [--json]
```

Options:
- `--refresh`
- `--json`

### `install-skill`

Install or remove AI skill bundles.

```bash
flutter_shadcn install-skill [--skill <id>] [--model <name>] [options]
```

Options:
- `--skill`, `-s`
- `--model`, `-m`
- `--skills-url <path-or-url>`
- `--available`, `-a`
- `--list`
- `--interactive`, `-i`
- `--symlink` (requires `--skill` + `--model`)
- `--uninstall <id>` (requires `--model`)
- `--uninstall-interactive`

### `version`

```bash
flutter_shadcn version [--check]
```

### `upgrade`

```bash
flutter_shadcn upgrade [--force]
```

### `feedback`

Submit issue feedback (interactive by default).

```bash
flutter_shadcn feedback
flutter_shadcn feedback @<namespace> --type bug --title "..." --body "..."
```

Options:
- `--type`, `-t`
- `--title`
- `--body`

---

## Common Workflows

```bash
# 1) choose namespace + discover
flutter_shadcn registries
flutter_shadcn default shadcn
flutter_shadcn search @shadcn dialog

# 2) preview + install
flutter_shadcn dry-run @shadcn/dialog --json
flutter_shadcn add @shadcn/dialog

# 3) verify
flutter_shadcn doctor --json
flutter_shadcn validate --json
flutter_shadcn audit --json
flutter_shadcn deps --json
```
