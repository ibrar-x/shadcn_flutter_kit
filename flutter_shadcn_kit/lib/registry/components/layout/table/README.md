# Table (`table`)

Resizable table layout with headers, footers, and frozen cells.

---

## When to use

- Use this when:
  - you need a resizable, structured table layout.
- Avoid when:
  - a simple list view is enough.

---

## Install

```bash
flutter_shadcn add table
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/table/table.dart';
```

---

## Minimal example

```dart
Table(
  rows: const [
    TableRow(cells: [TableCell(child: Text('A')), TableCell(child: Text('B'))]),
  ],
)
```

---

## API

### Constructor

- `Table` — main table widget.
- `ResizableTable` — table with resizable columns.
- `TableHeader` / `TableFooter` — row types.
- `TableRow` — row model.
- `TableCell` — cell model.
- `ResizableTableController` — column sizing controller.

---

## Theming

- `TableTheme`, `TableCellTheme`, `ResizableTableTheme`.

---

## Accessibility

- Provide headers for columns where possible.

---

## Do / Don’t

**Do**
- ✅ Use `ResizableTable` when users need column control.

**Don’t**
- ❌ Render huge datasets without virtualization.

---

## Related components

- `scrollable_client`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
