import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'blocks.dart';
import '../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../ui/shadcn/components/layout/outlined_container/outlined_container.dart';
import '../../ui/shadcn/shared/primitives/text.dart';
import '../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

class WidgetUsageExample extends StatefulWidget {
  final String? title;
  final Widget child;
  final String code;
  final bool lazy;
  final bool collapsible;
  final double lazyThreshold;
  final String? installCommand;
  final EdgeInsetsGeometry? previewPadding;
  final bool previewFullBleed;
  final double? previewMinHeight;

  const WidgetUsageExample({
    super.key,
    this.title,
    required this.child,
    required this.code,
    this.lazy = true,
    this.collapsible = false,
    this.lazyThreshold = 0.1,
    this.installCommand,
    this.previewPadding,
    this.previewFullBleed = false,
    this.previewMinHeight,
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
    if (widget.lazy) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        // Ensure initial visibility is reported without requiring a scroll.
        VisibilityDetectorController.instance.notifyNow();
      });
    }
  }

  @override
  void didUpdateWidget(covariant WidgetUsageExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    final contentChanged =
        oldWidget.code != widget.code || oldWidget.title != widget.title;
    if (!widget.lazy) {
      _shouldBuildChild = true;
    } else if (contentChanged) {
      _shouldBuildChild = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          VisibilityDetectorController.instance.notifyNow();
        }
      });
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
    final theme = shadcn_theme.Theme.of(context);
    final spacing = theme.spacing;
    final effectivePreviewPadding =
        widget.previewPadding ?? EdgeInsets.all(spacing.xxl);
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) Text(widget.title!).h2(),
        if (widget.title != null) SizedBox(height: spacing.md),
        if (widget.installCommand != null) ...[
          const Text('Install via CLI').small().semiBold(),
          SizedBox(height: spacing.sm),
          DocsCodeBlock(code: widget.installCommand!),
          SizedBox(height: spacing.lg),
        ],
        const Text('Example Preview').small().semiBold(),
        SizedBox(height: spacing.sm),
        OutlinedContainer(
          child: Container(
            padding: effectivePreviewPadding,
            constraints: BoxConstraints(
              minHeight: widget.previewMinHeight ?? 350,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: !_expanded
                  ? Center(child: const Text('Example collapsed').muted())
                  : _shouldBuildChild
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            final minHeight =
                                widget.previewMinHeight ?? 350;
                            final height = constraints.hasBoundedHeight
                                ? constraints.maxHeight
                                : minHeight;
                            if (widget.previewFullBleed) {
                              return SizedBox(
                                width: constraints.maxWidth,
                                height: height,
                                child: Center(child: widget.child),
                              );
                            }
                            return SingleChildScrollView(
                              primary: false,
                              child: SizedBox(
                                width: constraints.maxWidth,
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: height,
                                      maxWidth: 720,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: widget.child,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: const Text('Loading preview...').muted(),
                        ),
            ),
          ),
        ),
        SizedBox(height: spacing.md),
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
              SizedBox(height: spacing.sm),
              DocsCodeBlock(code: widget.code),
            ],
          ),
        SizedBox(height: spacing.xl),
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
