import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart' as widgets;

export 'package:flutter/widgets.dart'
    hide Flexible, Expanded, Row, Column, Flex, Stack, Positioned;

export 'package:flutter/rendering.dart'
    show FlexFit, MainAxisSize, MainAxisAlignment, CrossAxisAlignment, VerticalDirection, StackFit;

export 'package:flutter/rendering.dart'
    show
        CrossAxisAlignment,
        FlexFit,
        MainAxisAlignment,
        MainAxisSize,
        StackFit,
        VerticalDirection;

part '_impl/core/flex_parent_data.dart';
part '_impl/core/flex_widget.dart';
part '_impl/core/flexible_widgets.dart';
part '_impl/core/paint_order_mixin.dart';
part '_impl/core/paint_order_parent_data_mixin.dart';
part '_impl/core/positioned_widget.dart';
part '_impl/core/render_flex.dart';
part '_impl/core/render_stack.dart';
part '_impl/core/stack_parent_data.dart';
part '_impl/core/stack_widget.dart';
