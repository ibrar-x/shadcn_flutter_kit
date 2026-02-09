# Filter Bar (`filter_bar`)

Controlled filter header with search, sort, chips, date range, and clear-all actions.

---

## When to use

- Use this when:
  - you need a consistent filter toolbar for list or table pages.
  - filtering state is owned by the page and passed down as a single object.
- Avoid when:
  - you only need one simple search field.
  - filtering must be coupled to data fetching inside the widget.

---

## Install

```bash
flutter_shadcn add filter_bar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/filter_bar/filter_bar.dart';
```

---

## Minimal example

```dart
FilterState state = const FilterState(
  sortId: 'newest',
);

FilterBar(
  state: state,
  sortOptions: const [
    FilterSortOption(id: 'newest', label: 'Newest'),
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ],
  resultsCount: 42,
  onStateChanged: (next) {
    setState(() => state = next);
  },
)
```

---

## Common patterns

### Pattern: Generic custom filters

```dart
FilterBar(
  state: state,
  customFilters: [
    FilterCustomFilter(
      id: 'status',
      builder: (context, state, onStateChanged) {
        return Select<String>(
          value: state.customValue<String>('status'),
          canUnselect: true,
          placeholder: const Text('Status'),
          onChanged: (next) {
            onStateChanged(state.setCustomValue('status', next));
          },
          itemBuilder: (context, value) => Text(value),
          popup: SelectPopup<String>(
            items: SelectItemList(
              children: const [
                SelectItemButton<String>(value: 'open', child: Text('Open')),
                SelectItemButton<String>(value: 'closed', child: Text('Closed')),
              ],
            ),
          ).call,
        );
      },
    ),
  ],
  onStateChanged: (next) => setState(() => state = next),
)
```

### Pattern: Trailing page-specific widgets

```dart
FilterBar(
  state: state,
  trailingFilters: [
    StatusSelect(
      value: selectedStatus,
      onChanged: (status) {
        final chips = [
          ...state.chips.where((c) => !c.key.startsWith('status:')),
          if (status != null)
            FilterChipData(
              key: 'status:$status',
              label: 'Status: ${status.label}',
            ),
        ];
        onStateChanged(state.copyWith(chips: chips));
      },
    ),
  ],
  onStateChanged: (next) => setState(() => state = next),
)
```

---

## API

### Constructor

- `FilterBar`
- `state` (`FilterState`, required)
- `onStateChanged` (`ValueChanged<FilterState>`, required)
- `sortOptions` (`List<FilterSortOption>`, optional)
- `enableDateRange` (`bool`, optional)
- `resultsCount` (`int?`, optional)
- `searchPlaceholder` (`String`, optional)
- `searchDebounce` (`Duration?`, optional)
- `trailingFilters` (`List<Widget>`, optional)
- `customFilters` (`List<FilterCustomFilter>`, optional)
- `style` (`FilterBarStyle?`, optional)
- `clearPolicy` (`FilterClearPolicy`, optional)
- `onClearAll` (`FilterState Function(FilterState current)?`, optional)
- `showClearAllWhenEmpty` (`bool`, optional)
- `clearPolicy.clearCustomFilters` (`bool`, optional, default: `true`)

### Callbacks

- `onStateChanged` emits the next `FilterState` whenever the UI changes.
- `onClearAll` optionally overrides clear-all behavior with custom policy logic.

---

## Theming

- The widget pulls colors/typography from `Theme.of(context)` and supports compact density through `FilterBarStyle`.
- Keep app-level look consistent by overriding `FilterBarStyle` rather than forking behavior.

---

## Accessibility

- Search input uses a dedicated label for semantic clarity.
- Clear-all action is disabled when no filters are active.
- Chips expose delete actions with semantic tooltips.

---

## Do / Don’t

**Do**
- ✅ Keep chip keys stable and namespaced (`status:`, `tag:`, `assignee:`).
- ✅ Drive queries from `onStateChanged` in page state.

**Don’t**
- ❌ Fetch data directly inside `FilterBar`.
- ❌ Mutate chip labels/keys in place without emitting a new `FilterState`.

---

## Related components

- `table`
- `chip_input`
- `date_picker`

---

## Registry rules

- One public class in `filter_bar.dart`
- Helpers under `_impl/`
