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
    label: 'Category',
    matcher: FilterMatchers.exact(),
  );
  static final _brandField = FilterField<Set<String>>(
    id: 'brands',
    label: 'Brand',
    matcher: FilterMatchers.inSet<String>(),
  );
  static final _saleField = FilterField<bool>(
    id: 'sale_only',
    label: 'Sale',
    matcher: FilterMatchers.exact<bool>(),
  );
  static final _priceBucketField = FilterField<String>(
    id: 'price_bucket',
    label: 'Price',
    matcher: FilterMatchers.exact<String>(),
  );
  static final _retailerField = FilterField<Set<String>>(
    id: 'retailer',
    label: 'Retailer',
    matcher: FilterMatchers.inSet<String>(),
  );
  static final _brandQueryField = FilterField<String>(
    id: 'brand_query',
    label: 'Brand query',
    defaultMatcherId: 'contains',
    matchers: [
      FilterMatcherOption<String>(
        id: 'contains',
        label: 'Contains',
        matcher: FilterMatchers.contains(),
      ),
      FilterMatcherOption<String>(
        id: 'starts_with',
        label: 'Starts with',
        matcher: FilterMatchers.startsWith(),
      ),
      FilterMatcherOption<String>(
        id: 'like',
        label: 'Like',
        matcher: FilterMatchers.like(),
      ),
      FilterMatcherOption<String>(
        id: 'consonant',
        label: 'Custom consonant',
        matcher: FilterMatcher<String>((selected, candidate) {
          if (candidate is! String) {
            return false;
          }
          final query = _stripVowels(selected);
          final value = _stripVowels(candidate);
          if (query.isEmpty) {
            return true;
          }
          return value.contains(query);
        }),
      ),
    ],
  );

  final List<_PreviewProduct> _products = List.generate(32, (index) {
    const brands = [
      'Apple',
      'EKWB',
      'SuperMicro',
      'Netgear',
      'Crucial',
      'TP-Link',
      'Thermaltake',
      'HPE',
    ];
    const retailers = ['direct', 'marketplace', 'reseller'];
    const categories = ['electronics', 'office', 'networking'];
    final brand = brands[index % brands.length];
    return _PreviewProduct(
      name: 'Item ${1000 + index}',
      brand: brand,
      category: categories[index % categories.length],
      retailer: retailers[index % retailers.length],
      onSale: index % 3 == 0,
      price: 90 + ((index * 37) % 880),
      stock: 420 + ((index * 23) % 120),
    );
  });

  FilterState _state = const FilterState(
    sortId: 'newest',
    customFilters: {
      'category': 'electronics',
      'sale_only': false,
      'price_bucket': 'all',
      'brand_query': '',
    },
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final visibleProducts = _filteredProducts();

    return shadcn_scaffold.Scaffold(
      headers: const [shadcn_scaffold.AppBar(title: Text('FilterBar Preview'))],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16 * scaling),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterBar(
              state: _state,
              sortOptions: _sortOptions,
              resultsCount: visibleProducts.length,
              searchDebounce: const Duration(milliseconds: 200),
              mobileVariant: FilterBarMobileVariant.autoSheet,
              mobileBreakpoint: 980,
              mobileSheetTitle: 'Filter',
              mobileFiltersLabel: 'Filter',
              customFilters: [
                _buildCategoryFilter(),
                _buildBrandPickerFilter(),
                _buildSaleFilter(),
                _buildPriceBucketFilter(),
                _buildRetailerFilter(),
                _buildMatcherDemoFilter(),
              ],
              trailingFilters: [
                PrimaryButton(
                  onPressed: () {},
                  child: Text('Show ${visibleProducts.length}'),
                ),
              ],
              onStateChanged: (next) {
                setState(() {
                  _state = next;
                });
              },
            ),
            SizedBox(height: 16 * scaling),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.border),
                borderRadius: theme.borderRadiusMd,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < visibleProducts.length; i++)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12 * scaling,
                        vertical: 10 * scaling,
                      ),
                      decoration: i == visibleProducts.length - 1
                          ? null
                          : BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.colorScheme.border,
                                ),
                              ),
                            ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${visibleProducts[i].brand} • ${visibleProducts[i].name}',
                            ),
                          ),
                          Text(
                            '\$${visibleProducts[i].price.toStringAsFixed(0)} • ${_titleCase(visibleProducts[i].retailer)}',
                            style: theme.typography.textMuted,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_PreviewProduct> _filteredProducts() {
    final query = _state.search.trim().toLowerCase();
    final saleOnly = _state.valueOf<bool>(_saleField) ?? false;
    final priceBucket = _state.valueOf<String>(_priceBucketField) ?? 'all';

    final results = _products
        .where((product) {
          if (query.isNotEmpty &&
              !product.name.toLowerCase().contains(query) &&
              !product.brand.toLowerCase().contains(query)) {
            return false;
          }
          if (!_state.matchesValue(_categoryField, product.category)) {
            return false;
          }
          if (!_state.matchesValue(_brandField, product.brand)) {
            return false;
          }
          if (!_state.matchesValue(_retailerField, product.retailer)) {
            return false;
          }
          if (!_state.matchesValue(
            _brandQueryField,
            product.brand.toLowerCase(),
          )) {
            return false;
          }
          if (saleOnly && !product.onSale) {
            return false;
          }
          if (!_matchesPriceBucket(priceBucket, product.price)) {
            return false;
          }
          return true;
        })
        .toList(growable: false);

    if (_state.sortId == 'oldest') {
      return results;
    }
    return results.reversed.toList(growable: false);
  }

  FilterCustomFilter _buildCategoryFilter() {
    return FilterCustomFilter.typed<String>(
      field: _categoryField,
      builder: (context, value, onChanged) {
        return _FilterPanelTile(
          title: 'Category',
          trailing: SizedBox(
            width: 170,
            child: Select<String>(
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
            ),
          ),
        );
      },
    );
  }

  FilterCustomFilter _buildBrandPickerFilter() {
    return FilterCustomFilter(
      id: _brandField.id,
      builder: (context, state, onStateChanged) {
        final selectedBrands =
            state.valueOf<Set<String>>(_brandField) ?? <String>{};
        return _FilterPanelTile(
          title: 'Brand',
          subtitle: selectedBrands.isEmpty
              ? 'Any'
              : '${selectedBrands.length} selected',
          onTap: () => _openBrandPickerSheet(
            context,
            state: state,
            onStateChanged: onStateChanged,
          ),
        );
      },
    );
  }

  FilterCustomFilter _buildSaleFilter() {
    return FilterCustomFilter.typed<bool>(
      field: _saleField,
      builder: (context, value, onChanged) {
        final selected = value ?? false;
        return _FilterPanelTile(
          title: 'Sale',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GhostButton(
                size: ButtonSize.small,
                onPressed: () => onChanged(false),
                child: const Text('All'),
              ),
              const SizedBox(width: 6),
              selected
                  ? SecondaryButton(
                      size: ButtonSize.small,
                      onPressed: () => onChanged(true),
                      child: const Text('Sale only'),
                    )
                  : GhostButton(
                      size: ButtonSize.small,
                      onPressed: () => onChanged(true),
                      child: const Text('Sale only'),
                    ),
            ],
          ),
        );
      },
    );
  }

  FilterCustomFilter _buildPriceBucketFilter() {
    return FilterCustomFilter.typed<String>(
      field: _priceBucketField,
      builder: (context, value, onChanged) {
        final selected = value ?? 'all';
        return _FilterPanelTile(
          title: 'Price',
          trailing: Wrap(
            spacing: 6,
            children: [
              _priceButton(
                selected: selected == 'all',
                label: 'All',
                onTap: () => onChanged('all'),
              ),
              _priceButton(
                selected: selected == 'low',
                label: '< 200',
                onTap: () => onChanged('low'),
              ),
              _priceButton(
                selected: selected == 'mid',
                label: '200-600',
                onTap: () => onChanged('mid'),
              ),
              _priceButton(
                selected: selected == 'high',
                label: '> 600',
                onTap: () => onChanged('high'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _priceButton({
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

  FilterCustomFilter _buildRetailerFilter() {
    return FilterCustomFilter.typed<Set<String>>(
      field: _retailerField,
      builder: (context, value, onChanged) {
        final selected = value ?? <String>{};
        return _FilterPanelTile(
          title: 'Retailer',
          trailing: Wrap(
            spacing: 8,
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
          ),
        );
      },
    );
  }

  FilterCustomFilter _buildMatcherDemoFilter() {
    return FilterCustomFilter(
      id: _brandQueryField.id,
      builder: (context, state, onStateChanged) {
        final matcherId =
            state.matcherIdOf(_brandQueryField) ??
            _brandQueryField.defaultMatcherId ??
            _brandQueryField.matchers.first.id;
        final queryValue = state.valueOf<String>(_brandQueryField) ?? '';
        return _FilterPanelTile(
          title: 'Brand matcher',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 180,
                child: Select<String>(
                  value: matcherId,
                  itemBuilder: (context, value) {
                    final item = _brandQueryField.matchers.firstWhere(
                      (m) => m.id == value,
                    );
                    return Text(item.label);
                  },
                  popup: SelectPopup<String>(
                    items: SelectItemList(
                      children: _brandQueryField.matchers
                          .map(
                            (matcherOption) => SelectItemButton<String>(
                              value: matcherOption.id,
                              child: Text(matcherOption.label),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ).call,
                  onChanged: (next) {
                    if (next == null) {
                      return;
                    }
                    onStateChanged(
                      state.setMatcherIdOf(_brandQueryField, next),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 160,
                child: Select<String>(
                  value: queryValue.isEmpty ? null : queryValue,
                  canUnselect: true,
                  placeholder: const Text('Query'),
                  itemBuilder: (context, value) => Text(value),
                  popup: SelectPopup<String>(
                    items: SelectItemList(
                      children: const ['app', 'su', 'net', '%ro%', 'tpl']
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
                    onStateChanged(state.setValue(_brandQueryField, next));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openBrandPickerSheet(
    BuildContext context, {
    required FilterState state,
    required FilterStateChanged onStateChanged,
  }) async {
    await openSheet<void>(
      context: context,
      position: OverlayPosition.right,
      draggable: true,
      builder: (context) {
        return _BrandPickerSheet(
          state: state,
          products: _products,
          field: _brandField,
          onStateChanged: onStateChanged,
        );
      },
    );
  }

  static String _stripVowels(String value) {
    return value.toLowerCase().replaceAll(RegExp('[aeiou]'), '');
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

  bool _matchesPriceBucket(String bucket, double price) {
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
}

class _FilterPanelTile extends StatelessWidget {
  const _FilterPanelTile({
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.medium),
                if (subtitle != null)
                  Text(subtitle!, style: theme.typography.textMuted),
              ],
            ),
          ),
          if (trailing != null) trailing!,
          if (onTap != null)
            GhostButton(
              onPressed: onTap,
              size: ButtonSize.small,
              child: const Icon(LucideIcons.chevronRight),
            ),
        ],
      ),
    );
  }
}

class _BrandPickerSheet extends StatefulWidget {
  const _BrandPickerSheet({
    required this.state,
    required this.products,
    required this.field,
    required this.onStateChanged,
  });

  final FilterState state;
  final List<_PreviewProduct> products;
  final FilterField<Set<String>> field;
  final FilterStateChanged onStateChanged;

  @override
  State<_BrandPickerSheet> createState() => _BrandPickerSheetState();
}

class _BrandPickerSheetState extends State<_BrandPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final selected =
        widget.state.valueOf<Set<String>>(widget.field) ?? <String>{};
    final brandCount = <String, int>{};
    for (final product in widget.products) {
      brandCount.update(product.brand, (value) => value + 1, ifAbsent: () => 1);
    }
    final brands =
        brandCount.keys
            .where(
              (brand) => brand.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList(growable: false)
          ..sort();

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.all(12 * scaling),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.card,
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(16 * scaling),
          ),
          padding: EdgeInsets.all(14 * scaling),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Brand', style: theme.typography.large)),
                  GhostButton(
                    size: ButtonSize.small,
                    onPressed: () => closeSheet(context),
                    child: const Icon(LucideIcons.x),
                  ),
                ],
              ),
              SizedBox(height: 8 * scaling),
              SizedBox(
                width: double.infinity,
                child: Select<String>(
                  value: _query.isEmpty ? null : _query,
                  canUnselect: true,
                  placeholder: const Text('Search brand'),
                  itemBuilder: (context, value) => Text(value),
                  popup: SelectPopup<String>(
                    items: SelectItemList(
                      children: brandCount.keys
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
              ),
              SizedBox(height: 8 * scaling),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: brands
                        .map((brand) {
                          final checked = selected.contains(brand);
                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6 * scaling,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: theme.colorScheme.border,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '$brand (${brandCount[brand]})',
                                    style: theme.typography.medium,
                                  ),
                                ),
                                Checkbox(
                                  state: checked
                                      ? CheckboxState.checked
                                      : CheckboxState.unchecked,
                                  onChanged: (next) {
                                    final copy = <String>{...selected};
                                    if (next == CheckboxState.checked) {
                                      copy.add(brand);
                                    } else {
                                      copy.remove(brand);
                                    }
                                    widget.onStateChanged(
                                      widget.state.setValue(
                                        widget.field,
                                        copy.isEmpty ? null : copy,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        })
                        .toList(growable: false),
                  ),
                ),
              ),
              SizedBox(height: 10 * scaling),
              Row(
                children: [
                  Expanded(
                    child: GhostButton(
                      onPressed: () {
                        widget.onStateChanged(
                          widget.state.setValue(widget.field, null),
                        );
                      },
                      child: const Text('Clear filter'),
                    ),
                  ),
                  SizedBox(width: 8 * scaling),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () => closeSheet(context),
                      child: Text(
                        'Show ${selected.isEmpty ? widget.products.length : widget.products.where((p) => selected.contains(p.brand)).length}',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewProduct {
  const _PreviewProduct({
    required this.name,
    required this.brand,
    required this.category,
    required this.retailer,
    required this.onSale,
    required this.price,
    required this.stock,
  });

  final String name;
  final String brand;
  final String category;
  final String retailer;
  final bool onSale;
  final double price;
  final int stock;
}
