# Fade Scroll (`fade_scroll`)

Edge fade overlays for scrollable content.

---

## When to use

- Use this when:
  - you want visual fade cues at scroll edges.
- Avoid when:
  - the scroll area already has strong boundary cues.

---

## Install

```bash
flutter_shadcn add fade_scroll
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/fade_scroll/fade_scroll.dart';
```

---

## Minimal example

```dart
FadeScroll(
  child: ListView.builder(
    itemCount: 50,
    itemBuilder: (_, i) => Text('Row $i'),
  ),
)
```

---

## API

### Constructor

- `FadeScroll`
  - `startOffset`, `endOffset`
  - `gradient` (`List<Color>?`)
- `FadeScrollTheme` — theme defaults.

---

## Theming

- `FadeScrollTheme` controls fade offsets and gradient colors.

---

## Accessibility

- Ensure fade does not obscure important content.

---

## Do / Don’t

**Do**
- ✅ Use subtle gradients for readability.

**Don’t**
- ❌ Fade interactive elements near edges without padding.

---

## Related components

- `scrollable_client`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
