# Install flutter-shadcn-ui Skill

Use the Flutter shadcn CLI skill installer from the target project root.

## Install

```bash
# Interactive
flutter_shadcn install-skill --skill flutter-shadcn-ui

# Direct install to one model folder
flutter_shadcn install-skill --skill flutter-shadcn-ui --model .codex
```

## Verify

```bash
flutter_shadcn install-skill --list
```

## Install to Multiple Models with Symlinks

```bash
# Install into one model
flutter_shadcn install-skill --skill flutter-shadcn-ui --model .codex

# Symlink to other discovered models
flutter_shadcn install-skill --symlink --skill flutter-shadcn-ui --model .codex
```

## Uninstall

```bash
flutter_shadcn install-skill --uninstall flutter-shadcn-ui --model .codex
# or interactive removal
flutter_shadcn install-skill --uninstall-interactive
```

## Notes

- `skill.json` or `skill.yaml` must exist in the source skill folder.
- The installer copies files declared in `skill.json` and keeps management files (`skill.json`, `skill.yaml`) in the source registry.
- If local skill discovery fails, set `--skills-url` explicitly.
