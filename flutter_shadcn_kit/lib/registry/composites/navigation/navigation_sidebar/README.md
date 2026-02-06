# Navigation Sidebar (`navigation_sidebar`)

Composite export for NavigationSidebar and related items.

---

## When to use

- Use this when:
  - you need a vertical sidebar navigation with labels.
  - you want a concise import for navigation bar items.
- Avoid when:
  - a bottom navigation bar is more appropriate.

---

## Install

```bash
flutter_shadcn add navigation_sidebar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/navigation/navigation_sidebar/navigation_sidebar.dart';
```

---

## Minimal example

```dart
NavigationSidebar(
  index: 0,
  onSelected: (index) {},
  children: const [
    NavigationItem(child: Icon(Icons.home), label: Text('Home')),
    NavigationItem(child: Icon(Icons.settings), label: Text('Settings')),
  ],
)
```

---

## API

### Types

- `NavigationSidebar`
- `NavigationItem`
- `NavigationDivider`
- `NavigationLabel`
- `NavigationGap`
- `NavigationLabelType`
- `NavigationLabelPosition`
- `NavigationButton`
- `OutlinedContainer`

---

## Theming

- Uses navigation bar theming from the navigation registry.

---

## Accessibility

- Provide clear labels and focus states for navigation items.

---

## Do / Don’t

**Do**
- ✅ Keep the selected index in sync with routing.

**Don’t**
- ❌ Hide essential navigation behind unlabelled icons.

---

## Related components

- `navigation_bar`
- `navigation_rail`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
