import 'package:flutter/material.dart' hide CarouselView, CarouselController;
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../docs_page.dart';
import 'blocks.dart';
import 'components_registry.dart';
import 'component_examples.dart';
import 'component_previews.dart';
import '../../ui/shadcn/components/display/feature_carousel/feature_carousel.dart'
    as feature_carousel;
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/icons/lucide_icons.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  static const int _batchSize = 40;

  final TextEditingController _search = TextEditingController();
  late Future<List<RegistryComponent>> _future;
  final Map<String, int> _visibleCounts = {};
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _future = loadRegistryComponents();
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

  int _visibleCountFor(String category, int total) {
    final current = _visibleCounts[category] ?? 0;
    if (current == 0) {
      final initial = total < _batchSize ? total : _batchSize;
      _visibleCounts[category] = initial;
      return initial;
    }
    if (current > total) {
      _visibleCounts[category] = total;
      return total;
    }
    return current;
  }

  void _loadMore(String category, int total) {
    final current = _visibleCounts[category] ?? 0;
    if (current >= total) return;
    setState(() {
      final next = current + _batchSize;
      _visibleCounts[category] = next > total ? total : next;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RegistryComponent>>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final OnThisPage featuredKey = OnThisPage();
        final query = _lastQuery;
        final components = snapshot.data!
            .where((component) => originalComponentIds.contains(component.id))
            .where((component) {
          if (query.isEmpty) return true;
          return component.name.toLowerCase().contains(query) ||
              component.id.toLowerCase().contains(query) ||
              component.description.toLowerCase().contains(query) ||
              component.tags.any((tag) => tag.toLowerCase().contains(query));
        }).toList();

        final categories = <String, List<RegistryComponent>>{};
        for (final component in components) {
          categories.putIfAbsent(component.category, () => []).add(component);
        }
        final sortedCategories = categories.keys.toList()..sort();

        final anchors = {
          'Featured': featuredKey,
          for (final category in sortedCategories) category: OnThisPage(),
        };

        return DocsPage(
          name: 'components',
          onThisPage: anchors,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Components').h1(),
              const SizedBox(height: 12),
              const DocsParagraph(
                text:
                    'Browse the registry component catalog. Each tile links to the component detail page with examples.',
              ),
              DocsSectionTitle(title: 'Featured', anchor: featuredKey),
              const SizedBox(height: 12),
              const _FeatureCarouselPreview(),
              const SizedBox(height: 20),
              if (exampleBatches.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final batch in exampleBatches)
                      OutlinedContainer(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Text(
                            '${batch.title} • ${batch.componentIds.length} examples',
                          ).xSmall(),
                        ),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              TextField(
                controller: _search,
                decoration: const InputDecoration(
                  hintText: 'Search components...',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
              const SizedBox(height: 20),
              for (final category in sortedCategories) ...[
                DocsSectionTitle(
                  title: category,
                  anchor: anchors[category],
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final categoryComponents = categories[category]!;
                    final visibleCount = _visibleCountFor(
                      category,
                      categoryComponents.length,
                    );
                    final hasMore = visibleCount < categoryComponents.length;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 260,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: visibleCount + (hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (hasMore && index == visibleCount) {
                          return VisibilityDetector(
                            key: ValueKey(
                              'load_more_${category}_$visibleCount',
                            ),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction > 0) {
                                _loadMore(
                                  category,
                                  categoryComponents.length,
                                );
                              }
                            },
                            child: _LoadMoreTile(
                              remaining:
                                  categoryComponents.length - visibleCount,
                            ),
                          );
                        }
                        return _ComponentTile(
                          component: categoryComponents[index],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _ComponentTile extends StatefulWidget {
  final RegistryComponent component;

  const _ComponentTile({required this.component});

  @override
  State<_ComponentTile> createState() => _ComponentTileState();
}

class _ComponentTileState extends State<_ComponentTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    final status = componentStatusTags[widget.component.id];
    final borderColor =
        _hovering ? theme.colorScheme.ring : theme.colorScheme.muted;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => context.go('/components/${widget.component.id}'),
        child: SizedBox(
          width: 250,
          height: 200,
          child: OutlinedContainer(
            borderColor: borderColor,
            duration: const Duration(milliseconds: 180),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.accent,
                        borderRadius: BorderRadius.only(
                          topLeft: theme.borderRadiusXl.topLeft,
                          topRight: theme.borderRadiusXl.topRight,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: 160,
                            height: 80,
                            child: Center(
                              child: _LazyPreview(
                                placeholder: _ComponentPreviewPlaceholder(
                                  icon: iconForCategory(
                                      widget.component.category),
                                  label: widget.component.name,
                                ),
                                builder: (context) => buildComponentPreview(
                                  context,
                                  widget.component.id,
                                  label: widget.component.name,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.component.name).small().semiBold(),
                      ),
                      if (status != null) buildStatusBadge(status),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LazyPreview extends StatefulWidget {
  final Widget placeholder;
  final WidgetBuilder builder;

  const _LazyPreview({required this.placeholder, required this.builder});

  @override
  State<_LazyPreview> createState() => _LazyPreviewState();
}

class _LazyPreviewState extends State<_LazyPreview> {
  bool _visible = false;

  void _handleVisibility(VisibilityInfo info) {
    if (_visible || info.visibleFraction <= 0) return;
    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: _handleVisibility,
      child: _visible ? widget.builder(context) : widget.placeholder,
    );
  }
}

class _ComponentPreviewPlaceholder extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ComponentPreviewPlaceholder({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(height: 6),
        Text(label).xSmall().muted(),
      ],
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

class _FeatureCarouselPreview extends StatefulWidget {
  const _FeatureCarouselPreview();

  @override
  State<_FeatureCarouselPreview> createState() =>
      _FeatureCarouselPreviewState();
}

class _FeatureCarouselPreviewState extends State<_FeatureCarouselPreview> {
  final feature_carousel.FeatureCarouselController _controller =
      feature_carousel.FeatureCarouselController(
    showCta: false,
    showNavArrows: false,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 3),
    animationStyle: feature_carousel.FeatureCarouselAnimationStyle.zoomFade,
    cycleAnimationStyles: false,
    enableKeyboardNavigation: false,
  );

  final List<feature_carousel.FeatureCarouselItem> _items = const [
    feature_carousel.FeatureCarouselItem(
      title: 'Feature carousel',
      description: 'Stacked cards with smooth transitions and autoplay.',
      icon: LucideIcons.component,
      accentColor: Color(0xFF7EA3FF),
    ),
    feature_carousel.FeatureCarouselItem(
      title: 'Animated states',
      description: 'Cycle animation styles to showcase key product ideas.',
      icon: LucideIcons.sparkles,
      accentColor: Color(0xFF9B87FF),
    ),
    feature_carousel.FeatureCarouselItem(
      title: 'Responsive layout',
      description: 'Tune sizes and typography to fit dense layouts.',
      icon: LucideIcons.layoutGrid,
      accentColor: Color(0xFF67D4FF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Feature carousel preview').small().semiBold(),
            const SizedBox(height: 12),
            Center(
              child: feature_carousel.FeatureCardCarousel(
                controller: _controller,
                width: 520,
                height: 320,
                items: _items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
