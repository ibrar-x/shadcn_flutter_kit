# Steps (`steps`)

Vertical step list with numbered indicators and connectors.

---

## When to use

- Use this when:
  - you need to show a multi-step process.
- Avoid when:
  - a timeline is more appropriate.

---

## Install

```bash
flutter_shadcn add steps
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/steps/steps.dart';
```

---

## Minimal example

```dart
Steps(
  children: const [
    StepItem(title: Text('Step 1'), content: [Text('Details')]),
    StepItem(title: Text('Step 2'), content: [Text('More')]),
  ],
)
```

---

## API

### Constructor

- `Steps` — container for step items.
- `StepItem` — title + content block.
- `StepsTheme` — indicator size, spacing, and colors.

---

## Theming

- `StepsTheme` controls indicator size, spacing, and connector thickness.

---

## Accessibility

- Provide clear step titles and instructions.

---

## Do / Don’t

**Do**
- ✅ Keep each step concise.

**Don’t**
- ❌ Use steps for unordered lists.

---

## Related components

- `timeline`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
