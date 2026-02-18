# Gooey Toast (`gooey_toast`)

Animated gooey-style toast built on top of the existing `ToastController` overlay stack.

---

## Install

```bash
flutter_shadcn add gooey_toast
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/components/overlay/gooey_toast/gooey_toast.dart';
```

---

## Minimal Example

```dart
final controller = GooeyToastController();

controller.show(
  context: context,
  title: 'Changes saved',
  description: 'Your profile was updated successfully.',
  state: GooeyToastState.success,
  animationStyle: GooeyToastAnimationStyle.sileo,
  shapeStyle: GooeyToastShapeStyle.defaultShape,
);
```

---

## Notes

- Reuses existing `toast` overlay infrastructure.
- Supports autopilot expand/collapse for description and action content.
- Pauses dismiss countdown on hover (desktop/web) by default.
- Supports custom compact and expanded content via `compactChild` and `expandedChild`.
- Supports `GooeyToastTheme` through `ComponentTheme`.

## Theming

```dart
ComponentTheme<GooeyToastTheme>(
  data: const GooeyToastTheme(
    fill: Color(0xFF0B1020),
    animationStyle: GooeyToastAnimationStyle.smooth,
    shapeStyle: GooeyToastShapeStyle.soft,
  ),
  child: YourWidget(),
)
```
