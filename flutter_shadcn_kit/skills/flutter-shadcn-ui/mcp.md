# MCP Status

`flutter_shadcn` does not expose a dedicated MCP server. Use the CLI directly and prefer `--json` outputs for automation.

```bash
flutter_shadcn registries --json
flutter_shadcn list @shadcn --json
flutter_shadcn info @shadcn/button --json
flutter_shadcn dry-run @shadcn/button --json
flutter_shadcn validate --json
```

Install this skill into model folders with:

```bash
flutter_shadcn --advanced install-skill --skill flutter-shadcn-ui --model .codex
```
