import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../../../shared/icons/radix_icons.dart';
import '../../../shared/primitives/text.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';

/// Theme for [Breadcrumb].
class BreadcrumbTheme extends ComponentThemeData {
  /// Separator widget between breadcrumb items.
  final Widget? separator;

  /// Padding surrounding the breadcrumb row.
  final EdgeInsetsGeometry? padding;

  /// Creates a [BreadcrumbTheme].
  const BreadcrumbTheme({this.separator, this.padding});

  /// Returns a copy of this theme with the given values replaced.
  BreadcrumbTheme copyWith({
    ValueGetter<Widget?>? separator,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return BreadcrumbTheme(
      separator: separator == null ? this.separator : separator(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BreadcrumbTheme &&
        other.separator == separator &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(separator, padding);
}

class _ArrowSeparator extends StatelessWidget {
  const _ArrowSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * scaling),
      child: IconTheme(
        data: IconThemeData(
          color: theme.colorScheme.mutedForeground,
          size: 12 * scaling,
        ),
        child: const Icon(RadixIcons.chevronRight),
      ),
    );
  }
}

class _SlashSeparator extends StatelessWidget {
  const _SlashSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 * scaling),
      child: const Text('/').small().muted(),
    );
  }
}

/// Navigation breadcrumb trail showing hierarchical path with customizable separators.
class Breadcrumb extends StatelessWidget {
  /// Arrow separator (>).
  static const Widget arrowSeparator = _ArrowSeparator();

  /// Slash separator (/).
  static const Widget slashSeparator = _SlashSeparator();

  /// The breadcrumb items rendered from root to current location.
  final List<Widget> children;

  /// Separator inserted between items.
  final Widget? separator;

  /// Padding around the breadcrumb strip.
  final EdgeInsetsGeometry? padding;

  /// Creates a breadcrumb navigation row.
  const Breadcrumb({
    super.key,
    required this.children,
    this.separator,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BreadcrumbTheme>(context);
    final sep = separator ?? compTheme?.separator ?? Breadcrumb.arrowSeparator;
    final pad = styleValue(
      widgetValue: padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.zero,
    );
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
        dragDevices: {PointerDeviceKind.touch},
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: pad,
          child: Row(
            children: [
              if (children.length == 1) children[0].medium().foreground(),
              if (children.length > 1)
                for (var i = 0; i < children.length; i++)
                  if (i == children.length - 1)
                    children[i].medium().foreground()
                  else
                    Row(children: [children[i].medium(), sep]),
            ],
          ).small().muted(),
        ),
      ),
    );
  }
}
