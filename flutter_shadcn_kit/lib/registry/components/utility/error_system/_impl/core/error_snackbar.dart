import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/icons/radix_icons.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../overlay/toast/toast.dart';
import '../themes/error_system_theme.dart';
import 'app_error.dart';

class ErrorSnackbar {
  ErrorSnackbar._();

  static final List<OverlayEntry> _entries = [];

  static void show({
    required BuildContext context,
    required AppError error,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    final compTheme = ComponentTheme.maybeOf<ErrorSystemTheme>(context);
    final toastTheme = ComponentTheme.maybeOf<ToastTheme>(context);
    final resolvedDuration =
        duration ?? toastTheme?.duration ?? const Duration(seconds: 3);
    late final OverlayEntry entry;
    entry = OverlayEntry(builder: (overlayContext) {
      final padding = toastTheme?.padding ?? const EdgeInsets.all(16);
      final margin = toastTheme?.margin ?? 8.0;
      final totalOffset = _entries.length * margin;
      final backgroundColor = compTheme?.snackbarBackgroundColor ??
          toastTheme?.backgroundColor ??
          Theme.of(overlayContext).colorScheme.background;
      final resolvedRadius = compTheme?.snackbarBorderRadius
          ?.resolve(Directionality.of(overlayContext));
      final borderRadius = resolvedRadius ??
          (toastTheme?.borderRadius != null
              ? BorderRadius.circular(toastTheme!.borderRadius!)
              : BorderRadius.circular(12));
      return Positioned(
        top: 32 + totalOffset,
        right: 24,
        child: ToastEntry(
          duration: resolvedDuration,
          animationDuration:
              toastTheme?.animationDuration ?? const Duration(milliseconds: 250),
          animationCurve: toastTheme?.animationCurve ?? Curves.easeOut,
          onDismissed: () {
            entry.remove();
            _entries.remove(entry);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Container(
              padding: padding,
              width: toastTheme?.width,
              child: _ErrorSnackbarContent(error: error),
            ),
          ),
        ),
      );
    });
    _entries.add(entry);
    overlay.insert(entry);
  }
}

class _ErrorSnackbarContent extends StatelessWidget {
  const _ErrorSnackbarContent({required this.error});

  final AppError error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ErrorSystemTheme>(context);
    final textStyle = compTheme?.snackbarTextStyle ??
        theme.typography.xSmall.copyWith(color: theme.colorScheme.foreground);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          RadixIcons.exclamationTriangle,
          size: 16 * scaling,
          color: compTheme?.iconColor ?? theme.colorScheme.destructive,
        ),
        Gap(8 * scaling),
        Flexible(
          child: DefaultTextStyle.merge(
            style: textStyle,
            child: Text(error.message),
          ),
        ),
      ],
    );
  }
}
