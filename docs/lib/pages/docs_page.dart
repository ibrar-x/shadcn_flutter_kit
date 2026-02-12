import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../theme/docs_theme.dart';
import '../theme/theme_controller.dart';
import '../ui/shadcn/components/control/button/button.dart' as shadcn_buttons;
import '../ui/shadcn/components/control/command/command.dart';
import '../ui/shadcn/components/display/badge/badge.dart';
import '../ui/shadcn/components/display/icon/icon.dart';
import '../ui/shadcn/components/layout/basic/basic.dart' as shadcn_basic;
import '../ui/shadcn/components/layout/scaffold/scaffold.dart'
    as shadcn_scaffold;
import '../ui/shadcn/components/layout/media_query/media_query.dart';
import '../ui/shadcn/components/layout/stage_container/stage_container.dart';
import '../ui/shadcn/components/navigation/breadcrumb/breadcrumb.dart';
import '../ui/shadcn/components/overlay/drawer/drawer.dart';
import '../ui/shadcn/shared/icons/lucide_icons.dart';
import '../ui/shadcn/shared/primitives/text.dart';
import '../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;
import '../ui/shadcn/shared/utils/util.dart';
import 'docs/component_previews.dart';
import 'docs/component_examples.dart';
import 'docs/components_registry.dart';

const double breakpointWidth = 768;
const double breakpointWidth2 = 1024;

class OnThisPage extends LabeledGlobalKey {
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  OnThisPage([super.debugLabel]);
}

class PageItemWidget extends StatelessWidget {
  final OnThisPage onThisPage;
  final Widget child;

  const PageItemWidget({
    super.key,
    required this.onThisPage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: onThisPage,
      child: child,
      onVisibilityChanged: (info) {
        onThisPage.isVisible.value = info.visibleFraction >= 1;
      },
    );
  }
}

class DocsPage extends StatefulWidget {
  final String name;
  final Widget child;
  final Widget? sidebar;
  final Map<String, OnThisPage> onThisPage;
  final List<Widget> navigationItems;
  final bool scrollable;

  const DocsPage({
    super.key,
    required this.name,
    required this.child,
    this.sidebar,
    this.onThisPage = const {},
    this.navigationItems = const [],
    this.scrollable = true,
  });

  @override
  State<DocsPage> createState() => DocsPageState();
}

enum DocsTag {
  experimental,
  workInProgress,
  updated,
  newFeature,
  ;

  Widget badge(BuildContext context) {
    final badge = switch (this) {
      DocsTag.experimental => const PrimaryBadge(child: Text('Experimental')),
      DocsTag.workInProgress => const PrimaryBadge(child: Text('WIP')),
      DocsTag.updated => const PrimaryBadge(child: Text('Updated')),
      DocsTag.newFeature => const PrimaryBadge(child: Text('New')),
    };
    return IgnorePointer(child: ExcludeSemantics(child: badge));
  }
}

class _OpenSearchIntent extends Intent {
  const _OpenSearchIntent();
}

class DocsPageRef {
  final String title;
  final String name;
  final String routeName;
  final Map<String, String> pathParameters;
  final DocsTag? tag;

  DocsPageRef(
    this.title,
    this.name, {
    String? routeName,
    Map<String, String>? pathParameters,
    this.tag,
  })  : routeName = routeName ?? name,
        pathParameters = pathParameters ?? const {};
}

class DocsSection {
  final String title;
  final IconData icon;
  final List<DocsPageRef> pages;

  DocsSection(this.title, this.pages, {this.icon = Icons.book});
}

class DocsPageState extends State<DocsPage> {
  static final List<DocsSection> baseSections = [
    DocsSection(
      'Getting Started',
      [
        DocsPageRef('Introduction', 'introduction'),
        DocsPageRef('Installation', 'installation'),
        DocsPageRef('App Setup', 'app-setup'),
        DocsPageRef('Registry Guide', 'registry-guide'),
        DocsPageRef('Theme', 'theme'),
        DocsPageRef('Typography', 'typography'),
        DocsPageRef('Layout', 'layout'),
        DocsPageRef('Web Preloader', 'web_preloader'),
        DocsPageRef('Components', 'components'),
        DocsPageRef('Icons', 'icons'),
        DocsPageRef('Colors', 'colors'),
        DocsPageRef('Material/Cupertino', 'material'),
      ],
    ),
  ];

