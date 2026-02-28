# Navigation Bar (`navigation_bar`)

Themed navigation bar supporting destinations, overflow, and responsive layout.

---

## When to use

- Use this when:
  - you need a bar/rail/sidebar navigation container.
- Avoid when:
  - a simple row of buttons is enough.

---

## Install

```bash
flutter_shadcn add navigation_bar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/navigation_bar/navigation_bar.dart';
```

---

## Minimal example

```dart
NavigationBar(
  index: 0,
  onSelected: (index) {},
  children: const [
    NavigationItem(icon: Icon(Icons.home), label: Text('Home')),
    NavigationItem(icon: Icon(Icons.search), label: Text('Search')),
  ],
)
```

---

## API

### Constructor

- `NavigationBar`
  - `index` (`int?`)
  - `onSelected` (`ValueChanged<int>?`)
  - `children` (`List<Widget>`)
  - `alignment` (`NavigationBarAlignment`)
  - `type` (`NavigationContainerType`)
- `NavigationItem` / `NavigationButton` — navigation entries.
- `NavigationRail` / `NavigationSidebar` — alternate layouts.
- `NavigationDivider`, `NavigationGap` — separators.
- `NavigationBarTheme` — colors, padding, and label styles.

---

## Theming

- `NavigationBarTheme` controls label styles, spacing, and surfaces.

---

## Accessibility

- Provide labels for icons and clear focus states.

---

## Do / Don’t

**Do**
- ✅ Use consistent labels across destinations.

**Don’t**
- ❌ Mix bar and rail styles without intent.

---

## Related components

- `navigation_menu`
- `breadcrumb`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
