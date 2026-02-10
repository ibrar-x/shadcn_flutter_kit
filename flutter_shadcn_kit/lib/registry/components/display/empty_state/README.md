# Empty State (`empty_state`)

Standardized empty state block for empty, no-results, or error.

---

## When to use

- Use this when:
  - you need a consistent empty state layout.
  - you want primary/secondary actions plus a supporting link action.
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
  title: const Text('No Projects Yet'),
  description: const Text(
    "You haven't created any projects yet. Get started by creating your first project.",
  ),
  primaryAction: const EmptyStateAction(
    label: 'Create Project',
    style: EmptyStateActionStyle.primary,
  ),
  secondaryAction: const EmptyStateAction(
    label: 'Import Project',
    style: EmptyStateActionStyle.secondary,
  ),
  footerAction: const EmptyStateAction(
    label: 'Learn More',
    style: EmptyStateActionStyle.link,
    trailingIcon: Icon(RadixIcons.arrowTopRight),
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
  - `primaryAction`, `secondaryAction`, `footerAction` (`EmptyStateAction?`)
  - `maxWidth` (`double?`)
  - `showIconContainer` (`bool`)
- `EmptyStateAction`
  - `label` (`String`, required)
  - `onPressed` (`VoidCallback?`)
  - `icon`, `trailingIcon` (`Widget?`)
  - `style` (`EmptyStateActionStyle`)

### Callbacks

- `onPressed` (EmptyStateAction)

---

## Theming

- `EmptyStateTheme` controls icon size/color, icon badge styling, text styles, padding, and card styling.

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
