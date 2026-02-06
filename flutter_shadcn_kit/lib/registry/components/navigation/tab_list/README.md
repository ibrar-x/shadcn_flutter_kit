# Tab List (`tab_list`)

Horizontal tab header row with active indicator.

---

## When to use

- Use this when:
  - you want a lightweight tab header strip.
- Avoid when:
  - you need a full tab system with content (use `tabs`).

---

## Install

```bash
flutter_shadcn add tab_list
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/tab_list/tab_list.dart';
```

---

## Minimal example

```dart
TabList(
  index: 0,
  onChanged: (index) {},
  children: const [
    TabChild(child: Text('Tab 1')),
    TabChild(child: Text('Tab 2')),
  ],
)
```

---

## API

### Constructor

- `TabList`
  - `index` (`int?`)
  - `onChanged` (`ValueChanged<int>?`)
  - `children` (`List<TabChild>`)
- `TabListTheme` — border and indicator styling.

---

## Theming

- `TabListTheme` controls border and indicator colors.

---

## Accessibility

- Provide clear tab labels and focus states.

---

## Do / Don’t

**Do**
- ✅ Pair with `TabContainer` for state management.

**Don’t**
- ❌ Use without indicating active state.

---

## Related components

- `tab_container`
- `tabs`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
