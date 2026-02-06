import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import '../../../components/control/button/button.dart' as button;
import '../../../components/form/form/form.dart' as form;
import '../../../components/overlay/alert_dialog/alert_dialog.dart' as dialog;
import '../../../components/overlay/drawer/drawer.dart';
import '../../../shared/primitives/overlay.dart';

typedef AlertDialog = dialog.AlertDialog;
typedef PrimaryButton = button.PrimaryButton;
typedef TextButton = button.TextButton;
typedef Form = form.Form;
typedef FormController = form.FormController;
typedef FormField<T> = form.FormField<T>;
typedef FormTableLayout = form.FormTableLayout;
typedef FormErrorBuilder = form.FormErrorBuilder;

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
  return openSheet<T>(
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

Future<void> closeSheet(BuildContext context) {
  return closeSheet(context);
}
