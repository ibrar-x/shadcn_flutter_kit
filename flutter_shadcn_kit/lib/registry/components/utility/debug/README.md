# Debug (`debug`)

Debug overlays and container helpers for layout inspection.

---

## When to use

- Use this when:
  - you need quick visual debugging for layout bounds.
  - you want temporary overlay stickers for positions.
- Avoid when:
  - shipping production UI without debug flags.

---

## Install

```bash
flutter_shadcn add debug
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/utility/debug/debug.dart';
```

---

## Minimal example

```dart
Text('Hello').debugContainer();
```

---

## Common patterns

### Pattern: Debug sticker

```dart
debugPostSticker(
  context,
  const Rect.fromLTWH(20, 20, 120, 40),
  const Color(0xFF00AAFF),
  'Origin',
);
```

---

## API

### Helpers

- `debugPostSticker`
- `DebugContainer.debugContainer`
- `kDebugStickerVisible`
- `kDebugContainerVisible`

---

## Theming

- Uses direct colors; intended for debug-only visualization.

---

## Accessibility

- Debug overlays are not accessibility-aware; disable in production.

---

## Do / Don’t

**Do**
- ✅ Guard usage with debug flags.

**Don’t**
- ❌ Ship debug overlays in release builds.

---

## Related components

- `wrapper`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
