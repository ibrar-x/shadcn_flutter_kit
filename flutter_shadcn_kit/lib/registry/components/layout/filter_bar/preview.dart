import 'package:flutter/widgets.dart';

import '../../control/button/button.dart';
import '../../form/checkbox/checkbox.dart';
import '../../form/select/select.dart';
import '../../overlay/drawer/drawer.dart';
import '../scaffold/scaffold.dart' as shadcn_scaffold;
import 'filter_bar.dart';
import '../../../shared/icons/lucide_icons.dart';
import '../../../shared/theme/theme.dart';

/// FilterBarPreview defines a reusable type for this registry module.
class FilterBarPreview extends StatefulWidget {
  const FilterBarPreview({super.key});

  @override
  State<FilterBarPreview> createState() => _FilterBarPreviewState();
}

enum _PreviewDesktopPlacement { inline, sidebarLeft, sidebarRight }

/// _FilterBarPreviewState defines a reusable type for this registry module.
class _FilterBarPreviewState extends State<FilterBarPreview> {
  static const _sortOptions = [
    FilterSortOption(id: 'newest', label: 'Newest'),
    FilterSortOption(id: 'oldest', label: 'Oldest'),
  ];

  static const _categories = ['electronics', 'office', 'networking'];
  static const _retailers = ['direct', 'marketplace', 'reseller'];

