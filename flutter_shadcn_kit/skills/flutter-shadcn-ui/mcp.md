# MCP Status

`flutter_shadcn` currently does not expose a dedicated `mcp` command.

Use these alternatives:

1. Use the CLI directly for registry discovery and install flows (`list`, `search`, `info`, `dry-run`, `add`).
2. Install this skill into model folders with `install-skill` so AI assistants can follow consistent CLI workflows.
3. Use `--json` outputs (`doctor`, `dry-run`, `validate`, `audit`, `deps`, `list`, `search`, `info`, `registries`) for machine-readable automation.

## Example automation-friendly flow

```bash
flutter_shadcn registries --json
flutter_shadcn search @shadcn dialog --json
flutter_shadcn dry-run @shadcn/dialog --json
flutter_shadcn add @shadcn/dialog
flutter_shadcn doctor --json
```
