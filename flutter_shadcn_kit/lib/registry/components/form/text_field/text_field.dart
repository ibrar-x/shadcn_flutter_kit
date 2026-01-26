import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:data_widget/data_widget.dart';
import 'package:flutter/cupertino.dart'
    show
        ConstrainedBox,
        CupertinoSpellCheckSuggestionsToolbar,
        cupertinoDesktopTextSelectionHandleControls;
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/foundation.dart'
    show IterableProperty, defaultTargetPlatform, listEquals;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../layout/card/card.dart';
import '../../control/button/button.dart';
import '../../../shared/icons/lucide_icons.dart';
import '../../../shared/primitives/form_value_supplier.dart';
import '../../../shared/primitives/focus_outline.dart';
import '../../../shared/primitives/hidden.dart';
import '../../../shared/primitives/overlay.dart';
import '../../../shared/primitives/clickable.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/border_utils.dart';
import '../../../shared/utils/chip_utils.dart';
import '../../../shared/utils/color_extensions.dart';
import '../../../shared/utils/constants.dart';
import '../../../shared/utils/style_value.dart';
import '../../../shared/utils/text_input_utils.dart';
import '../../../shared/utils/util.dart';

part '_impl/text_field_theme.dart';
part '_impl/input_feature_visibility.dart';
part '_impl/input_feature_base.dart';
part '_impl/text_field_gestures.dart';
part '_impl/text_input_mixin.dart';
part '_impl/text_input_stateful_widget.dart';
part '_impl/text_input_stateful_widget_cont.dart';
part '_impl/text_field_widget.dart';
part '_impl/text_field_state_part1.dart';
part '_impl/text_field_intents.dart';
part '_impl/input_features_basic.dart';
part '_impl/input_features_autocomplete.dart';
part '_impl/input_features_spinner.dart';
part '_impl/input_features_copy_paste.dart';
part '_impl/auto_complete_theme.dart';
part '_impl/auto_complete_widget.dart';

Widget buildEditableTextContextMenu(
  BuildContext context,
  EditableTextState editableTextState,
) {
  return material.AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState);
}
