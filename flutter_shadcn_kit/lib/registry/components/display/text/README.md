# Text (`text`)

Typography helpers and fluent text modifiers.

---

## When to use

- Use this when:
  - you want fluent, chainable text styles.
  - you need shared typography from the shadcn theme.
- Avoid when:
  - you prefer direct `TextStyle` usage without modifiers.

---

## Install

```bash
flutter_shadcn add text
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/text/text.dart';
```

---

## Minimal example

```dart
Text('Hello').sans.large.bold.muted
```

---

## Common patterns

### Pattern: Headings and paragraphs

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Heading').h2,
    Text('Body copy goes here.').p,
  ],
)
```

### Pattern: Inline code

```dart
Text('flutter run').inlineCode
```

---

## API

### Constructor

- `TextModifier` — base class for chainable modifiers.
- `TextExtension` — fluent getters like:
  - font: `sans`, `mono`
  - size: `small`, `large`, `xSmall`, `xLarge`
  - weight: `light`, `medium`, `bold`, `extraBold`
  - color: `muted`, `primaryForeground`, `secondaryForeground`
  - semantic: `h1`, `h2`, `h3`, `p`, `lead`, `inlineCode`, `li`

---

## Theming

- Modifiers resolve fonts and sizes from `ThemeData.typography`.

---

## Accessibility

- Ensure heading hierarchy matches document structure.

---

## Do / Don’t

**Do**
- ✅ Use heading modifiers for section structure.

**Don’t**
- ❌ Mix multiple font families in the same paragraph without intent.

---

## Related components

- `selectable`
- `code_snippet`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
