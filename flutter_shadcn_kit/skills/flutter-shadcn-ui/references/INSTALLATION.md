# Skill Installation

## Preferred: CLI Installation

Use `install-skill` as the default path.

```bash
flutter_shadcn install-skill --skill flutter-shadcn-ui --model .claude
```

Useful options:

```bash
flutter_shadcn install-skill --list
flutter_shadcn install-skill --available
flutter_shadcn install-skill --interactive
flutter_shadcn install-skill --symlink
```

Source: this skill reference set and `flutter_shadcn install-skill --help`.

## Fallback: Manual Installation (Only if CLI Fails)

Use this only when `flutter_shadcn install-skill` cannot be used.

1. Create model folder

```bash
mkdir -p .claude/flutter-shadcn-ui
```

2. Copy skill files

```bash
cp SKILL.md .claude/flutter-shadcn-ui/
cp skill.json .claude/flutter-shadcn-ui/
cp skill.yaml .claude/flutter-shadcn-ui/
cp skill.prompt .claude/flutter-shadcn-ui/
cp -R references .claude/flutter-shadcn-ui/
```

3. Repeat for other model folders as needed (`.gpt4/`, `.cursor/`, `.gemini/`).

## Verification

If CLI is available:

```bash
flutter_shadcn install-skill --list
```

If CLI is unavailable, verify destination contains:
- `SKILL.md`
- `skill.json`
- `references/`
