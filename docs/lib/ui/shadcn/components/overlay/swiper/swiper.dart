import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';
import '../drawer/drawer.dart';

part '_impl/themes/swiper_theme.dart';
part '_impl/utils/swiper_handler.dart';
part '_impl/utils/drawer_swiper_handler.dart';
part '_impl/utils/sheet_swiper_handler.dart';
part '_impl/core/swiper_widget.dart';
part '_impl/state/_swiper_state.dart';

/// Theme configuration for swiper overlay behavior and appearance.
///
/// Defines default properties for swiper components including overlay
/// behavior, drag interaction, surface effects, and visual styling.
///
/// Features:
/// - Configurable drag and expansion behavior
/// - Surface effects and backdrop styling
/// - Barrier and interaction customization
/// - Consistent theming across swiper variants
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     SwiperTheme: SwiperTheme(
///       expands: true,
///       draggable: true,
///       barrierDismissible: true,
///       transformBackdrop: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
