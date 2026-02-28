# Button (`button`)

Shadcn-style button system with variants, toggles, and groups.

---

## When to use

- Use this when:
  - you need consistent button variants across the app (primary/secondary/ghost/etc.).
  - you need toggle or selected-state buttons.
  - you want grouped buttons with shared borders.
- Avoid when:
  - a plain `GestureDetector` is sufficient and no theming/variants are needed.

---

## Install

```bash
flutter_shadcn add button
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/button/button.dart';
```

---

## Minimal example

```dart
PrimaryButton(
  onPressed: () {},
  child: const Text('Save'),
)
```

---

## Common patterns

### Pattern: Variant buttons

```dart
Column(
  children: const [
    PrimaryButton(child: Text('Primary')),
    SecondaryButton(child: Text('Secondary')),
    OutlineButton(child: Text('Outline')),
    GhostButton(child: Text('Ghost')),
  ],
)
```

### Pattern: Icon button

```dart
IconButton.primary(
  icon: const Icon(Icons.add),
  onPressed: () {},
)
```

### Pattern: Toggle / selected buttons

```dart
Toggle(
  value: isEnabled,
  onChanged: (next) => setState(() => isEnabled = next),
  child: const Text('Toggle'),
)

SelectedButton(
  value: isSelected,
  onChanged: (next) => setState(() => isSelected = next),
  child: const Text('Selected'),
)
```

### Pattern: Button group

```dart
ButtonGroup.horizontal(
  children: const [
    OutlineButton(child: Text('Left')),
    OutlineButton(child: Text('Middle')),
    OutlineButton(child: Text('Right')),
  ],
)
```

---

## API

### Constructor

- `Button` — base widget requiring `child` and `style`.
- `PrimaryButton`, `SecondaryButton`, `OutlineButton`, `GhostButton`, `LinkButton`, `TextButton`, `DestructiveButton`, `CardButton`, `TabButton` — pre-styled variants.
- `IconButton` — icon-only button, with named constructors like `IconButton.primary` and `IconButton.secondary`.
- `Toggle` — boolean toggle button.
- `SelectedButton` — selected/unselected button with distinct styles.
- `ButtonGroup` — groups multiple buttons with shared borders.

### Callbacks

- `onPressed` (buttons and icon buttons)
- `onChanged` (toggle and selected buttons)
- `onHover`, `onFocus`
- `onTapDown`, `onTapUp`, `onTapCancel`
- `onSecondaryTapDown`, `onSecondaryTapUp`, `onSecondaryTapCancel`
- `onTertiaryTapDown`, `onTertiaryTapUp`, `onTertiaryTapCancel`
- `onLongPressStart`, `onLongPressUp`, `onLongPressMoveUpdate`, `onLongPressEnd`
- `onSecondaryLongPress`, `onTertiaryLongPress`

---

## Theming

- `ButtonStyle` drives padding, decoration, typography, and state-based visuals.
- `ButtonStyleOverride` can override style values locally for grouped or scoped changes.
- `ButtonTheme` in the shared theme system can override decoration, padding, text style, and icon theme.

---

## Accessibility

- Uses `FocusNode` and focus callbacks for keyboard navigation.
- Focus outline can be disabled via `disableFocusOutline` where supported.
- Hover and pressed states are exposed via callbacks for custom a11y behavior.

---

## Do / Don’t

**Do**
- ✅ Use variant widgets for consistent styling.
- ✅ Use `ButtonGroup` when buttons should visually connect.

**Don’t**
- ❌ Nest buttons inside other `Clickable` or `GestureDetector` widgets.
- ❌ Disable focus outlines without providing an alternate focus indicator.

---

## Related components

- `clickable`
- `hover`
- `patch`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
