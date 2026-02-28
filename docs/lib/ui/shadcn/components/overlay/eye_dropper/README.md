# Eye Dropper (`eye_dropper`)

Layer that lets users sample colors from the screen with preview adornments.

---

## When to use

- Use this when:
  - you need an eye-dropper inside a color picker.
  - you want a magnified preview and picked-color label.
- Avoid when:
  - a simple color input is enough.

---

## Install

```bash
flutter_shadcn add eye_dropper
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/eye_dropper/eye_dropper.dart';
```

---

## Minimal example

```dart
EyeDropperLayer(
  child: const MyApp(),
  previewLabelBuilder: (context, color) => Text(colorToHex(color)),
)
```

---

## Common patterns

### Pattern: Prompt for a pick

```dart
final scope = EyeDropperLayerScope.find(context);
final color = await scope.promptPickColor();
```

---

## API

### Types

- `EyeDropperLayer`
- `EyeDropperLayerScope`
- `EyeDropperResult`
- `PreviewLabelBuilder`

---

## Theming

- Follows typography and surface tokens from `Theme.of(context)`.

---

## Accessibility

- Provide textual feedback for picked colors when possible.

---

## Do / Don’t

**Do**
- ✅ Use `previewLabelBuilder` to show readable color values.

**Don’t**
- ❌ Activate the eye dropper without a clear exit path.

---

## Related components

- `color_picker`
- `color`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
