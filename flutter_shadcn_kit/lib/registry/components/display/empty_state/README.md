# Empty State (`empty_state`)

Standardized empty state block for empty, no-results, or error.

---

## When to use

- Use this when:
  - you need a consistent empty state layout.
  - you want primary/secondary actions attached to empty states.
- Avoid when:
  - a short inline message is sufficient.

---

## Install

```bash
flutter_shadcn add empty_state
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/empty_state/empty_state.dart';
```

---

## Minimal example

```dart
EmptyState(
  title: const Text('No results'),
  description: const Text('Try adjusting your filters.'),
)
```

---

## Common patterns

### Pattern: Actions

```dart
EmptyState(
  title: const Text('No items'),
  description: const Text('Create a new item to get started.'),
  primaryAction: const EmptyStateAction(
    label: 'Create item',
    style: EmptyStateActionStyle.primary,
  ),
  secondaryAction: const EmptyStateAction(
    label: 'Learn more',
    style: EmptyStateActionStyle.link,
  ),
)
```

---

## API

### Constructor

- `EmptyState`
  - `variant` (`EmptyStateVariant`)
  - `size` (`EmptyStateSize`)
  - `icon`, `title`, `description` (`Widget?`)
  - `primaryAction`, `secondaryAction` (`EmptyStateAction?`)
  - `maxWidth` (`double?`)
- `EmptyStateAction`
  - `label` (`String`, required)
  - `onPressed` (`VoidCallback?`)
  - `icon` (`Widget?`)
  - `style` (`EmptyStateActionStyle`)

### Callbacks

- `onPressed` (EmptyStateAction)

---

## Theming

- `EmptyStateTheme` controls icon size/color, text styles, padding, and card styling.

---

## Accessibility

- Keep titles and descriptions concise and readable.
- Ensure action labels are descriptive.

---

## Do / Don’t

**Do**
- ✅ Use `variant` to match the situation (empty/no-results/error).

**Don’t**
- ❌ Present destructive actions in empty states.

---

## Related components

- `button`
- `card`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
