# Collapsible (`collapsible`)

Independent sections that toggle their own visibility.

---

## When to use

- Use this when:
  - you need independent expand/collapse sections.
- Avoid when:
  - only one section should be open (use `accordion`).

---

## Install

```bash
flutter_shadcn add collapsible
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/collapsible/collapsible.dart';
```

---

## Minimal example

```dart
Collapsible(
  children: const [
    CollapsibleTrigger(title: Text('Toggle')),
    CollapsibleContent(child: Text('Hidden content')),
  ],
)
```

---

## API

### Constructor

- `Collapsible`
  - `children` (`List<Widget>`, required)
  - `isExpanded` (`bool?`)
  - `onExpansionChanged` (`ValueChanged<bool>?`)
- `CollapsibleTrigger` — interactive header.
- `CollapsibleContent` — animated content panel.
- `CollapsibleTheme` — spacing and styling.

---

## Theming

- `CollapsibleTheme` controls padding and animation defaults.

---

## Accessibility

- Make triggers keyboard focusable.

---

## Do / Don’t

**Do**
- ✅ Keep content concise to avoid long scroll jumps.

**Don’t**
- ❌ Nest collapsibles without clear hierarchy.

---

## Related components

- `accordion`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
