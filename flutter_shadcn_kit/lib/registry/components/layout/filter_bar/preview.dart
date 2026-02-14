import 'package:flutter/widgets.dart';

import '../../control/button/button.dart';
import '../../form/checkbox/checkbox.dart';
import '../../form/select/select.dart';
import '../../form/text_field/text_field.dart';
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

class _FilterBarPreviewState extends State<FilterBarPreview> {
  final _controller = FilterBarController(
    FilterState(
      chips: const [
        FilterChipData(key: 'rule:1', label: 'Order # is greater than 1000'),
        FilterChipData(key: 'rule:2', label: 'Email contains gmail'),
        FilterChipData(
          key: 'rule:3',
          label: 'Revenue is between \$9 and \$199',
        ),
        FilterChipData(key: 'rule:4', label: 'Purchased is Splashify 2.0'),
        FilterChipData(key: 'rule:5', label: 'Status is Paid'),
      ],
      customFilters: {
        'rules': [
          _FilterRule(
            id: 1,
            field: _FilterFieldId.orderNumber,
            operatorId: 'gt',
            value: '1000',
          ),
          _FilterRule(
            id: 2,
            field: _FilterFieldId.email,
            operatorId: 'contains',
            value: 'gmail',
          ),
          _FilterRule(
            id: 3,
            field: _FilterFieldId.revenue,
            operatorId: 'between',
            value: '9',
            secondaryValue: '199',
          ),
          _FilterRule(
            id: 4,
            field: _FilterFieldId.purchased,
            operatorId: 'is',
            value: 'Splashify 2.0',
          ),
          _FilterRule(
            id: 5,
            field: _FilterFieldId.status,
            operatorId: 'is',
            value: 'Paid',
          ),
        ],
      },
    ),
  );

  int _nextRuleId = 6;