  static final _categoryField = FilterField<String>(
    id: 'category',
    matcher: FilterMatchers.exact(),
  );
  static final _brandField = FilterField<Set<String>>(
    id: 'brand',
    matcher: FilterMatchers.inSet<String>(),
  );
  static final _saleField = FilterField<bool>(
    id: 'sale',
    matcher: FilterMatchers.exact<bool>(),
  );
  static final _priceField = FilterField<String>(
    id: 'price',
    matcher: FilterMatchers.exact<String>(),
  );
  static final _retailerField = FilterField<Set<String>>(
    id: 'retailer',
    matcher: FilterMatchers.inSet<String>(),
  );
  static final _brandMatcherField = FilterField<String>(
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
        id: 'like',
        label: 'Like',
        matcher: FilterMatchers.like(),
      ),
      FilterMatcherOption(
        id: 'custom',
        label: 'Custom (consonants)',
        matcher: FilterMatcher<String>((selected, candidate) {
          if (candidate is! String) {
            return false;
          }
          final lhs = _stripVowels(candidate.toLowerCase());
          final rhs = _stripVowels(selected.toLowerCase());
          if (rhs.isEmpty) {
            return true;
          }
          return lhs.contains(rhs);
        }),
      ),
    ],
  );

  final _controller = FilterBarController(
    const FilterState(
      sortId: 'newest',
      customFilters: {
        'category': 'electronics',
        'price': 'all',
        'sale': false,
        'brand_query': '',
      },
    ),
  );

  final List<_PreviewProduct> _products = List.generate(40, (index) {
    const brands = [
      'Apple',
      'EKWB',
      'SuperMicro',
      'Crucial',
      'TP-Link',
      'HPE',
      'Netgear',
      'Thermaltake',
    ];
    final brand = brands[index % brands.length];
    return _PreviewProduct(
      id: '${1000 + index}',
      brand: brand,
      category: _categories[index % _categories.length],
      retailer: _retailers[index % _retailers.length],
      onSale: index % 3 == 0,
      price: 80 + ((index * 35) % 880),
      stock: 420 + ((index * 21) % 150),
    );
  });

  _PreviewDesktopPlacement _desktopPlacement = _PreviewDesktopPlacement.inline;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final isMobile = MediaQuery.sizeOf(context).width <= 980;

    return shadcn_scaffold.Scaffold(
      headers: const [shadcn_scaffold.AppBar(title: Text('FilterBar Preview'))],
      child: ValueListenableBuilder<FilterState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          final results = _filteredProducts(state);
          final filterBar = FilterBar(
            controller: _controller,
            sortOptions: _sortOptions,
            enableDateRange: true,
            searchDebounce: const Duration(milliseconds: 200),
            resultsCount: results.length,
            mobileVariant: FilterBarMobileVariant.autoSheet,
            mobileBreakpoint: 980,
            mobileSheetTitle: 'Filter',
            mobileFiltersLabel: 'Filter',
            customFilters: [
              _buildCategoryFilter(),
              _buildBrandFilter(),
              _buildSaleFilter(),
              _buildPriceFilter(),
              _buildRetailerFilter(),
              _buildMatcherFilter(),
            ],
            mobileGroups: const [
              FilterMobileGroup(
                id: 'catalog',
                title: 'Catalog',
                filterIds: ['category', 'brand', 'sale'],
              ),
              FilterMobileGroup(
                id: 'price_and_rating',
                title: 'Pricing',
                filterIds: ['price'],
              ),
              FilterMobileGroup(
                id: 'source',
                title: 'Source',
                filterIds: ['retailer', 'brand_query'],
              ),
            ],
            trailingFilters: [
              PrimaryButton(
                onPressed: () {},
                child: Text('Show ${results.length}'),
              ),
            ],
            onStateChanged: (_) {},
          );

          Widget content;
          if (isMobile ||
              _desktopPlacement == _PreviewDesktopPlacement.inline) {
            content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                filterBar,
                SizedBox(height: 12 * scaling),
                _buildPlacementControl(isMobile: isMobile),
                SizedBox(height: 12 * scaling),
                _buildResultList(results),
              ],
            );
          } else {
            final sidebar = SizedBox(width: 400 * scaling, child: filterBar);
            final list = Expanded(child: _buildResultList(results));
            content = Column(
              children: [
                _buildPlacementControl(isMobile: isMobile),
                SizedBox(height: 12 * scaling),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      _desktopPlacement == _PreviewDesktopPlacement.sidebarLeft
                      ? [sidebar, SizedBox(width: 12 * scaling), list]
                      : [list, SizedBox(width: 12 * scaling), sidebar],
                ),
              ],
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16 * scaling),
            child: content,
          );
        },
      ),
    );
  }

  Widget _buildPlacementControl({required bool isMobile}) {
    if (isMobile) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Text('Desktop placement', style: Theme.of(context).typography.small),
        const SizedBox(width: 8),
        _placementButton(
          label: 'Inline',
          selected: _desktopPlacement == _PreviewDesktopPlacement.inline,
          onTap: () => setState(() {
            _desktopPlacement = _PreviewDesktopPlacement.inline;
          }),
        ),
        const SizedBox(width: 6),
        _placementButton(
          label: 'Sidebar Left',
          selected: _desktopPlacement == _PreviewDesktopPlacement.sidebarLeft,
          onTap: () => setState(() {
            _desktopPlacement = _PreviewDesktopPlacement.sidebarLeft;
          }),
        ),
        const SizedBox(width: 6),
        _placementButton(
          label: 'Sidebar Right',
          selected: _desktopPlacement == _PreviewDesktopPlacement.sidebarRight,
          onTap: () => setState(() {
            _desktopPlacement = _PreviewDesktopPlacement.sidebarRight;
          }),
        ),
      ],
    );
  }

  Widget _placementButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    if (selected) {
      return SecondaryButton(
        size: ButtonSize.small,
        onPressed: onTap,
        child: Text(label),
      );
    }
    return GhostButton(
      size: ButtonSize.small,
      onPressed: onTap,
      child: Text(label),
    );
  }

  Widget _buildResultList(List<_PreviewProduct> products) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Column(
        children: [
          for (var i = 0; i < products.length; i++)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12 * scaling,
                vertical: 10 * scaling,
              ),
              decoration: i == products.length - 1
                  ? null
                  : BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: theme.colorScheme.border),
                      ),
                    ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${products[i].brand} • Item ${products[i].id}',
                    ),
                  ),
                  Text(
                    '\$${products[i].price.toStringAsFixed(0)} • ${_titleCase(products[i].retailer)}',
                    style: theme.typography.textMuted,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<_PreviewProduct> _filteredProducts(FilterState state) {
    final query = state.search.trim().toLowerCase();
    final saleOnly = state.valueOf<bool>(_saleField) ?? false;
    final price = state.valueOf<String>(_priceField) ?? 'all';

    final filtered = _products
        .where((item) {
          if (query.isNotEmpty &&
              !item.brand.toLowerCase().contains(query) &&
              !item.id.toLowerCase().contains(query)) {
            return false;
          }
          if (!state.matchesValue(_categoryField, item.category)) {
            return false;
          }
          if (!state.matchesValue(_brandField, item.brand)) {
            return false;
          }
          if (!state.matchesValue(_retailerField, item.retailer)) {
            return false;
          }
          if (!state.matchesValue(
            _brandMatcherField,
            item.brand.toLowerCase(),
          )) {
            return false;
          }
          if (saleOnly && !item.onSale) {
            return false;
          }
          if (!_matchesPrice(price, item.price)) {
            return false;
          }
          return true;
        })
        .toList(growable: false);

    if (state.sortId == 'oldest') {
      return filtered;
    }
    return filtered.reversed.toList(growable: false);
  }

  FilterCustomFilter _buildCategoryFilter() {
    return FilterCustomFilter.typed<String>(
      field: _categoryField,
      builder: (context, value, onChanged) {
        final isMobile = MediaQuery.sizeOf(context).width <= 980;
        if (isMobile) {
          return _mobileTile(
            title: 'Category',
            trailing: SizedBox(
              width: 150,
              child: _categorySelect(value: value, onChanged: onChanged),
            ),
          );
        }
        return SizedBox(
          width: 220,
          child: _categorySelect(value: value, onChanged: onChanged),
        );
      },
    );
  }

  Widget _categorySelect({
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Select<String>(
      value: value,
      canUnselect: true,
      placeholder: const Text('All'),
      itemBuilder: (context, value) => Text(_titleCase(value)),
      popup: SelectPopup<String>(
        items: SelectItemList(
          children: _categories
              .map(
                (category) => SelectItemButton<String>(
                  value: category,
                  child: Text(_titleCase(category)),
                ),
              )
              .toList(growable: false),
        ),
      ).call,
      onChanged: onChanged,
    );
  }

  FilterCustomFilter _buildBrandFilter() {
    return FilterCustomFilter(
      id: _brandField.id,
      builder: (context, state, onStateChanged) {
        final selected = state.valueOf<Set<String>>(_brandField) ?? <String>{};
        final isMobile = MediaQuery.sizeOf(context).width <= 980;
        final trigger = GhostButton(
          size: ButtonSize.small,
          onPressed: () => _openBrandSheet(
            context,
            state: state,
            onStateChanged: onStateChanged,
            itemBuilder: (context, brand, count, checked, toggle) {
              return Row(
                children: [
                  Expanded(child: Text('$brand ($count)')),
                  Checkbox(
                    state: checked
                        ? CheckboxState.checked
                        : CheckboxState.unchecked,
                    onChanged: (_) => toggle(),
                  ),
                ],
              );
            },
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selected.isEmpty ? 'Any' : '${selected.length} selected'),
              const SizedBox(width: 4),
              const Icon(LucideIcons.chevronRight),
            ],
          ),
        );

        if (isMobile) {
          return _mobileTile(title: 'Brand', trailing: trigger);
        }
        return trigger;
      },
    );
  }

  FilterCustomFilter _buildSaleFilter() {
    return FilterCustomFilter.typed<bool>(
      field: _saleField,
      builder: (context, value, onChanged) {
        final selected = value ?? false;
        final row = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _pill(
              selected: !selected,
              label: 'All',
              onTap: () => onChanged(false),
            ),
            const SizedBox(width: 6),
            _pill(
              selected: selected,
              label: 'Sale only',
              onTap: () => onChanged(true),
            ),
          ],
        );

        if (MediaQuery.sizeOf(context).width <= 980) {
          return _mobileTile(title: 'Sale', trailing: row);
        }
        return row;
      },
    );
  }

  FilterCustomFilter _buildPriceFilter() {
    return FilterCustomFilter.typed<String>(
      field: _priceField,
      builder: (context, value, onChanged) {
        final selected = value ?? 'all';
        final wrap = Wrap(
          spacing: 6,
          children: [
            _pill(
              selected: selected == 'all',
              label: 'All',
              onTap: () => onChanged('all'),
            ),
            _pill(
              selected: selected == 'low',
              label: '< 200',
              onTap: () => onChanged('low'),
            ),
            _pill(
              selected: selected == 'mid',
              label: '200-600',
              onTap: () => onChanged('mid'),
            ),
            _pill(
              selected: selected == 'high',
              label: '> 600',
              onTap: () => onChanged('high'),
            ),
          ],
        );

        if (MediaQuery.sizeOf(context).width <= 980) {
          return _mobileTile(title: 'Price', trailing: wrap);
        }
        return wrap;
      },
    );
  }

  FilterCustomFilter _buildRetailerFilter() {
    return FilterCustomFilter.typed<Set<String>>(
      field: _retailerField,
      builder: (context, value, onChanged) {
        final selected = value ?? <String>{};
        final body = Wrap(
          spacing: 10,
          children: _retailers
              .map((retailer) {
                final checked = selected.contains(retailer);
                return Checkbox(
                  state: checked
                      ? CheckboxState.checked
                      : CheckboxState.unchecked,
                  onChanged: (next) {
                    final copy = <String>{...selected};
                    if (next == CheckboxState.checked) {
                      copy.add(retailer);
                    } else {
                      copy.remove(retailer);
                    }
                    onChanged(copy.isEmpty ? null : copy);
                  },
                  trailing: Text(_titleCase(retailer)),
                );
              })
              .toList(growable: false),
        );

        if (MediaQuery.sizeOf(context).width <= 980) {
          return _mobileTile(title: 'Retailer', trailing: body);
        }
        return body;
      },
    );
  }

  FilterCustomFilter _buildMatcherFilter() {
    return FilterCustomFilter(
      id: _brandMatcherField.id,
      builder: (context, state, onStateChanged) {
        final query = state.valueOf<String>(_brandMatcherField) ?? '';
        final matcherId = state.matcherIdOf(_brandMatcherField) ?? 'contains';
        final matcherSelect = SizedBox(
          width: 180,
          child: Select<String>(
            value: matcherId,
            itemBuilder: (context, value) {
              final item = _brandMatcherField.matchers.firstWhere(
                (m) => m.id == value,
              );
              return Text(item.label);
            },
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: _brandMatcherField.matchers
                    .map(
                      (item) => SelectItemButton<String>(
                        value: item.id,
                        child: Text(item.label),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              if (next == null) return;
              onStateChanged(state.setMatcherIdOf(_brandMatcherField, next));
            },
          ),
        );

        final querySelect = SizedBox(
          width: 150,
          child: Select<String>(
            value: query.isEmpty ? null : query,
            canUnselect: true,
            placeholder: const Text('Query'),
            itemBuilder: (context, value) => Text(value),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: const ['app', 'net', 'tp', '%ro%', 'sm']
                    .map(
                      (value) => SelectItemButton<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              onStateChanged(state.setValue(_brandMatcherField, next));
            },
          ),
        );

        final row = Row(
          mainAxisSize: MainAxisSize.min,
          children: [matcherSelect, const SizedBox(width: 8), querySelect],
        );
        if (MediaQuery.sizeOf(context).width <= 980) {
          return _mobileTile(title: 'Brand matcher', trailing: row);
        }
        return row;
      },
    );
  }

  Widget _pill({
    required bool selected,
    required String label,
    required VoidCallback onTap,
  }) {
    if (selected) {
      return SecondaryButton(
        size: ButtonSize.small,
        onPressed: onTap,
        child: Text(label),
      );
    }
    return GhostButton(
      size: ButtonSize.small,
      onPressed: onTap,
      child: Text(label),
    );
  }

  Widget _mobileTile({required String title, required Widget trailing}) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Container(
      margin: EdgeInsets.only(bottom: 8 * scaling),
      padding: EdgeInsets.symmetric(
        horizontal: 12 * scaling,
        vertical: 10 * scaling,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Row(
        children: [
          Expanded(child: Text(title, style: theme.typography.medium)),
          trailing,
        ],
      ),
    );
  }

  Future<void> _openBrandSheet(
    BuildContext context, {
    required FilterState state,
    required FilterStateChanged onStateChanged,
    required _BrandItemBuilder itemBuilder,
  }) async {
    await openSheet<void>(
      context: context,
      position: OverlayPosition.bottom,
      draggable: true,
      builder: (context) => _BrandPickerSheet(
        products: _products,
        field: _brandField,
        initialState: state,
        onStateChanged: onStateChanged,
        itemBuilder: itemBuilder,
      ),
    );
  }

  static bool _matchesPrice(String bucket, double price) {
    switch (bucket) {
      case 'low':
        return price < 200;
      case 'mid':
        return price >= 200 && price <= 600;
      case 'high':
        return price > 600;
      case 'all':
      default:
        return true;
    }
  }

  static String _titleCase(String value) {
    return value
        .split('_')
        .map(
          (part) =>
              part.isEmpty ? part : part[0].toUpperCase() + part.substring(1),
        )
        .join(' ');
  }

  static String _stripVowels(String value) {
    return value.replaceAll(RegExp('[aeiou]'), '');
  }
}

