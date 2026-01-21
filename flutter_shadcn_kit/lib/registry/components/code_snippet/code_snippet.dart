import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../shared/primitives/text.dart';
import '../../shared/theme/theme.dart';
import '../../shared/utils/style_value.dart';

/// Theme configuration for [CodeSnippet].
class CodeSnippetTheme extends ComponentThemeData {
  /// Background color of the code snip container.
  final Color? backgroundColor;

  /// Border color.
  final Color? borderColor;

  /// Border width.
  final double? borderWidth;

  /// Border radius.
  final BorderRadiusGeometry? borderRadius;

  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;

  /// Creates a theme for [CodeSnippet].
  const CodeSnippetTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
  });

  /// Returns a copy with replaced values.
  CodeSnippetTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? borderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return CodeSnippetTheme(
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      borderWidth: borderWidth == null ? this.borderWidth : borderWidth(),
      borderRadius:
          borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CodeSnippetTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        borderColor,
        borderWidth,
        borderRadius,
        padding,
      );
}

/// Syntax highlighted code display with optional actions.
class CodeSnippet extends StatefulWidget {
  /// Constraints applied to the snippet area.
  final BoxConstraints? constraints;

  /// Additional action buttons rendered in the top-right corner.
  final List<Widget> actions;

  /// The widget that renders the code content (typically [Text]).
  final Widget code;

  /// Creates a code snippet display.
  const CodeSnippet({
    super.key,
    this.constraints,
    this.actions = const [],
    required this.code,
  });

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CodeSnippetTheme>(context);
    final backgroundColor = styleValue(
      themeValue: compTheme?.backgroundColor,
      defaultValue: theme.colorScheme.card,
    );
    final borderColor = styleValue(
      themeValue: compTheme?.borderColor,
      defaultValue: theme.colorScheme.border,
    );
    final borderWidth = styleValue(
      themeValue: compTheme?.borderWidth,
      defaultValue: theme.scaling,
    );
    final borderRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      defaultValue: BorderRadius.circular(theme.radiusLg),
    );
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.only(
        left: theme.scaling * 16,
        right: theme.scaling * 48,
        top: theme.scaling * 16,
        bottom: theme.scaling * 16,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: borderRadius,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            constraints: widget.constraints,
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: padding,
                child: widget.code.mono.small.muted,
              ),
            ),
          ),
          if (widget.actions.isNotEmpty)
            Positioned(
              right: 8,
              top: 8,
              child: Row(
                children: _spacedActions,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> get _spacedActions {
    final actions = widget.actions;
    if (actions.isEmpty) {
      return const [];
    }
    final spaced = <Widget>[];
    for (var i = 0; i < actions.length; i++) {
      spaced.add(actions[i]);
      if (i < actions.length - 1) {
        spaced.add(const Gap(4));
      }
    }
    return spaced;
  }
}
