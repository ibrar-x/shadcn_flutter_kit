import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';

part '_impl/themes/toast_theme.dart';
part '_impl/core/toast_entry.dart';
part '_impl/utils/toast_controller.dart';
part '_impl/state/_toast_entry_state.dart';

/// Allowed gesture directions for swipe-to-dismiss toast behavior.
enum ToastSwipeDirection { up, down, left, right }