  final List<_OrderRecord> _orders = const [
    _OrderRecord(
      orderNo: 1019,
      date: '1 Oct, 11:00',
      customer: 'Samantha',
      email: 'samantha@gmail.com',
      purchased: 'Splashify 2.0',
      revenue: 49,
      status: 'Paid',
    ),
    _OrderRecord(
      orderNo: 1018,
      date: '30 Sep, 09:20',
      customer: 'Jason Schuller',
      email: 'jason@outlook.com',
      purchased: 'Splashify 2.0',
      revenue: 49,
      status: 'Paid',
    ),
    _OrderRecord(
      orderNo: 1016,
      date: '29 Sep, 04:20',
      customer: 'Maria Chen',
      email: 'maria@company.io',
      purchased: 'Flowboard Pro',
      revenue: 129,
      status: 'Pending',
    ),
    _OrderRecord(
      orderNo: 1015,
      date: '28 Sep, 07:11',
      customer: 'Alex Park',
      email: 'alex@gmail.com',
      purchased: 'Splashify 2.0',
      revenue: 169,
      status: 'Paid',
    ),
    _OrderRecord(
      orderNo: 1014,
      date: '27 Sep, 16:30',
      customer: 'Nina Roy',
      email: 'nina@startup.dev',
      purchased: 'Flowboard Pro',
      revenue: 320,
      status: 'Refunded',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return shadcn_scaffold.Scaffold(
      headers: const [shadcn_scaffold.AppBar(title: Text('FilterBar Preview'))],
      child: ValueListenableBuilder<FilterState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          final filtered = _filterOrders(state);
          final activeRules = _rulesFromState(state);
          return SingleChildScrollView(
            padding: EdgeInsets.all(16 * scaling),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterBar(
                  controller: _controller,
                  searchPlaceholder: 'Search by order #, name or email...',
                  searchDebounce: const Duration(milliseconds: 150),
                  resultsCount: filtered.length,
                  presentation: FilterBarPresentation.autoSheet,
                  sheetBreakpoint: 980,
                  sheetTitle: 'Filters',
                  sheetTriggerLabel: 'Filters',
                  groups: const [FilterGroup(id: 'rules', title: 'Rules')],
                  trailingFilters: [
                    GhostButton(
                      size: ButtonSize.small,
                      onPressed: _openAddFilterComposer,
                      child: const Icon(LucideIcons.plus),
                    ),
                    if (activeRules.isNotEmpty)
                      SecondaryButton(
                        size: ButtonSize.small,
                        onPressed: _openManageFiltersSheet,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Filters'),
                            SizedBox(width: 6),
                            Icon(LucideIcons.chevronUp),
                          ],
                        ),
                      ),
                    GhostButton(
                      size: ButtonSize.small,
                      onPressed: () {},
                      child: const Icon(LucideIcons.ellipsis),
                    ),
                  ],
                  onStateChanged: _handleFilterStateChanged,
                ),
                SizedBox(height: 12 * scaling),
                _buildTable(filtered),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTable(List<_OrderRecord> rows) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    Widget headerCell(String text, {double? width, bool expanded = false}) {
      final child = Text(text, style: theme.typography.small);
      if (expanded) {
        return Expanded(child: child);
      }
      return SizedBox(width: width, child: child);
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12 * scaling,
              vertical: 10 * scaling,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.muted,
              border: Border(
                bottom: BorderSide(color: theme.colorScheme.border),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 32,
                  child: Checkbox(
                    state: CheckboxState.unchecked,
                    onChanged: null,
                  ),
                ),
                SizedBox(width: 10 * scaling),
                headerCell('#', width: 72),
                headerCell('Date', width: 130),
                headerCell('Customer', expanded: true),
                headerCell('Purchased', width: 170),
                headerCell('Revenue', width: 110),
                const SizedBox(width: 30),
              ],
            ),
          ),
          ...rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12 * scaling,
                vertical: 10 * scaling,
              ),
              decoration: index == rows.length - 1
                  ? null
                  : BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: theme.colorScheme.border),
                      ),
                    ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 32,
                    child: Checkbox(
                      state: CheckboxState.unchecked,
                      onChanged: null,
                    ),
                  ),
                  SizedBox(width: 10 * scaling),
                  SizedBox(width: 72, child: Text('#${row.orderNo}')),
                  SizedBox(width: 130, child: Text(row.date)),
                  Expanded(child: Text('${row.customer} • ${row.status}')),
                  SizedBox(width: 170, child: Text(row.purchased)),
                  SizedBox(
                    width: 110,
                    child: Text('\$${row.revenue.toStringAsFixed(2)}'),
                  ),
                  SizedBox(
                    width: 30,
                    child: GhostButton(
                      size: ButtonSize.small,
                      onPressed: () {},
                      child: const Icon(LucideIcons.ellipsis),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _openAddFilterComposer() async {
    final state = _controller.value;
    await openSheet<void>(
      context: context,
      position: OverlayPosition.bottom,
      draggable: true,
      builder: (context) {
        return _RuleComposerSheet(
          title: 'Add filter',
          onApply: (rulesToAdd) {
            final rules = _rulesFromState(state);
            final nextRules = <_FilterRule>[
              ...rules,
              ...rulesToAdd.map((rule) => rule.copyWith(id: _nextRuleId++)),
            ];
            _controller.setState(_withRules(state, nextRules));
            closeSheet(context);
          },
        );
      },
    );
  }

  Future<void> _openManageFiltersSheet() async {
    await openSheet<void>(
      context: context,
      position: OverlayPosition.bottom,
      draggable: true,
      builder: (context) {
        return ValueListenableBuilder<FilterState>(
          valueListenable: _controller,
          builder: (context, state, _) {
            final rules = _rulesFromState(state);
            return FilterBarSheetScaffold(
              title: 'Filters',
              maxHeight: 680,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final rule in rules)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.border,
                        ),
                        borderRadius: Theme.of(context).borderRadiusMd,
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(_chipLabel(rule))),
                          GhostButton(
                            size: ButtonSize.small,
                            onPressed: () {
                              final nextRules = rules
                                  .where((item) => item.id != rule.id)
                                  .toList(growable: false);
                              _controller.setState(
                                _withRules(state, nextRules),
                              );
                            },
                            child: const Icon(LucideIcons.x),
                          ),
                        ],
                      ),
                    ),
                  SecondaryButton(
                    onPressed: () {
                      closeSheet(context);
                      _openAddFilterComposer();
                    },
                    child: const Text('Add filter'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _handleFilterStateChanged(FilterState next) {
    final rules = _rulesFromState(next);
    final visibleRuleIds = next.chips
        .where((chip) => chip.key.startsWith('rule:'))
        .map((chip) => _ruleIdFromChipKey(chip.key))
        .whereType<int>()
        .toSet();
    final normalizedRules = rules
        .where((rule) => visibleRuleIds.contains(rule.id))
        .toList(growable: false);

    if (normalizedRules.length != rules.length) {
      _controller.setState(_withRules(next, normalizedRules));
      return;
    }
    _controller.setState(next);
  }

  List<_OrderRecord> _filterOrders(FilterState state) {
    final query = state.search.trim().toLowerCase();
    final rules = _rulesFromState(state);

    return _orders
        .where((order) {
          if (query.isNotEmpty) {
            final haystack = '${order.orderNo} ${order.customer} ${order.email}'
                .toLowerCase();
            if (!haystack.contains(query)) {
              return false;
            }
          }
          for (final rule in rules) {
            if (!_matchesRule(order, rule)) {
              return false;
            }
          }
          return true;
        })
        .toList(growable: false);
  }

  bool _matchesRule(_OrderRecord order, _FilterRule rule) {
    switch (rule.field) {
      case _FilterFieldId.orderNumber:
        final value = int.tryParse(rule.value) ?? 0;
        switch (rule.operatorId) {
          case 'gt':
            return order.orderNo > value;
          case 'lt':
            return order.orderNo < value;
          case 'is':
            return order.orderNo == value;
          default:
            return true;
        }
      case _FilterFieldId.email:
        final email = order.email.toLowerCase();
        final value = rule.value.toLowerCase();
        switch (rule.operatorId) {
          case 'is':
            return email == value;
          case 'is_not':
            return email != value;
          case 'contains':
            return email.contains(value);
          case 'has_any':
            return email.trim().isNotEmpty;
          default:
            return true;
        }
      case _FilterFieldId.revenue:
        final revenue = order.revenue;
        switch (rule.operatorId) {
          case 'between':
            final low = double.tryParse(rule.value) ?? double.negativeInfinity;
            final high =
                double.tryParse(rule.secondaryValue ?? '') ?? double.infinity;
            return revenue >= low && revenue <= high;
          case 'gt':
            return revenue > (double.tryParse(rule.value) ?? 0);
          case 'lt':
            return revenue < (double.tryParse(rule.value) ?? 0);
          default:
            return true;
        }
      case _FilterFieldId.purchased:
        return order.purchased.toLowerCase() == rule.value.toLowerCase();
      case _FilterFieldId.status:
        return order.status.toLowerCase() == rule.value.toLowerCase();
    }
  }

  List<_FilterRule> _rulesFromState(FilterState state) {
    final value = state.customFilters['rules'];
    if (value is List<_FilterRule>) {
      return value;
    }
    return const [];
  }

  FilterState _withRules(FilterState source, List<_FilterRule> rules) {
    final nextCustom = Map<String, Object?>.of(source.customFilters);
    if (rules.isEmpty) {
      nextCustom.remove('rules');
    } else {
      nextCustom['rules'] = rules;
    }
    return source.copyWith(
      customFilters: nextCustom,
      chips: rules
          .map(
            (rule) =>
                FilterChipData(key: 'rule:${rule.id}', label: _chipLabel(rule)),
          )
          .toList(growable: false),
    );
  }

  int? _ruleIdFromChipKey(String key) {
    if (!key.startsWith('rule:')) {
      return null;
    }
    return int.tryParse(key.substring(5));
  }

  String _chipLabel(_FilterRule rule) {
    switch (rule.field) {
      case _FilterFieldId.orderNumber:
        return 'Order # is ${_operatorText(rule.operatorId)} ${rule.value}';
      case _FilterFieldId.email:
        if (rule.operatorId == 'has_any') {
          return 'Email has any value';
        }
        return 'Email ${_operatorText(rule.operatorId)} ${rule.value}';
      case _FilterFieldId.revenue:
        if (rule.operatorId == 'between') {
          return 'Revenue is between \$${rule.value} and \$${rule.secondaryValue ?? ''}';
        }
        return 'Revenue is ${_operatorText(rule.operatorId)} \$${rule.value}';
      case _FilterFieldId.purchased:
        return 'Purchased is ${rule.value}';
      case _FilterFieldId.status:
        return 'Status is ${rule.value}';
    }
  }

  String _operatorText(String id) {
    switch (id) {
      case 'gt':
        return 'greater than';
      case 'lt':
        return 'less than';
      case 'is':
        return 'is';
      case 'is_not':
        return 'is not';
      case 'contains':
        return 'contains';
      case 'has_any':
        return 'has any value';
      case 'between':
        return 'between';
      default:
        return id;
    }
  }
}

class _RuleComposerSheet extends StatefulWidget {
  const _RuleComposerSheet({required this.title, required this.onApply});

  final String title;
  final ValueChanged<List<_FilterRule>> onApply;

  @override
  State<_RuleComposerSheet> createState() => _RuleComposerSheetState();
}

class _RuleComposerSheetState extends State<_RuleComposerSheet> {
  static const _fieldOptions = [
    _SelectOption(value: _FilterFieldId.orderNumber, label: 'Order #'),
    _SelectOption(value: _FilterFieldId.email, label: 'Email'),
    _SelectOption(value: _FilterFieldId.revenue, label: 'Revenue'),
    _SelectOption(value: _FilterFieldId.purchased, label: 'Purchased'),
    _SelectOption(value: _FilterFieldId.status, label: 'Status'),
  ];

  static const _operatorOptionsByField = {
    _FilterFieldId.orderNumber: [
      _SelectOption(value: 'gt', label: 'is greater than'),
      _SelectOption(value: 'lt', label: 'is less than'),
      _SelectOption(value: 'is', label: 'is'),
    ],
    _FilterFieldId.email: [
      _SelectOption(value: 'is', label: 'is'),
      _SelectOption(value: 'is_not', label: 'is not'),
      _SelectOption(value: 'contains', label: 'contains'),
      _SelectOption(value: 'has_any', label: 'has any value'),
    ],
    _FilterFieldId.revenue: [
      _SelectOption(value: 'between', label: 'is between'),
      _SelectOption(value: 'gt', label: 'is greater than'),
      _SelectOption(value: 'lt', label: 'is less than'),
    ],
    _FilterFieldId.purchased: [_SelectOption(value: 'is', label: 'is')],
    _FilterFieldId.status: [_SelectOption(value: 'is', label: 'is')],
  };

  _FilterFieldId _field = _FilterFieldId.orderNumber;
  String _operatorId = 'gt';
  final List<_FilterRule> _queuedRules = [];
  final _valueController = TextEditingController();
  final _secondaryController = TextEditingController();

  @override
  void dispose() {
    _valueController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final operators = _operatorOptionsByField[_field]!;
    if (!operators.any((option) => option.value == _operatorId)) {
      _operatorId = operators.first.value;
    }

    return FilterBarSheetScaffold(
      title: widget.title,
      maxHeight: 720,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_queuedRules.isNotEmpty) ...[
            ..._queuedRules.map(
              (rule) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.border,
                  ),
                  borderRadius: Theme.of(context).borderRadiusMd,
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(_ruleLabel(rule))),
                    GhostButton(
                      size: ButtonSize.small,
                      onPressed: () {
                        setState(() {
                          _queuedRules.remove(rule);
                        });
                      },
                      child: const Icon(LucideIcons.x),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Select<_FilterFieldId>(
            value: _field,
            itemBuilder: (context, value) {
              final option = _fieldOptions
                  .where((item) => item.value == value)
                  .first;
              return Text(option.label);
            },
            popup: SelectPopup<_FilterFieldId>(
              items: SelectItemList(
                children: _fieldOptions
                    .map(
                      (option) => SelectItemButton<_FilterFieldId>(
                        value: option.value,
                        child: Text(option.label),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              if (next == null) {
                return;
              }
              setState(() {
                _field = next;
              });
            },
          ),
          const SizedBox(height: 8),
          Select<String>(
            value: _operatorId,
            itemBuilder: (context, value) {
              final option = operators
                  .where((item) => item.value == value)
                  .first;
              return Text(option.label);
            },
            popup: SelectPopup<String>(
              items: SelectItemList(
                children: operators
                    .map(
                      (option) => SelectItemButton<String>(
                        value: option.value,
                        child: Text(option.label),
                      ),
                    )
                    .toList(growable: false),
              ),
            ).call,
            onChanged: (next) {
              if (next == null) {
                return;
              }
              setState(() {
                _operatorId = next;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _valueController,
            placeholder: Text(_valuePlaceholder()),
          ),
          if (_operatorId == 'between') ...[
            const SizedBox(height: 8),
            TextField(
              controller: _secondaryController,
              placeholder: const Text('Maximum value'),
            ),
          ],
        ],
      ),
      footer: Row(
        children: [
          Expanded(
            child: GhostButton(
              onPressed: _canQueueCurrent() ? _addCurrentToQueue : null,
              child: const Text('Add another'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GhostButton(
              onPressed: () => closeSheet(context),
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: PrimaryButton(
              onPressed: (_queuedRules.isNotEmpty || _canQueueCurrent())
                  ? _apply
                  : null,
              child: Text(
                _queuedRules.isEmpty ? 'Apply Filter' : 'Apply Filters',
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canQueueCurrent() {
    if (_operatorId == 'has_any') {
      return true;
    }
    if (_valueController.text.trim().isEmpty) {
      return false;
    }
    if (_operatorId == 'between' && _secondaryController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  _FilterRule _buildCurrentRule() {
    return _FilterRule(
      id: -1,
      field: _field,
      operatorId: _operatorId,
      value: _valueController.text.trim(),
      secondaryValue: _secondaryController.text.trim().isEmpty
          ? null
          : _secondaryController.text.trim(),
    );
  }

  void _addCurrentToQueue() {
    if (!_canQueueCurrent()) {
      return;
    }
    setState(() {
      _queuedRules.add(_buildCurrentRule());
      _valueController.clear();
      _secondaryController.clear();
    });
  }

  String _ruleLabel(_FilterRule rule) {
    if (rule.field == _FilterFieldId.revenue && rule.operatorId == 'between') {
      return 'Revenue is between \$${rule.value} and \$${rule.secondaryValue ?? ''}';
    }
    if (rule.field == _FilterFieldId.email && rule.operatorId == 'has_any') {
      return 'Email has any value';
    }
    final fieldName = switch (rule.field) {
      _FilterFieldId.orderNumber => 'Order #',
      _FilterFieldId.email => 'Email',
      _FilterFieldId.revenue => 'Revenue',
      _FilterFieldId.purchased => 'Purchased',
      _FilterFieldId.status => 'Status',
    };
    return '$fieldName ${rule.operatorId} ${rule.value}'.trim();
  }

  void _apply() {
    final all = <_FilterRule>[..._queuedRules];
    if (_canQueueCurrent()) {
      all.add(_buildCurrentRule());
    }
    if (all.isEmpty) {
      return;
    }
    widget.onApply(all);
  }

  String _valuePlaceholder() {
    switch (_field) {
      case _FilterFieldId.orderNumber:
        return 'Order number';
      case _FilterFieldId.email:
        return 'Email text';
      case _FilterFieldId.revenue:
        return 'Amount';
      case _FilterFieldId.purchased:
        return 'Product name';
      case _FilterFieldId.status:
        return 'Status (Paid, Pending...)';
    }
  }
}

@immutable
class _FilterRule {
  final int id;
  final _FilterFieldId field;
  final String operatorId;
  final String value;
  final String? secondaryValue;

  const _FilterRule({
    required this.id,
    required this.field,
    required this.operatorId,
    required this.value,
    this.secondaryValue,
  });

  _FilterRule copyWith({
    int? id,
    _FilterFieldId? field,
    String? operatorId,
    String? value,
    Object? secondaryValue = _sentinel,
  }) {
    return _FilterRule(
      id: id ?? this.id,
      field: field ?? this.field,
      operatorId: operatorId ?? this.operatorId,
      value: value ?? this.value,
      secondaryValue: identical(secondaryValue, _sentinel)
          ? this.secondaryValue
          : secondaryValue as String?,
    );
  }

  static const Object _sentinel = Object();
}

enum _FilterFieldId { orderNumber, email, revenue, purchased, status }

@immutable
class _SelectOption<T> {
  final T value;
  final String label;

  const _SelectOption({required this.value, required this.label});
}

class _OrderRecord {
  final int orderNo;
  final String date;
  final String customer;
  final String email;
  final String purchased;
  final double revenue;
  final String status;

  const _OrderRecord({
    required this.orderNo,
    required this.date,
    required this.customer,
    required this.email,
    required this.purchased,
    required this.revenue,
    required this.status,
  });
}
