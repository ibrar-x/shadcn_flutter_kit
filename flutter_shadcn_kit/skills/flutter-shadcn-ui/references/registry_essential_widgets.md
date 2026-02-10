# Registry Essential Widgets and Patched Replacements

Use this reference when building app code from registry components.
It defines the non-optional wrappers and the preferred registry widgets over direct `material`/`cupertino` usage.

## 1) Required Infrastructure Wrappers

### A. Preferred app root: `ShadcnApp`

Import:
- `composites/layout/app/app.dart`

Why:
- wraps app content with `OverlayManagerLayer`
- applies `ShadcnUI` text/icon defaults
- resolves shadcn `ThemeData`

Use this as the default replacement for raw `MaterialApp`/`CupertinoApp` in registry-first apps.

### B. If not using `ShadcnApp`, add one overlay manager wrapper

Use exactly one:
- `ShadcnLayer`
- `OverlayManagerLayer`

Without this, overlay-heavy components (`popover`, `tooltip`, `menu`, `context_menu`, etc.) can become inconsistent.

### C. Drawer host requirement

`openDrawer` / `openSheetOverlay` require a `DrawerOverlay` host.

- If you use registry `Scaffold`, this is already provided internally.
- If you do not use registry `Scaffold`, wrap the subtree with `DrawerOverlay` manually.

### D. Keyboard focus infrastructure for complex menus/lists

Use:
- `SubFocusScope`
- `SubFocus`

for predictable keyboard traversal (especially in custom menu/list navigation flows).

## 2) Preferred Registry Replacements

Use these as the default mapping when generating app UI:

- App shell:
  - `MaterialApp` / `CupertinoApp` -> `ShadcnApp`
- Typography/icon defaults:
  - ad-hoc `DefaultTextStyle` + `IconTheme` wiring -> `ShadcnUI`
- Layout shell:
  - `material.Scaffold` / `material.AppBar` -> registry `Scaffold` / `AppBar`
- Surface:
  - `material.Card` -> registry `Card` (or `SurfaceCard`)
- Buttons:
  - `ElevatedButton` -> `PrimaryButton`
  - `OutlinedButton` -> `SecondaryButton` or `OutlineButton`
  - `TextButton` -> registry `TextButton`
- Dialog API:
  - `material.showDialog` -> registry `showDialog` from `overlay/dialog/dialog.dart`
  - `material.AlertDialog` -> registry `AlertDialog` from `overlay/alert_dialog/alert_dialog.dart`
- Overlay primitives:
  - manual `OverlayEntry` plumbing -> `showPopover`, `OverlayManager.showMenu`, `OverlayManager.showTooltip`

## 3) Material Composite Compatibility Layer

Component: `material` (`composites/layout/material/material.dart`)

This composite currently typedef-exports:
- `ShadcnUI`
- `AlertDialog`
- `PrimaryButton`, `SecondaryButton`, `TextButton`
- `ButtonDensity`
- `Card`

Use it for convenience imports, but do not assume it is a full drop-in replacement for all Flutter material widgets.

## 4) Text Selection / Context Menu Guidance

For editable text context menus, prefer registry context menu builders when you need shadcn-styled menus:
- `DesktopEditableTextContextMenu`
- `MobileEditableTextContextMenu`
- `buildEditableTextContextMenu` from `overlay/context_menu/context_menu.dart`

`TextField` exposes `contextMenuBuilder`; wire the registry builder explicitly when needed.

## 5) Import Collision Rules (Important)

Many registry types intentionally share common names (`Scaffold`, `AppBar`, `Card`, `TextButton`, `AlertDialog`, `showDialog`).

Prefer hiding conflicting Flutter widgets so registry widgets stay clean in code:

```dart
import 'package:flutter/material.dart'
    hide
        Scaffold,
        AppBar,
        Card,
        TextButton,
        AlertDialog,
        showDialog;

import 'package:your_app/ui/shadcn/composites/layout/app/app.dart';
import 'package:your_app/ui/shadcn/layout/scaffold/scaffold.dart't;
import 'package:your_app/ui/shadcn/control/button/button.dart';
import 'package:your_app/ui/shadcn/overlay/dialog/dialog.dart';
```

Use `m.` only for non-conflicting SDK APIs (for example `m.Colors`, `m.Icons`, `m.ThemeMode`).

## 6) Quick Decision Checklist for Agent Output

Before finalizing generated code:

1. Is app root wrapped with `ShadcnApp` (or one overlay manager wrapper)?
2. If drawer APIs are used, does a `DrawerOverlay` host exist?
3. Are shadcn widgets used instead of direct `material/cupertino` where registry equivalents exist?
4. Are Flutter conflicting widgets hidden (or clearly prefixed) to avoid collisions?
5. If overlay components are installed, is overlay infrastructure present?

## 7) Current Infrastructure Boundaries

Current registry provides:
- centralized overlay manager (`OverlayManager`, `OverlayManagerLayer`)
- drawer stack management
- menu/subfocus keyboard traversal

Do not assume dedicated standalone primitives named:
- `portal`
- `layer_manager` with typed global priorities (`LayerPriority`, `pushLayer`, `removeLayer`)
- `focus_trap` as a reusable public primitive

Model outputs should target the existing APIs above unless those primitives are explicitly added later.
