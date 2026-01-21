import 'package:flutter/widgets.dart';

import '../text_field/text_field.dart';
import '../../shared/theme/theme.dart';

part '_impl/text_area_state.dart';
part '_impl/text_area_handle.dart';

/// Multi-line text input with resizable dimensions.
class TextArea extends TextInputStatefulWidget {
  final bool expandableHeight;
  final bool expandableWidth;
  final double initialHeight;
  final double initialWidth;
  final ValueChanged<double>? onHeightChanged;
  final ValueChanged<double>? onWidthChanged;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

  const TextArea({
    super.key,
    super.groupId,
    super.controller,
    super.focusNode,
    super.decoration,
    super.padding,
    super.placeholder,
    super.crossAxisAlignment,
    super.clearButtonSemanticLabel,
    super.keyboardType,
    super.textInputAction,
    super.textCapitalization,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly,
    super.showCursor,
    super.autofocus,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onTapOutside,
    super.onTapUpOutside,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.keyboardAppearance,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.dragStartBehavior,
    super.scrollController,
    super.scrollPhysics,
    super.onTap,
    super.autofillHints,
    super.clipBehavior,
    super.restorationId,
    super.stylusHandwritingEnabled,
    super.enableIMEPersonalizedLearning,
    super.contentInsertionConfiguration,
    super.contextMenuBuilder,
    super.initialValue,
    super.hintText,
    super.border,
    super.borderRadius,
    super.filled,
    super.statesController,
    super.magnifierConfiguration,
    super.spellCheckConfiguration,
    super.undoController,
    super.features,
    super.submitFormatters,
    super.skipInputFeatureFocusTraversal,
    this.expandableHeight = false,
    this.expandableWidth = false,
    this.initialHeight = 100,
    this.initialWidth = double.infinity,
    this.onHeightChanged,
    this.onWidthChanged,
    this.minWidth = 100,
    this.minHeight = 100,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  });

  @override
  State<TextArea> createState() => _TextAreaState();
}
