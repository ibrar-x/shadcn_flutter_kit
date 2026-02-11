import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import '../../../components/control/button/button.dart' as button;
import '../../../components/form/form/form.dart' as form;
import '../../../components/overlay/alert_dialog/alert_dialog.dart' as dialog;
import '../../../components/overlay/drawer/drawer.dart' as drawer;

/// Type alias for `AlertDialog` used by public or internal APIs.
typedef AlertDialog = dialog.AlertDialog;

/// Type alias for `PrimaryButton` used by public or internal APIs.
typedef PrimaryButton = button.PrimaryButton;

/// Type alias for `TextButton` used by public or internal APIs.
typedef TextButton = button.TextButton;

/// Type alias for `Form` used by public or internal APIs.
typedef Form = form.Form;

/// Type alias for `FormController` used by public or internal APIs.
typedef FormController = form.FormController;

/// Type alias for `FormField` used by public or internal APIs.
typedef FormField<T> = form.FormField<T>;

/// Type alias for `FormTableLayout` used by public or internal APIs.
typedef FormTableLayout = form.FormTableLayout;

/// Type alias for `FormErrorBuilder` used by public or internal APIs.
typedef FormErrorBuilder = form.FormErrorBuilder;

/// Type alias for `OverlayPosition` used by public or internal APIs.
typedef OverlayPosition = drawer.OverlayPosition;

Future<T?> openSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required OverlayPosition position,
  bool barrierDismissible = true,
  bool transformBackdrop = false,
  Color? barrierColor,
  bool draggable = false,
  AnimationController? animationController,
  WidgetBuilder? backdropBuilder,
  BoxConstraints? constraints,
  AlignmentGeometry? alignment,
}) {
  return drawer.openSheet<T>(
    context: context,
    builder: builder,
    position: position,
    barrierDismissible: barrierDismissible,
    transformBackdrop: transformBackdrop,
    barrierColor: barrierColor,
    draggable: draggable,
    animationController: animationController,
    backdropBuilder: backdropBuilder,
    constraints: constraints,
    alignment: alignment,
  );
}

/// Executes `closeSheet` behavior for this component/composite.
Future<void> closeSheet(BuildContext context) {
  return drawer.closeSheet(context);
}

/// A simple composable layout for sheet content.
class SheetLayout extends StatelessWidget {
  /// Creates a `SheetLayout` instance.
  const SheetLayout({
    super.key,
    this.header,
    required this.child,
    this.footer,
    this.padding = const EdgeInsets.all(16),
    this.gap = 12,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// Stores `header` state/configuration for this implementation.
  final Widget? header;

  /// Stores `child` state/configuration for this implementation.
  final Widget child;

  /// Stores `footer` state/configuration for this implementation.
  final Widget? footer;

  /// Stores `padding` state/configuration for this implementation.
  final EdgeInsetsGeometry padding;

  /// Stores `gap` state/configuration for this implementation.
  final double gap;

  /// Stores `mainAxisSize` state/configuration for this implementation.
  final MainAxisSize mainAxisSize;

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) ...[header!, SizedBox(height: gap)],
          child,
          if (footer != null) ...[SizedBox(height: gap), footer!],
        ],
      ),
    );
  }
}
