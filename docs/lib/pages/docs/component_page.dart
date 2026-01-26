import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../docs_page.dart';
import 'widget_usage_example.dart';
import 'blocks.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;

class ComponentPage extends StatefulWidget {
  final String name;
  final String displayName;
  final String description;
  final List<Widget> children;
  final bool component;
  final String? category;

  const ComponentPage({
    super.key,
    required this.name,
    required this.description,
    required this.displayName,
    required this.children,
    this.component = true,
    this.category,
  });

  @override
  State<ComponentPage> createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  final List<GlobalKey> keys = [];
  final Map<String, OnThisPage> onThisPage = {};

  @override
  void initState() {
    super.initState();
    _syncAnchors();
  }

  @override
  void didUpdateWidget(covariant ComponentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      _syncAnchors();
    }
  }

  void _syncAnchors() {
    keys.clear();
    onThisPage.clear();
    for (final child in widget.children) {
      if (child is! WidgetUsageExample) {
        continue;
      }
      final title = child.title;
      if (title == null) {
        continue;
      }
      keys.add(GlobalKey());
      onThisPage[title] = OnThisPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final remappedChildren = <Widget>[];
    var index = 0;
    for (final child in widget.children) {
      if (child is! WidgetUsageExample) {
        remappedChildren.add(child);
        continue;
      }
      final title = child.title;
      if (title == null) {
        continue;
      }
      remappedChildren.add(
        PageItemWidget(
          onThisPage: onThisPage[title]!,
          key: keys[index],
          child: child,
        ),
      );
      index += 1;
    }

    return DocsPage(
      name: widget.name,
      onThisPage: onThisPage,
      navigationItems: [
        if (widget.component)
          shadcn_buttons.LinkButton(
            density: shadcn_buttons.ButtonDensity.compact,
            onPressed: () => context.goNamed('components'),
            child: const Text('Components'),
          ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(widget.displayName).h1(),
          SelectableText(widget.description).lead(),
          if (widget.category != null) ...[
            const SizedBox(height: 8),
            Text('Category: ${widget.category}').small().muted(),
          ],
          if (widget.component) ...[
            const SizedBox(height: 16),
            const Text('Install via CLI').small().semiBold(),
            const SizedBox(height: 8),
            DocsCodeBlock(code: 'flutter_shadcn add ${widget.name}'),
          ],
          const SizedBox(height: 16),
          ...remappedChildren,
        ],
      ),
    );
  }
}
