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

### Pattern: Typed custom filters with matchers

```dart
final statusField = FilterField<String>(
  id: 'status',
  matcher: FilterMatchers.exact(),
);

FilterBar(
  state: state,
  customFilters: [
    FilterCustomFilter.typed<String>(
      field: statusField,
      builder: (context, value, onChanged) {
        return Select<String>(
          value: value,
          canUnselect: true,
          placeholder: const Text('Status'),
          onChanged: onChanged,
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

### Pattern: Multiple and custom matcher modes

```dart
final brandField = FilterField<String>(
  id: 'brand_query',
  defaultMatcherId: 'contains',
  matchers: [
    FilterMatcherOption(
      id: 'contains',
      label: 'Contains',
      matcher: FilterMatchers.contains(),
    ),
    FilterMatcherOption(
      id: 'starts_with',
      label: 'Starts with',
      matcher: FilterMatchers.startsWith(),
    ),
    FilterMatcherOption(
      id: 'custom',
      label: 'Custom',
      matcher: FilterMatcher<String>((selected, candidate) {
        return candidate is String && candidate.endsWith(selected);
      }),
    ),
  ],
);

final next = state
    .setValue(brandField, 'app')
    .setMatcherIdOf(brandField, 'starts_with');
```

### Pattern: Mobile sheet variant

```dart
FilterBar(
  state: state,
  mobileVariant: FilterBarMobileVariant.autoSheet,
  mobileBreakpoint: 720,
  mobileSheetTitle: 'Filters',
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
- `mobileVariant` (`FilterBarMobileVariant`, optional, default: `autoSheet`)
- `mobileBreakpoint` (`double`, optional, default: `720`)
- `mobileFiltersLabel` (`String`, optional)
- `mobileSheetTitle` (`String`, optional)
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