  final ScrollController scrollController = ScrollController();
  final List<OnThisPage> currentlyVisible = [];
  bool _isSheetOpen = false;
  late List<DocsSection> _sections;

  @override
  void initState() {
    super.initState();
    _sections = List.of(baseSections);
    for (final child in widget.onThisPage.values) {
      child.isVisible.addListener(_onVisibilityChanged);
    }
    _loadComponentSections();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant DocsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mapEquals(oldWidget.onThisPage, widget.onThisPage)) {
      for (final child in widget.onThisPage.values) {
        child.isVisible.addListener(_onVisibilityChanged);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (final child in widget.onThisPage.values) {
      child.isVisible.removeListener(_onVisibilityChanged);
    }
    scrollController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged() {
    if (!mounted) return;
    setState(() {
      currentlyVisible
        ..clear()
        ..addAll(widget.onThisPage.values
            .where((element) => element.isVisible.value));
    });
  }

  bool isVisible(OnThisPage onThisPage) {
    return currentlyVisible.isNotEmpty && currentlyVisible.first == onThisPage;
  }

  void showSearchDialog() {
    showCommandDialog(
      context: context,
      builder: (context, query) {
        final search = query?.trim().toLowerCase() ?? '';
        final filteredSections = <DocsSection>[];
        for (final section in _sections) {
          final pages = section.pages.where((page) {
            if (search.isEmpty) return true;
            return page.title.toLowerCase().contains(search) ||
                page.name.toLowerCase().contains(search) ||
                section.title.toLowerCase().contains(search);
          }).toList();
          if (pages.isEmpty) continue;
          filteredSections.add(
            DocsSection(
              section.title,
              pages,
              icon: section.icon,
            ),
          );
        }
        return Stream.value([
          ListView(
            shrinkWrap: true,
            children: [
              for (final section in filteredSections)
                CommandCategory(
                  title: Text(section.title),
                  children: [
                    for (final page in section.pages)
                      CommandItem(
                        title: Text(page.title),
                        trailing: Icon(section.icon),
                        onTap: () => context.goNamed(
                          page.routeName,
                          pathParameters: page.pathParameters,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ]);
      },
    );
  }

  Future<void> _loadComponentSections() async {
    final components = (await loadRegistryComponents())
        .where((component) => originalComponentIds.contains(component.id))
        .toList();
    if (!mounted) {
      return;
    }

    final grouped = <String, List<RegistryComponent>>{};
    for (final component in components) {
      final category = component.category.toLowerCase().trim();
      grouped.putIfAbsent(category, () => []);
      grouped[category]!.add(component);
    }

    const categoryOrder = [
      'application',
      'animation',
      'control',
      'disclosure',
      'display',
      'feedback',
      'form',
      'layout',
      'navigation',
      'overlay',
      'utility',
      'data',
    ];

    final categoryKeys = [
      ...categoryOrder.where(grouped.containsKey),
      ...grouped.keys.where((key) => !categoryOrder.contains(key)).toList()
        ..sort(),
    ];

    final componentSections = [
      for (final category in categoryKeys)
        DocsSection(
          _titleCase(category),
          grouped[category]!
              .map((component) => DocsPageRef(
                    component.name,
                    component.id,
                    routeName: 'component_detail',
                    pathParameters: {'id': component.id},
                    tag: _tagForComponent(component.id),
                  ))
              .toList(),
          icon: iconForCategory(category),
        ),
    ];

    setState(() {
      _sections = [
        ...baseSections,
        ...componentSections,
      ];
    });
  }

  DocsTag? _tagForComponent(String componentId) {
    final status = componentStatusTags[componentId];
    switch (status) {
      case 'Experimental':
        return DocsTag.experimental;
      case 'WIP':
        return DocsTag.workInProgress;
      case 'New':
        return DocsTag.newFeature;
      case 'Updated':
        return DocsTag.updated;
    }
    return null;
  }

  String _titleCase(String value) {
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  Widget _buildHeader(BuildContext context, {required double contentHeight}) {
    final scaling = context.docsTheme.scaling;
    final theme = shadcn_theme.Theme.of(context);
    final spacing = theme.spacing;
    final width = MediaQuery.of(context).size.width;
    final showSearchBar = width >= breakpointWidth2;
    final showDrawer = width < breakpointWidth;
    return shadcn_scaffold.AppBar(
      leading: const [],
      trailing: const [],
      height: contentHeight,
      padding: EdgeInsets.symmetric(
        horizontal: spacing.xl * scaling,
        vertical: spacing.md * scaling,
      ),
      backgroundColor: theme.colorScheme.card,
      surfaceOpacity: theme.surfaceOpacity,
      surfaceBlur: theme.surfaceBlur,
      child: Row(
        children: [
          if (showDrawer)
            shadcn_buttons.GhostButton(
              onPressed: _openDrawer,
              density: shadcn_buttons.ButtonDensity.icon,
              child: const Icon(Icons.menu),
            ),
          const Text('shadcn_flutter_registry').semiBold(),
          if (showSearchBar) ...[
            const Spacer(),
            Expanded(
              flex: 3,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: shadcn_buttons.OutlineButton(
                    onPressed: showSearchDialog,
                    child: Row(
                      children: [
                        const Icon(Icons.search).iconSmall(),
                        SizedBox(width: spacing.xs * scaling),
                        const Text('Search documentation...').muted(),
                        const Spacer(),
                        const Text('Cmd+K / Ctrl+K').xSmall().muted(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ] else
            const Spacer(),
          if (!showSearchBar)
            shadcn_buttons.GhostButton(
              onPressed: showSearchDialog,
              density: shadcn_buttons.ButtonDensity.icon,
              child: const Icon(Icons.search),
            ),
          shadcn_buttons.GhostButton(
            onPressed: () => launchUrlString(
              'https://github.com/ibrar-x/shadcn_flutter_kit',
            ),
            density: shadcn_buttons.ButtonDensity.icon,
            child: const Icon(LucideIcons.github),
          ),
          _buildThemeToggle(context),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final controller = context.docsThemeController;
    final isDark = controller.brightness == Brightness.dark;
    return shadcn_buttons.ButtonGroup(
      children: [
        isDark
            ? shadcn_buttons.IconButton.ghost(
                onPressed: () => controller.setBrightness(Brightness.light),
                size: shadcn_buttons.ButtonSize.small,
                density: shadcn_buttons.ButtonDensity.iconDense,
                icon: const Icon(Icons.light_mode),
              )
            : shadcn_buttons.IconButton.secondary(
                onPressed: () => controller.setBrightness(Brightness.light),
                size: shadcn_buttons.ButtonSize.small,
                density: shadcn_buttons.ButtonDensity.iconDense,
                icon: const Icon(Icons.light_mode),
              ),
        isDark
            ? shadcn_buttons.IconButton.secondary(
                onPressed: () => controller.setBrightness(Brightness.dark),
                size: shadcn_buttons.ButtonSize.small,
                density: shadcn_buttons.ButtonDensity.iconDense,
                icon: const Icon(Icons.dark_mode),
              )
            : shadcn_buttons.IconButton.ghost(
                onPressed: () => controller.setBrightness(Brightness.dark),
                size: shadcn_buttons.ButtonSize.small,
                density: shadcn_buttons.ButtonDensity.iconDense,
                icon: const Icon(Icons.dark_mode),
              ),
      ],
    );
  }

  void _openDrawer() {
    if (_isSheetOpen) {
      return;
    }
    setState(() {
      _isSheetOpen = true;
    });
    final mediaWidth = MediaQuery.of(context).size.width;
    final targetWidth = mediaWidth * 0.6;
    final routerContext = context;
    openSheet(
      context: context,
      position: OverlayPosition.left,
      constraints: BoxConstraints.tightFor(width: targetWidth),
      builder: (context) {
        final theme = shadcn_theme.Theme.of(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                    left: 32, right: 32, bottom: 48, top: 48) *
                theme.scaling,
            child: SizedBox(
              width: targetWidth,
              child: SidebarNav(
                children: [
                  for (final section in _sections)
                    SidebarSection(
                      header: Text(section.title),
                      children: [
                        for (final page in section.pages)
                          DocsNavigationButton(
                            onPressed: () {
                              closeSheet(context);
                              routerContext.goNamed(
                                page.routeName,
                                pathParameters: page.pathParameters,
                              );
                            },
                            selected: page.name == widget.name,
                            child: shadcn_basic.Basic(
                              content: Text(page.title),
                              trailing: page.tag?.badge(context),
                              trailingAlignment:
                                  AlignmentDirectional.centerStart,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      if (mounted) {
        setState(() {
          _isSheetOpen = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasOnThisPage = widget.onThisPage.isNotEmpty;
    final currentPage = _sections
        .expand((section) => section.pages)
        .where((page) => page.name == widget.name)
        .firstOrNull;
    final width = MediaQuery.of(context).size.width;
    if (_isSheetOpen && width >= breakpointWidth) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          closeSheet(context);
        }
      });
    }

    return StageContainer(
      builder: (context, padding) {
        final theme = shadcn_theme.Theme.of(context);
        final headerContentHeight = 36 * theme.scaling;
        return Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK):
                const _OpenSearchIntent(),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
                const _OpenSearchIntent(),
            LogicalKeySet(LogicalKeyboardKey.slash): const _OpenSearchIntent(),
          },
          child: Actions(
            actions: {
              _OpenSearchIntent: CallbackAction<_OpenSearchIntent>(
                onInvoke: (_) {
                  showSearchDialog();
                  return null;
                },
              ),
            },
            child: Focus(
              autofocus: true,
              child: shadcn_scaffold.Scaffold(
                headers: [
                  _buildHeader(
                    context,
                    contentHeight: headerContentHeight,
                  ),
                  const Divider(height: 1),
                ],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQueryVisibility(
                      minWidth: breakpointWidth,
                      child: FocusTraversalGroup(
                        child: SingleChildScrollView(
                          key: const PageStorageKey('sidebar'),
                          padding: EdgeInsets.only(
                                top: theme.spacing.xxl,
                                left: theme.spacing.xl + padding.left,
                                bottom: theme.spacing.xxl,
                              ) *
                              theme.scaling,
                          child: SidebarNav(
                            children: [
                              for (final section in _sections)
                                SidebarSection(
                                  header: Text(section.title),
                                  children: [
                                    for (final page in section.pages)
                                      DocsNavigationButton(
                                        onPressed: () => context.goNamed(
                                          page.routeName,
                                          pathParameters: page.pathParameters,
                                        ),
                                        selected: page.name == widget.name,
                                        child: shadcn_basic.Basic(
                                          content: Text(page.title),
                                          trailing: page.tag?.badge(context),
                                          trailingAlignment:
                                              AlignmentDirectional.centerStart,
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: widget.scrollable
                          ? SingleChildScrollView(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(
                                horizontal: theme.spacing.xxl,
                                vertical: theme.spacing.xl,
                              ).copyWith(
                                right: (hasOnThisPage || widget.sidebar != null)
                                    ? theme.spacing.xl
                                    : theme.spacing.xxl,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Breadcrumb(
                                    separator: Breadcrumb.slashSeparator,
                                    children: [
                                      TextButton(
                                        onPressed: () => context.goNamed(
                                          'introduction',
                                        ),
                                        child: const Text('Docs'),
                                      ),
                                      ...widget.navigationItems,
                                      if (currentPage != null)
                                        Text(currentPage.title),
                                    ],
                                  ),
                                  SizedBox(
                                    height: theme.spacing.lg,
                                  ),
                                  widget.child,
                                ],
                              ),
                            )
                          : widget.child,
                    ),
                    if (widget.sidebar != null)
                      MediaQueryVisibility(
                        minWidth: breakpointWidth2,
                        child: FocusTraversalGroup(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                  top: theme.spacing.xxl,
                                  right: theme.spacing.xl,
                                  bottom: theme.spacing.xxl,
                                  left: theme.spacing.xl,
                                ) *
                                theme.scaling,
                            child: widget.sidebar ?? const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    if (hasOnThisPage)
                      MediaQueryVisibility(
                        minWidth: breakpointWidth2,
                        child: SizedBox(
                          width: (padding.right + 180) * theme.scaling,
                          child: FocusTraversalGroup(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(
                                    top: theme.spacing.xxl,
                                    right: theme.spacing.xl,
                                    bottom: theme.spacing.xxl,
                                    left: theme.spacing.xl,
                                  ) *
                                  theme.scaling,
                              child: SidebarNav(
                                children: [
                                  SidebarSection(
                                    header: const Text('On This Page'),
                                    children: [
                                      for (final entry
                                          in widget.onThisPage.entries)
                                        SidebarButton(
                                          onPressed: () {
                                            final context =
                                                entry.value.currentContext;
                                            if (context == null) {
                                              return;
                                            }
                                            Scrollable.ensureVisible(
                                              context,
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                            );
                                          },
                                          selected:
                                              entry.value.currentContext !=
                                                      null &&
                                                  isVisible(entry.value),
                                          child: Text(entry.key),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class SidebarNav extends StatelessWidget {
  final List<Widget> children;

  const SidebarNav({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final spacedChildren = <Widget>[];
    for (var index = 0; index < children.length; index += 1) {
      if (index > 0) {
        spacedChildren.add(const Gap(16));
      }
      spacedChildren.add(children[index]);
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: spacedChildren,
        ),
      ),
    );
  }
}

class SidebarSection extends StatelessWidget {
  final Widget header;
  final List<Widget> children;

  const SidebarSection({
    super.key,
    required this.header,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header.small().semiBold().withPadding(vertical: 4, horizontal: 8),
        const Gap(4),
        ...children,
      ],
    );
  }
}

class DocsNavigationButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool selected;
  final Widget child;
  final Widget? trailing;

  const DocsNavigationButton({
    super.key,
    required this.onPressed,
    required this.selected,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    var data = shadcn_theme.Theme.of(context);
    if (!selected) {
      data = data.copyWith(
        colorScheme: () => data.colorScheme.copyWith(
          foreground: () => data.colorScheme.mutedForeground,
        ),
      );
    }
    return shadcn_theme.Theme(
      data: data,
      child: shadcn_buttons.Button(
        onPressed: onPressed,
        alignment: AlignmentDirectional.centerStart,
        style: shadcn_buttons.ButtonVariance.link.copyWith(
          padding: (context, states, value) {
            return const EdgeInsets.symmetric(vertical: 4, horizontal: 8);
          },
          textStyle: (context, states, value) {
            return value.copyWith(
              fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
            );
          },
        ),
        child: Row(
          children: [
            child.small(),
            if (trailing != null) const Gap(8),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool selected;
  final Widget child;

  const SidebarButton({
    super.key,
    required this.onPressed,
    required this.selected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var data = shadcn_theme.Theme.of(context);
    if (selected) {
      data = data.copyWith(
        colorScheme: () => data.colorScheme.copyWith(
          mutedForeground: () => data.colorScheme.secondaryForeground,
        ),
      );
    }
    return shadcn_theme.Theme(
      data: data,
      child: shadcn_buttons.Button(
        onPressed: onPressed,
        alignment: AlignmentDirectional.centerStart,
        style: shadcn_buttons.ButtonVariance.text.copyWith(
          padding: (context, states, value) {
            return const EdgeInsets.symmetric(vertical: 4, horizontal: 8) *
                data.scaling;
          },
          textStyle: (context, states, value) {
            return value.copyWith(
              fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
            );
          },
        ),
        child: child.small(),
      ),
    );
  }
}
