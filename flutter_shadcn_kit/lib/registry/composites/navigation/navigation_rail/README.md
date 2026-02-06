# Navigation Rail (`navigation_rail`)

Composite export for NavigationRail and related items.

---

## When to use

- Use this when:
  - you need a compact rail-style navigation.
  - you want rail alignment and label control options.
- Avoid when:
  - you need a full-width sidebar with expanded labels.

---

## Install

```bash
flutter_shadcn add navigation_rail
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/navigation/navigation_rail/navigation_rail.dart';
```

---

## Minimal example

```dart
NavigationRail(
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

- `NavigationRail`
- `NavigationItem`
- `NavigationDivider`
- `NavigationLabel`
- `NavigationGap`
- `NavigationWidget`
- `NavigationLabelType`
- `NavigationLabelPosition`
- `NavigationRailAlignment`
- `NavigationButton`

---

## Theming

- Uses navigation bar theming from the navigation registry.

---

## Accessibility

- Ensure rail items are reachable via keyboard navigation.

---

## Do / Don’t

**Do**
- ✅ Use rail alignment to match layout density.

**Don’t**
- ❌ Use rails for long descriptive labels.

---

## Related components

- `navigation_bar`
- `navigation_sidebar`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
