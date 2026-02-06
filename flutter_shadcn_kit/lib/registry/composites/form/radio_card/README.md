# Radio Card (`radio_card`)

Composite export for RadioCard and RadioGroup.

---

## When to use

- Use this when:
  - you want card-like radio selections.
  - you need a grouped radio controller.
- Avoid when:
  - a simple radio list is sufficient.

---

## Install

```bash
flutter_shadcn add radio_card
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/form/radio_card/radio_card.dart';
```

---

## Minimal example

```dart
RadioGroup<String>(
  value: 'basic',
  onChanged: (value) {},
  children: const [
    RadioCard(value: 'basic', child: Text('Basic')),
    RadioCard(value: 'pro', child: Text('Pro')),
  ],
)
```

---

## API

### Types

- `RadioCard<T>`
- `RadioGroup<T>`
- `RadioGroupController<T>`
- `RadioItem<T>`

---

## Theming

- Uses radio group theming from the form registry.

---

## Accessibility

- Ensure cards have proper labels and focus states.

---

## Do / Don’t

**Do**
- ✅ Keep card content concise.

**Don’t**
- ❌ Use for large, scroll-heavy option sets.

---

## Related components

- `radio_group`
- `card`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
