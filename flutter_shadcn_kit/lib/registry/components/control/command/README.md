# Command (`command`)

Command palette with search, keyboard navigation, and customizable result builders.

---

## When to use

- Use this when:
  - you need a command palette or quick action search.
  - you want keyboard navigation with async/streamed results.
- Avoid when:
  - a standard `Search` or `ListView` is sufficient.

---

## Install

```bash
flutter_shadcn add command
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/command/command.dart';
```

---

## Minimal example

```dart
Command(
  builder: (context, query) async* {
    final items = <Widget>[
      CommandItem(
        title: const Text('Open settings'),
        onTap: () {},
      ),
    ];
    yield items;
  },
)
```

---

## Common patterns

### Pattern: Open a dialog command palette

```dart
await showCommandDialog<void>(
  context: context,
  builder: (context, query) async* {
    yield [
      CommandCategory(
        title: const Text('General'),
        children: [
          CommandItem(
            title: const Text('New file'),
            onTap: () {},
          ),
        ],
      ),
    ];
  },
);
```

### Pattern: Keyboard shortcut hints

```dart
CommandItem(
  title: const Text('Search'),
  trailing: CommandKeyboardDisplay.fromActivator(
    activator: const SingleActivator(LogicalKeyboardKey.keyK, meta: true),
  ),
  onTap: () {},
)
```

---

## API

### Constructor

- `Command` — requires a `builder` that returns `Stream<List<Widget>>`.
- `showCommandDialog` — shows a modal command palette dialog.
- `CommandItem` — selectable command row with `leading`, `title`, `trailing`.
- `CommandCategory` — groups items under a header.
- `CommandEmpty` — default empty state widget.
- `CommandKeyboardDisplay` — renders keyboard shortcuts.

### Callbacks

- `builder` (Command) — `Stream<List<Widget>> Function(BuildContext, String?)`.
- `onTap` (CommandItem)
- `emptyBuilder`, `loadingBuilder`, `errorBuilder` (Command)

---

## Theming

- Palette surface styles read from the shared `Theme` in `shadcn`.
- Dialog wrapper uses `ModalBackdrop` and respects `surfaceOpacity` and `surfaceBlur`.

---

## Accessibility

- Keyboard navigation is handled by the command state.
- Provide readable labels for command titles and shortcuts.

---

## Do / Don’t

**Do**
- ✅ Stream results from async sources (search, commands).
- ✅ Group items with `CommandCategory` for scannability.

**Don’t**
- ❌ Block UI with heavy synchronous builders.
- ❌ Omit `onTap` for actionable items.

---

## Related components

- `dialog`
- `input`
- `overlay`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`
