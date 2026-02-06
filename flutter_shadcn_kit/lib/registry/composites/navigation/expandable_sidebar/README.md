# Expandable Sidebar (`expandable_sidebar`)

Composite export for expandable navigation rails.

---

## When to use

- Use this when:
  - you need a rail plus expandable content area.
  - you want a simple divider + rail layout wrapper.
- Avoid when:
  - you already manage layout with a custom split view.

---

## Install

```bash
flutter_shadcn add expandable_sidebar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/navigation/expandable_sidebar/expandable_sidebar.dart';
```

---

## Minimal example

```dart
ExpandableSidebar(
  rail: NavigationRail(
    index: 0,
    onSelected: (index) {},
    children: const [
      NavigationItem(child: Icon(Icons.home), label: Text('Home')),
    ],
  ),
  content: const Center(child: Text('Content')),
)
```

---

## API

### Types

- `ExpandableSidebar`
- `NavigationRail`
- `NavigationItem`
- `NavigationLabel`
- `NavigationDivider`
- `NavigationRailAlignment`
- `OutlinedContainer`

---

## Theming

- Uses navigation and outlined container theming.

---

## Accessibility

- Ensure sidebar and content regions are both reachable.

---

## Do / Don’t

**Do**
- ✅ Keep content scrollable if it grows.

**Don’t**
- ❌ Hide critical actions only in the rail.

---

## Related components

- `navigation_rail`
- `navigation_sidebar`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
