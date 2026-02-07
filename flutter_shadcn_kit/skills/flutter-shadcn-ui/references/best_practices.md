# Best Practices

1. Prefer `list/search/info/dry-run` before `add`.
2. Use `dry-run` to preview dependencies and file changes.
3. Use `doctor` before manual troubleshooting.
4. Use `validate`, `audit`, and `deps` to catch drift early.
5. Keep `.shadcn/config.json` and manifests under version control.
6. Use manual file inspection only when CLI commands cannot run.
7. If you use fallback steps, return to CLI workflows after recovery.
