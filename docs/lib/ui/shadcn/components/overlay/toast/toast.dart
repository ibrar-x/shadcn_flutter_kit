import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';

part '_impl/themes/toast_theme.dart';
part '_impl/core/toast_entry.dart';
part '_impl/utils/toast_controller.dart';
part '_impl/state/_toast_entry_state.dart';

enum ToastLocation {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class ToastOverlay {
  final VoidCallback close;

  const ToastOverlay(this.close);
}

final Map<ToastLocation, List<OverlayEntry>> _toastEntriesByLocation = {
  for (final location in ToastLocation.values) location: <OverlayEntry>[],
};

void showToast({
  required BuildContext context,
  required Widget Function(BuildContext context, ToastOverlay overlay) builder,
  ToastLocation location = ToastLocation.topRight,
  Duration duration = const Duration(seconds: 3),
  double spacing = 8,
}) {
  final overlay = Overlay.of(context);

  final entries = _toastEntriesByLocation[location]!;
  late final OverlayEntry entry;
  late final ToastOverlay overlayHandle;

  entry = OverlayEntry(builder: (overlayContext) {
    final toastTheme = ComponentTheme.maybeOf<ToastTheme>(overlayContext);
    final padding = toastTheme?.padding ?? const EdgeInsets.all(16);
    final resolvedSpacing = toastTheme?.margin ?? spacing;
    final totalOffset = entries.indexOf(entry) * resolvedSpacing;
    final isTop = switch (location) {
      ToastLocation.topLeft ||
      ToastLocation.topCenter ||
      ToastLocation.topRight =>
        true,
      _ => false,
    };
    final isCenter = switch (location) {
      ToastLocation.topCenter || ToastLocation.bottomCenter => true,
      _ => false,
    };
    final isLeft = switch (location) {
      ToastLocation.topLeft || ToastLocation.bottomLeft => true,
      _ => false,
    };

    return Positioned(
      top: isTop ? 32 + totalOffset : null,
      bottom: isTop ? null : 32 + totalOffset,
      left: isCenter ? 0 : (isLeft ? 24 : null),
      right: isCenter ? 0 : (isLeft ? null : 24),
      child: Align(
        alignment: isCenter
            ? (isTop ? Alignment.topCenter : Alignment.bottomCenter)
            : Alignment.topLeft,
        child: ToastEntry(
          duration: duration,
          animationDuration:
              toastTheme?.animationDuration ?? const Duration(milliseconds: 250),
          animationCurve: toastTheme?.animationCurve ?? Curves.easeOut,
          onDismissed: () {
            entry.remove();
            entries.remove(entry);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: toastTheme?.backgroundColor ?? Colors.black87,
              borderRadius:
                  BorderRadius.circular(toastTheme?.borderRadius ?? 12.0),
            ),
            child: Container(
              padding: padding,
              width: toastTheme?.width,
              child: builder(overlayContext, overlayHandle),
            ),
          ),
        ),
      ),
    );
  });

  overlayHandle = ToastOverlay(() {
    entry.remove();
    entries.remove(entry);
  });

  entries.add(entry);
  overlay.insert(entry);
}
