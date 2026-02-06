# Accordion (`accordion`)

Single-expansion accordion with configurable triggers and theming.

---

## When to use

- Use this when:
  - you need collapsible sections with one open at a time.
- Avoid when:
  - multiple sections should stay open (use `collapsible`).

---

## Install

```bash
flutter_shadcn add accordion
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/accordion/accordion.dart';
```

---

## Minimal example

```dart
Accordion(
  items: const [
    AccordionItem(title: Text('Title'), content: Text('Content')),
  ],
)
```

---

## API

### Constructor

- `Accordion` — takes `items` list.
- `AccordionItem` — section with `title`, `content`.
- `AccordionTrigger` — interactive header widget.
- `AccordionTheme` — theme for spacing and styles.

---

## Theming

- `AccordionTheme` controls spacing, colors, and animation defaults.

---

## Accessibility

- Ensure triggers are keyboard focusable.

---

## Do / Don’t

**Do**
- ✅ Keep titles short and descriptive.

**Don’t**
- ❌ Nest large scrollables without constraints.

---

## Related components

- `collapsible`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
