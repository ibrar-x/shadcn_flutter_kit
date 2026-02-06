# Pagination (`pagination`)

Page navigation controls with skip, previous/next, and ellipsis handling.

---

## When to use

- Use this when:
  - you need page-by-page navigation.
- Avoid when:
  - infinite scroll is preferred.

---

## Install

```bash
flutter_shadcn add pagination
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/pagination/pagination.dart';
```

---

## Minimal example

```dart
Pagination(
  page: 1,
  total: 10,
  onChanged: (page) {},
)
```

---

## API

### Constructor

- `Pagination`
  - `page` (`int`, required)
  - `total` (`int`, required)
  - `onChanged` (`ValueChanged<int>?`)
  - `showLabel`, `gap`, `siblingCount`, `boundaryCount`
- `PaginationTheme` — spacing and label visibility.

---

## Theming

- `PaginationTheme` controls gap and label display.

---

## Accessibility

- Provide labels for next/previous buttons.

---

## Do / Don’t

**Do**
- ✅ Keep `page` within `total` range.

**Don’t**
- ❌ Hide page count when users need context.

---

## Related components

- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
