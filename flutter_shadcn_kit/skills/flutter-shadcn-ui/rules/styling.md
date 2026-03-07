# Styling and Theme Rules

See [customization.md](../customization.md) for detailed theming workflows.

## Contents

- Theme via CLI first
- Keep managed paths under `lib/`
- Prefer semantic theming in app code
- Validate after styling changes

---

## Theme via CLI first

Do not start by manually rewriting shared theme files.

**Incorrect:**

```bash
# Edit color files by hand first and skip CLI tracking
vim lib/ui/shadcn/shared/theme/color_scheme.dart
```

**Correct:**

```bash
flutter_shadcn theme --list
flutter_shadcn theme --apply <preset-id>
# For local JSON input
flutter_shadcn --experimental theme --apply-file ./theme.json
```

---

## Keep managed paths under `lib/`

Install and shared paths must remain inside `lib/`.

**Incorrect:**

```json
{
  "installPath": "src/ui/shadcn",
  "sharedPath": "packages/shared"
}
```

**Correct:**

```json
{
  "installPath": "lib/ui/shadcn",
  "sharedPath": "lib/ui/shadcn/shared"
}
```

---

## Prefer semantic theming in app code

Avoid hardcoded visual constants for shadcn surfaces when theme tokens are available.

**Incorrect:**

```dart
Container(
  color: const Color(0xFF1D4ED8),
  child: const Text('Primary surface'),
)
```

**Correct:**

```dart
final scheme = Theme.of(context).colorScheme;
Container(
  color: scheme.primary,
  child: Text(
    'Primary surface',
    style: TextStyle(color: scheme.onPrimary),
  ),
)
```

---

## Validate after styling changes

Always re-run diagnostics after theme/path updates:

```bash
flutter_shadcn sync
flutter_shadcn doctor --json
flutter_shadcn validate --json
flutter_shadcn audit --json
```
