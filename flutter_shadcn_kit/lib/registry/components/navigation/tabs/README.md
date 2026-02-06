# Tabs (`tabs`)

Tabbed navigation primitives with lists and panes.

---

## When to use

- Use this when:
  - you need a complete tab system with list + content.
- Avoid when:
  - you only need the tab headers (use `tab_list`).

---

## Install

```bash
flutter_shadcn add tabs
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/tabs/tabs.dart';
```

---

## Minimal example

```dart
Tabs(
  index: 0,
  onChanged: (index) {},
  tabs: const [
    TabItem(child: Text('Tab 1')),
    TabItem(child: Text('Tab 2')),
  ],
  children: const [
    TabChildWidget(child: Text('Content 1')),
    TabChildWidget(child: Text('Content 2')),
  ],
)
```

---

## API

### Constructor

- `Tabs`
  - `tabs` (`List<TabChild>`, required)
  - `children` (`List<TabChild>`, required)
  - `index` (`int?`)
  - `onChanged` (`ValueChanged<int>?`)
- `TabList`, `TabPane`, `TabContainer` — tab primitives.
- `TabItem` / `KeyedTabItem`, `TabChildWidget` — tab elements.
- `TabsTheme` — overall styling.

---

## Theming

- `TabsTheme` controls borders, spacing, and text styles.

---

## Accessibility

- Ensure active tab is announced and focusable.

---

## Do / Don’t

**Do**
- ✅ Keep tab labels short.

**Don’t**
- ❌ Use too many tabs for narrow layouts.

---

## Related components

- `tab_container`
- `tab_list`
- `tab_pane`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
