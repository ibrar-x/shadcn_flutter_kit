import 'package:flutter/widgets.dart';

import '../app/app.dart' as app;
import '../../../components/control/button/button.dart' as button;
import '../../../components/layout/card/card.dart' as card;
import '../../../components/overlay/alert_dialog/alert_dialog.dart' as dialog;

/// Type alias for `ShadcnUI` used by public or internal APIs.
typedef ShadcnUI = app.ShadcnUI;

/// Type alias for `AlertDialog` used by public or internal APIs.
typedef AlertDialog = dialog.AlertDialog;

/// Type alias for `PrimaryButton` used by public or internal APIs.
typedef PrimaryButton = button.PrimaryButton;

/// Type alias for `SecondaryButton` used by public or internal APIs.
typedef SecondaryButton = button.SecondaryButton;

/// Type alias for `TextButton` used by public or internal APIs.
typedef TextButton = button.TextButton;

/// Type alias for `ButtonDensity` used by public or internal APIs.
typedef ButtonDensity = button.ButtonDensity;

/// Type alias for `Card` used by public or internal APIs.
typedef Card = card.Card;

/// A practical page shell composite that wraps content in a centered card.
class MaterialPage extends StatelessWidget {
  /// Creates a `MaterialPage` instance.
  const MaterialPage({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.maxWidth = 720,
    this.padding = const EdgeInsets.all(24),
  });

  /// Stores `child` state/configuration for this implementation.
  final Widget child;

  /// Stores `header` state/configuration for this implementation.
  final Widget? header;

  /// Stores `footer` state/configuration for this implementation.
  final Widget? footer;

  /// Stores `maxWidth` state/configuration for this implementation.
  final double maxWidth;

  /// Stores `padding` state/configuration for this implementation.
  final EdgeInsetsGeometry padding;

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return app.Scaffold(
      headers: header == null ? const [] : [header!],
      footers: footer == null ? const [] : [footer!],
      child: Center(
        child: Padding(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Card(child: child),
          ),
        ),
      ),
    );
  }
}
