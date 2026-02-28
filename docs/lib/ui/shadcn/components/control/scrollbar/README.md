# Scrollbar (`scrollbar`)

Themeable scrollbar wrapper built on `RawScrollbar`.

---

## When to use

- Use this when:
  - you need a consistent scrollbar appearance across the kit.
  - you want theme-driven thickness, radius, and color.
- Avoid when:
  - you need platform-native scrollbars without customization.

---

## Install

```bash
flutter_shadcn add scrollbar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/scrollbar/scrollbar.dart';
```

---

## Minimal example

```dart
Scrollbar(
  child: ListView.builder(
    itemCount: 30,
    itemBuilder: (_, index) => Text('Row $index'),
  ),
)
```

---

## Common patterns

### Pattern: Always show thumb

```dart
Scrollbar(
  thumbVisibility: true,
  child: ListView.builder(
    itemCount: 30,
    itemBuilder: (_, index) => Text('Row $index'),
  ),
)
```

---

## API

### Constructor

- `Scrollbar`
  - `child` (`Widget`, required)
  - `controller` (`ScrollController?`)
  - `thumbVisibility` (`bool?`)
  - `trackVisibility` (`bool?`)
  - `thickness` (`double?`)
  - `radius` (`Radius?`)
  - `color` (`Color?`)
  - `interactive` (`bool?`)
  - `notificationPredicate` (`ScrollNotificationPredicate?`)
  - `scrollbarOrientation` (`ScrollbarOrientation?`)

---

## Theming

- `ScrollbarTheme` in the shared theme system controls defaults.
- `color` and `thickness` can be overridden per instance.

---

## Accessibility

- Larger `thickness` improves usability for pointer devices.

---

## Do / Don’t

**Do**
- ✅ Provide a controller when the scrollable already uses one.
- ✅ Set `thumbVisibility` for persistent affordances on desktop.

**Don’t**
- ❌ Wrap nested scroll views with multiple scrollbars.

---

## Related components

- `scrollview`
- `layout/scrollable_client`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
