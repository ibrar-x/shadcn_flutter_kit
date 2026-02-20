import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';

part '_impl/themes/base/toast_theme.dart';
part '_impl/core/toast_entry.dart';
part '_impl/utils/toast_controller.dart';
part '_impl/state/_toast_entry_state.dart';

/// Allowed gesture directions for swipe-to-dismiss toast behavior.
enum ToastSwipeDirection { up, down, left, right }

/// Shared stack context for grouped toast overlays.
class ToastStackContext {
  const ToastStackContext({
    required this.expanded,
    required this.itemExpanded,
    required this.hasMultiple,
    required this.visibleCount,
    required this.isPrimary,
    required this.toggleExpanded,
    required this.setExpanded,
    required this.dismissAll,
  });

  final bool expanded;
  final bool itemExpanded;
  final bool hasMultiple;
  final int visibleCount;
  final bool isPrimary;
  final VoidCallback toggleExpanded;
  final ValueChanged<bool> setExpanded;
  final VoidCallback dismissAll;
}

/// Inherited scope that exposes stack interaction state to toast content.
class ToastStackScope extends InheritedWidget {
  const ToastStackScope({super.key, required this.data, required super.child});

  final ToastStackContext data;

  static ToastStackContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ToastStackScope>()?.data;
  }

  @override
  bool updateShouldNotify(covariant ToastStackScope oldWidget) {
    return oldWidget.data.expanded != data.expanded ||
        oldWidget.data.itemExpanded != data.itemExpanded ||
        oldWidget.data.hasMultiple != data.hasMultiple ||
        oldWidget.data.visibleCount != data.visibleCount ||
        oldWidget.data.isPrimary != data.isPrimary;
  }
}
