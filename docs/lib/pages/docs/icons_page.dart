import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../docs_page.dart';
import 'blocks.dart';
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/icons/bootstrap_icons.dart';
import '../../ui/shadcn/shared/icons/bootstrap_icons_list.dart';
import '../../ui/shadcn/shared/icons/lucide_icons.dart';
import '../../ui/shadcn/shared/icons/lucide_icons_list.dart';
import '../../ui/shadcn/shared/icons/radix_icons.dart';
import '../../ui/shadcn/shared/icons/radix_icons_list.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class IconsPage extends StatefulWidget {
  const IconsPage({super.key});

  @override
  State<IconsPage> createState() => _IconsPageState();
}

enum _IconSet {
  lucide,
  bootstrap,
  radix,
}

class _IconEntry {
  final String name;
  final IconData data;

  const _IconEntry(this.name, this.data);
}

class _IconsPageState extends State<IconsPage> {
  static const int _batchSize = 40;

  final TextEditingController _search = TextEditingController();
  final Map<_IconSet, int> _visibleCounts = {};
  _IconSet _activeSet = _IconSet.lucide;
  String _lastQuery = '';

  late final List<_IconEntry> _lucideEntries = [
    for (final entry in lucideIconEntries) _IconEntry(entry.name, entry.data),
  ];
  late final List<_IconEntry> _bootstrapEntries = [
    for (final entry in bootstrapIconEntries)
      _IconEntry(entry.name, entry.data),
  ];
  late final List<_IconEntry> _radixEntries = [
    for (final entry in radixIconEntries) _IconEntry(entry.name, entry.data),
  ];

  @override
  void initState() {
    super.initState();
    _search.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _search.removeListener(_handleSearchChanged);
    _search.dispose();
    super.dispose();
  }

  void _handleSearchChanged() {
    setState(() {
      _lastQuery = _search.text.trim().toLowerCase();
      _visibleCounts.clear();
    });
  }

  List<_IconEntry> _entriesFor(_IconSet set) {
    switch (set) {
      case _IconSet.bootstrap:
        return _bootstrapEntries;
      case _IconSet.radix:
        return _radixEntries;
      case _IconSet.lucide:
      return _lucideEntries;
    }
  }

  List<_IconEntry> _filteredEntries(_IconSet set, String query) {
    final entries = _entriesFor(set);
    if (query.isEmpty) return entries;
    return entries
        .where((entry) => entry.name.toLowerCase().contains(query))
        .toList();
  }

  int _visibleCountFor(_IconSet set, int total) {
    final current = _visibleCounts[set] ?? 0;
    if (current == 0) {
      final initial = total < _batchSize ? total : _batchSize;
      _visibleCounts[set] = initial;
      return initial;
    }
    if (current > total) {
      _visibleCounts[set] = total;
      return total;
    }
    return current;
  }

  void _loadMore(_IconSet set, int total) {
    final current = _visibleCounts[set] ?? 0;
    if (current >= total) return;
    setState(() {
      final next = current + _batchSize;
      _visibleCounts[set] = next > total ? total : next;
    });
  }

