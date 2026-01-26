# Context Menu

Desktop-style context menus for text editing and custom actions.

`ContextMenu` wraps a `MenuButton`-powered popup/overlay and is already wired to
`EditableText` via `DesktopEditableTextContextMenu`. Use `ContextMenuPopup` when
you need to show menu entries in a custom layout or hook into desktop-like
shortcuts.

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/menu/context_menu.dart';

ContextMenu(
  menuEntries: [
    ContextMenuEntry(type: ContextMenuButtonType.cut),
    ContextMenuEntry(type: ContextMenuButtonType.copy),
  ],
  child: Builder(...),
);
```

Wrap the tree with `ComponentTheme<ContextMenuTheme>` or provide an explicit
theme to adjust blur/opacity when needed (the default theme picks sensible
values).
