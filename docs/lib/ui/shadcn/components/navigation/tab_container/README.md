# Tab Container (`tab_container`)

Coordinated tab state manager with customizable builders.

---

## When to use

- Use this when:
  - you need to coordinate tab selection and content.
- Avoid when:
  - a single `TabList` is enough.

---

## Install

```bash
flutter_shadcn add tab_container
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/tab_container/tab_container.dart';
```

---

## Minimal example

```dart
TabContainer(
  index: 0,
  onChanged: (index) {},
  children: const [
    TabItem(child: Text('Tab 1')),
    TabItem(child: Text('Tab 2')),
  ],
)
```

---

## API

### Constructor

- `TabContainer`
  - `index` (`int?`)
  - `onChanged` (`ValueChanged<int>?`)
  - `children` (`List<Widget>`)
  - `builder`, `childBuilder`
- `TabItem` / `KeyedTabItem` — tab items.
- `TabChildWidget` / `KeyedTabChildWidget` — tab content wrappers.
- `TabContainerTheme` — builder defaults.

---

## Theming

- `TabContainerTheme` controls builders.

---

## Accessibility

- Ensure selected tab state is announced.

---

## Do / Don’t

**Do**
- ✅ Keep tab labels short.

**Don’t**
- ❌ Rebuild heavy content unnecessarily on tab change.

---

## Related components

- `tab_list`
- `tab_pane`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
