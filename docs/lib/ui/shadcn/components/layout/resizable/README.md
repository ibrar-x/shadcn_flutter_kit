# Resizable (`resizable`)

Resizable panels with draggable dividers.

---

## When to use

- Use this when:
  - you need resizable split panes.
- Avoid when:
  - a fixed layout is sufficient.

---

## Install

```bash
flutter_shadcn add resizable
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/resizable/resizable.dart';
```

---

## Minimal example

```dart
ResizablePanel(
  children: const [
    ResizablePane(child: Text('Left')),
    ResizablePane(child: Text('Right')),
  ],
)
```

---

## API

### Constructor

- `ResizablePanel` — container for panes.
- `ResizablePane` — resizable pane with controller.
- `HorizontalResizableDragger` / `VerticalResizableDragger` — dividers.
- `ResizablePaneController` — base controller interface.
- `AbsoluteResizablePaneController` / `FlexibleResizablePaneController` — controller types.

---

## Theming

- `ResizableDraggerTheme` controls dragger size, color, and icon.

---

## Accessibility

- Provide keyboard alternatives if resizing is essential.

---

## Do / Don’t

**Do**
- ✅ Set min/max sizes for panes.

**Don’t**
- ❌ Allow panes to collapse to unusable sizes.

---

## Related components

- `group`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
