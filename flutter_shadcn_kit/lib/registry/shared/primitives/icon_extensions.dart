import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

/// Icon extension utilities used by command and other registry components.
extension IconExtensions on Widget {
  /// Applies the small icon theme to this widget.
  Widget iconSmall() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final inherited = IconTheme.of(context);
        return IconTheme(
          data: theme.iconTheme.small.merge(inherited),
          child: this,
        );
      },
    );
  }

  /// Applies the extra-small icon theme to this widget.
  Widget iconXSmall() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final inherited = IconTheme.of(context);
        return IconTheme(
          data: theme.iconTheme.xSmall.merge(inherited),
          child: this,
        );
      },
    );
  }

  /// Applies the extra-extra-extra-small icon theme to this widget.
  Widget iconX3Small() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final inherited = IconTheme.of(context);
        return IconTheme(
          data: theme.iconTheme.x3Small.merge(inherited),
          child: this,
        );
      },
    );
  }

  /// Applies the muted foreground icon theme to this widget.
  Widget iconMutedForeground() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final inherited = IconTheme.of(context);
        return IconTheme(
          data: IconThemeData(
            color: theme.colorScheme.mutedForeground,
          ).merge(inherited),
          child: this,
        );
      },
    );
  }
}
