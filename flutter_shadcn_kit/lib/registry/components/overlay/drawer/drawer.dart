import 'dart:async';
import 'dart:math';

import 'package:data_widget/data_widget.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../dialog/dialog.dart';
import '../../../shared/primitives/outlined_container.dart';
import '../../../shared/primitives/overlay.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/controlled_animation.dart';
import '../../../shared/utils/util.dart';

part '_impl/drawer_types.dart';
part '_impl/drawer_theme.dart';
part '_impl/drawer_api.dart';
part '_impl/drawer_wrapper.dart';
part '_impl/drawer_wrapper_state_part1.dart';
part '_impl/drawer_close_sheet.dart';
part '_impl/sheet_wrapper.dart';
part '_impl/overlay_position.dart';
part '_impl/backdrop_transform_data.dart';
part '_impl/drawer_overlay_wrapper.dart';
part '_impl/drawer_raw_api.dart';
part '_impl/mounted_overlay_entry_data.dart';
part '_impl/drawer_close_drawer.dart';
part '_impl/drawer_layer_data.dart';
part '_impl/drawer_overlay.dart';
part '_impl/drawer_entry_widget.dart';
part '_impl/drawer_entry_widget_state.dart';
part '_impl/drawer_typedefs.dart';
part '_impl/drawer_overlay_entry.dart';
part '_impl/drawer_overlay_completer.dart';
part '_impl/sheet_overlay_handler.dart';
