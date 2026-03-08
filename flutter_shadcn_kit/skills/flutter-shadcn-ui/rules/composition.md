# Component Composition Rules

## Contents

- Keep overlay wrappers in place
- Compose with installed shadcn building blocks first
- Use Common Replacements before custom widgets
- Resolve framework import conflicts with `hide`
- Use dry-run before add/remove changes
- Use dependency-safe remove flows

---

## Keep overlay wrappers in place

If components (or their dependencies) rely on overlay behavior, app/root scope must include one of:

- `ShadcnApp`
- `ShadcnLayer`
- `OverlayManagerLayer`

Use `dry-run` to confirm overlay dependencies before installation.

```bash
flutter_shadcn dry-run @shadcn/dialog --json
```

---

## Compose with installed shadcn building blocks first

Prefer base composables (`app`, `scaffold`, `app_bar`, `card`) before building custom replacements.

**Incorrect:**

```bash
# Skip foundational components and hand-build everything from scratch
flutter_shadcn add @shadcn/dialog
```

**Correct:**

```bash
flutter_shadcn add @shadcn/app @shadcn/scaffold @shadcn/app_bar @shadcn/card
flutter_shadcn add @shadcn/dialog
```

---

## Use Common Replacements before custom widgets

Before creating custom wrappers, read:
`references/COMMON_PATCHED_WIDGETS_README.md`

If a registry/shared replacement exists, use it instead of adding a new custom widget.

---

## Resolve framework import conflicts with `hide`

When registry symbols share names with Material/Cupertino symbols (`Scaffold`, `AppBar`, `Card`, `AlertDialog`, `showDialog`, etc.), do not alias registry imports. Hide conflicting framework symbols and keep registry names canonical.

Required:

- Never import registry libraries with `as <alias>`.
- Use registry names directly (`Scaffold`, `AlertDialog`, `showDialog`, etc.).
- If Material/Cupertino is imported, hide every conflicting framework symbol (widgets, functions, classes, extensions, constants).

**Incorrect:**

```dart
import 'package:flutter/material.dart';
import 'package:my_app/ui/shadcn/components/scaffold.dart';
import 'package:my_app/ui/shadcn/components/dialog.dart';

final page = Scaffold(...); // conflict with Material Scaffold
showDialog(context: context, builder: (context) => AlertDialog(...)); // conflict with Material dialog symbols
```

**Correct:**

```dart
import 'package:flutter/material.dart'
    hide Scaffold, AppBar, Card, Drawer, AlertDialog, showDialog;
import 'package:my_app/ui/shadcn/components/scaffold.dart';
import 'package:my_app/ui/shadcn/components/dialog.dart';

final page = Scaffold(...);
showDialog(context: context, builder: (context) => AlertDialog(...));
```

Apply the same pattern for Cupertino conflicts:

```dart
import 'package:flutter/cupertino.dart'
    hide CupertinoNavigationBar, CupertinoAlertDialog, showCupertinoDialog;
```

---

## Use dry-run before add/remove changes

Preview dependency and file impact first.

**Incorrect:**

```bash
flutter_shadcn add @shadcn/navigation_menu @shadcn/select
```

**Correct:**

```bash
flutter_shadcn dry-run @shadcn/navigation_menu @shadcn/select --json
flutter_shadcn add @shadcn/navigation_menu @shadcn/select
```

---

## Use dependency-safe remove flows

Avoid force-removal unless explicitly intended.

**Incorrect:**

```bash
flutter_shadcn remove @shadcn/form_field --force
```

**Correct:**

```bash
flutter_shadcn remove @shadcn/form_field
# Only use --force after confirming consequences
```
