import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'blocks.dart';
import '../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/primitives/text.dart';

class WidgetUsageExample extends StatefulWidget {
  final String? title;
  final Widget child;
  final String code;
  final bool lazy;
  final bool collapsible;
  final double lazyThreshold;

  const WidgetUsageExample({
    super.key,
    this.title,
    required this.child,
    required this.code,
    this.lazy = true,
    this.collapsible = false,
    this.lazyThreshold = 0.1,
  });

  @override
  State<WidgetUsageExample> createState() => _WidgetUsageExampleState();
}

class _WidgetUsageExampleState extends State<WidgetUsageExample> {
  bool _shouldBuildChild = false;
  bool _expanded = true;

  @override
  void initState() {
    super.initState();
    _expanded = !widget.collapsible;
    _shouldBuildChild = !widget.lazy;
  }

  @override
  void didUpdateWidget(covariant WidgetUsageExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.lazy) {
      _shouldBuildChild = true;
    }
    if (oldWidget.collapsible != widget.collapsible) {
      _expanded = !widget.collapsible;
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_shouldBuildChild && info.visibleFraction > widget.lazyThreshold) {
      setState(() {
        _shouldBuildChild = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) Text(widget.title!).h2(),
        if (widget.title != null) const SizedBox(height: 12),
        const Text('Example Preview').small().semiBold(),
        const SizedBox(height: 8),
        OutlinedContainer(
          child: ClipRect(
            child: Container(
              padding: const EdgeInsets.all(40),
              constraints: const BoxConstraints(minHeight: 350),
              child: Material(
                type: MaterialType.transparency,
                child: Center(
                  child: !_expanded
                      ? const Text('Example collapsed').muted()
                      : _shouldBuildChild
                          ? ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 720),
                              child: widget.child,
                            )
                          : const Text('Loading preview...').muted(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (!_expanded)
          shadcn_buttons.LinkButton(
            onPressed: () => setState(() => _expanded = true),
            child: const Text('Show example'),
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Usage Code').small().semiBold(),
              const SizedBox(height: 8),
              DocsCodeBlock(code: widget.code),
            ],
          ),
        const SizedBox(height: 24),
      ],
    );

    if (!widget.lazy) {
      return body;
    }

    return VisibilityDetector(
      key: ValueKey(widget.title ?? widget.code.hashCode),
      onVisibilityChanged: _onVisibilityChanged,
      child: body,
    );
  }
}