typedef _BrandItemBuilder =
    Widget Function(
      BuildContext context,
      String brand,
      int count,
      bool checked,
      VoidCallback toggle,
    );

class _BrandPickerSheet extends StatefulWidget {
  const _BrandPickerSheet({
    required this.products,
    required this.field,
    required this.initialState,
    required this.onStateChanged,
    required this.itemBuilder,
  });

  final List<_PreviewProduct> products;
  final FilterField<Set<String>> field;
  final FilterState initialState;
  final FilterStateChanged onStateChanged;
  final _BrandItemBuilder itemBuilder;

  @override
  State<_BrandPickerSheet> createState() => _BrandPickerSheetState();
}

class _BrandPickerSheetState extends State<_BrandPickerSheet> {
  late FilterState _state;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _state = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _state.valueOf<Set<String>>(widget.field) ?? <String>{};
    final counts = <String, int>{};
    for (final item in widget.products) {
      counts.update(item.brand, (value) => value + 1, ifAbsent: () => 1);
    }

    final brands =
        counts.keys
            .where(
              (brand) => brand.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList(growable: false)
          ..sort();

    final filteredCount = selected.isEmpty
        ? widget.products.length
        : widget.products.where((item) => selected.contains(item.brand)).length;

    return FilterBarSheetScaffold(
      title: 'Brand',
      maxHeight: 720,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Select<String>(
            value: _query.isEmpty ? null : _query,
            canUnselect: true,
            placeholder: const Text('Search brand'),
            itemBuilder: (context, value) => Text(value),
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: counts.keys
                    .map(
                      (brand) => SelectItemButton<String>(
                        value: brand,
                        child: Text(brand),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              setState(() {
                _query = next ?? '';
              });
            },
          ),
          const SizedBox(height: 10),
          ...brands.map((brand) {
            final checked = selected.contains(brand);
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.border,
                  ),
                ),
              ),
              child: widget.itemBuilder(
                context,
                brand,
                counts[brand]!,
                checked,
                () {
                  final copy = <String>{...selected};
                  if (checked) {
                    copy.remove(brand);
                  } else {
                    copy.add(brand);
                  }
                  final next = _state.setValue(
                    widget.field,
                    copy.isEmpty ? null : copy,
                  );
                  setState(() {
                    _state = next;
                  });
                  widget.onStateChanged(next);
                },
              ),
            );
          }),
        ],
      ),
      footer: Row(
        children: [
          Expanded(
            child: GhostButton(
              onPressed: () {
                final next = _state.setValue(widget.field, null);
                setState(() {
                  _state = next;
                });
                widget.onStateChanged(next);
              },
              child: const Text('Clear filter'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: PrimaryButton(
              onPressed: () => closeSheet(context),
              child: Text('Show $filteredCount'),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewProduct {
  const _PreviewProduct({
    required this.id,
    required this.brand,
    required this.category,
    required this.retailer,
    required this.onSale,
    required this.price,
    required this.stock,
  });

  final String id;
  final String brand;
  final String category;
  final String retailer;
  final bool onSale;
  final double price;
  final int stock;
}
