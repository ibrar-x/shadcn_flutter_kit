# Best Practices

1. Preview before installing: Use `dry-run` to understand scope
2. Start with core components: button, input, form before complex layouts
3. Understand dependencies: Menu depends on Popover which depends on Overlay
4. Keep theme changes centralized: Apply themes via CLI, not manual edits
5. Use shared utilities: Don't reinvent extensions, tokens, or form helpers
6. Validate setup: Run `doctor` before troubleshooting
7. Backup config: Version `.shadcn/config.json` in git
