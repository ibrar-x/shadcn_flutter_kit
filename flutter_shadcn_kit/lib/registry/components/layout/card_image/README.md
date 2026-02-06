# Card Image (`card_image`)

Interactive card that pairs an image with title/subtitle content.

---

## When to use

- Use this when:
  - you want an image-led card with text content.
- Avoid when:
  - you only need a static image (use `Image`).

---

## Install

```bash
flutter_shadcn add card_image
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/card_image/card_image.dart';
```

---

## Minimal example

```dart
CardImage(
  image: Image.network('https://example.com/image.jpg'),
  title: const Text('Card title'),
)
```

---

## API

### Constructor

- `CardImage`
  - `image` (`Widget`, required)
  - `title`, `subtitle`, `content` (`Widget?`)
  - `direction` (`Axis?`)
  - `onPressed` (`VoidCallback?`)
- `CardImageTheme` — style, spacing, and hover settings.

---

## Theming

- `CardImageTheme` controls button style, gap, and image scaling.

---

## Accessibility

- Provide alt text for images where appropriate.

---

## Do / Don’t

**Do**
- ✅ Use concise titles and subtitles.

**Don’t**
- ❌ Use large images without constraints.

---

## Related components

- `card`
- `basic`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