  Future<void> _copyName(String name) async {
    await Clipboard.setData(ClipboardData(text: name));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $name'),
        duration: const Duration(milliseconds: 1200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final OnThisPage setsKey = OnThisPage();
    final OnThisPage usageKey = OnThisPage();
    final OnThisPage sizingKey = OnThisPage();

    final query = _lastQuery;
    final filtered = _filteredEntries(_activeSet, query);
    final visibleCount = _visibleCountFor(_activeSet, filtered.length);

    return DocsPage(
      name: 'icons',
      onThisPage: {
        'Icon sets': setsKey,
        'Usage': usageKey,
        'Sizing': sizingKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Icons').h1(),
          const SizedBox(height: 8),
          const DocsParagraph(
            text:
                'Icons are bundled with the registry via multiple icon sets. Search, browse, and copy icon names on demand.',
          ),
          DocsSectionTitle(title: 'Icon sets', anchor: setsKey),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _SetChip(
                active: _activeSet == _IconSet.lucide,
                label: 'Lucide',
                count: _lucideEntries.length,
                icon: LucideIcons.sparkles,
                onTap: () => setState(() => _activeSet = _IconSet.lucide),
              ),
              _SetChip(
                active: _activeSet == _IconSet.bootstrap,
                label: 'Bootstrap',
                count: _bootstrapEntries.length,
                icon: BootstrapIcons.bootstrap,
                onTap: () => setState(() => _activeSet = _IconSet.bootstrap),
              ),
              _SetChip(
                active: _activeSet == _IconSet.radix,
                label: 'Radix',
                count: _radixEntries.length,
                icon: RadixIcons.tokens,
                onTap: () => setState(() => _activeSet = _IconSet.radix),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _search,
            decoration: InputDecoration(
              hintText: 'Search ${filtered.length} icons...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear',
                      onPressed: _search.clear,
                      icon: const Icon(Icons.close),
                    ),
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Showing $visibleCount of ${filtered.length}',
          ).xSmall().muted(),
          const SizedBox(height: 12),
          _IconGrid(
            entries: filtered,
            visibleCount: visibleCount,
            onLoadMore: () => _loadMore(_activeSet, filtered.length),
            onCopy: _copyName,
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Usage', anchor: usageKey),
          const SizedBox(height: 12),
          const DocsParagraph(
            text:
                'Import the icon constants and render them with the Icon widget. Combine with text for buttons and labels.',
          ),
          const DocsCodeBlock(
            code: "Icon(LucideIcons.star)\nText('Favorites')",
          ),
          const SizedBox(height: 20),
          DocsSectionTitle(title: 'Sizing', anchor: sizingKey),
          const SizedBox(height: 12),
          Row(
            children: [
              _sizeSample('Small', 16),
              const SizedBox(width: 12),
              _sizeSample('Medium', 24),
              const SizedBox(width: 12),
              _sizeSample('Large', 32),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sizeSample(String label, double size) {
    return OutlinedContainer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(LucideIcons.star, size: size),
            const SizedBox(height: 8),
            Text(label).small().muted(),
          ],
        ),
      ),
    );
  }
}

class _SetChip extends StatelessWidget {
  final bool active;
  final String label;
  final int count;
  final IconData icon;
  final VoidCallback onTap;

  const _SetChip({
    required this.active,
    required this.label,
    required this.count,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    final border = active ? theme.colorScheme.primary : theme.colorScheme.muted;
    final background =
        active ? theme.colorScheme.primary.withValues(alpha: 0.08) : null;
    final foreground = active
        ? theme.colorScheme.primaryForeground
        : theme.colorScheme.foreground;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: OutlinedContainer(
        borderColor: border,
        backgroundColor: background,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: foreground),
              const SizedBox(width: 8),
              Text(label).small().semiBold(),
              const SizedBox(width: 8),
              Text(count.toString()).xSmall().muted(),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconGrid extends StatelessWidget {
  final List<_IconEntry> entries;
  final int visibleCount;
  final VoidCallback onLoadMore;
  final ValueChanged<String> onCopy;

  const _IconGrid({
    required this.entries,
    required this.visibleCount,
    required this.onLoadMore,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final hasMore = visibleCount < entries.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
        mainAxisExtent: 120,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: visibleCount + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (hasMore && index == visibleCount) {
          return VisibilityDetector(
            key: ValueKey('load_more_${visibleCount}_${entries.length}'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0) {
                onLoadMore();
              }
            },
            child: _LoadMoreTile(remaining: entries.length - visibleCount),
          );
        }
        final entry = entries[index];
        return _IconTile(entry: entry, onCopy: onCopy);
      },
    );
  }
}

class _LoadMoreTile extends StatelessWidget {
  final int remaining;

  const _LoadMoreTile({required this.remaining});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(height: 8),
              Text('Loading $remaining more').xSmall().muted(),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  final _IconEntry entry;
  final ValueChanged<String> onCopy;

  const _IconTile({required this.entry, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Copy ${entry.name}',
      child: InkWell(
        onTap: () => onCopy(entry.name),
        borderRadius: BorderRadius.circular(12),
        child: OutlinedContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(entry.data, size: 24),
                const SizedBox(height: 8),
                Text(entry.name).xSmall().muted(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
