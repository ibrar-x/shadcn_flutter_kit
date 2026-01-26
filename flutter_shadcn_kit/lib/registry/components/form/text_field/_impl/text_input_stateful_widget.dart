part of '../text_field.dart';

abstract class TextInputStatefulWidget extends StatefulWidget with TextInput {
  @override
  final Object groupId;
  @override
  final TextEditingController? controller;
  @override
  final FocusNode? focusNode;
  @override
  final BoxDecoration? decoration;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final Widget? placeholder;
  @override
  final CrossAxisAlignment crossAxisAlignment;
  @override
  final String? clearButtonSemanticLabel;
  @override
  final TextInputType? keyboardType;
  @override
  final TextInputAction? textInputAction;
  @override
  final TextCapitalization textCapitalization;
  @override
  final TextStyle? style;
  @override
  final StrutStyle? strutStyle;
  @override
  final TextAlign textAlign;
  @override
  final TextAlignVertical? textAlignVertical;
  @override
  final TextDirection? textDirection;
  @override
  final bool readOnly;
  @override
  final bool? showCursor;
  @override
  final bool autofocus;
  @override
  final String obscuringCharacter;
  @override
  final bool obscureText;
  @override
  final bool autocorrect;
  @override
  final SmartDashesType smartDashesType;
  @override
  final SmartQuotesType smartQuotesType;
  @override
  final bool enableSuggestions;
  @override
  final int? maxLines;
  @override
  final int? minLines;
  @override
  final bool expands;
  @override
  final int? maxLength;
  @override
  final MaxLengthEnforcement? maxLengthEnforcement;
  @override
  final ValueChanged<String>? onChanged;
  @override
  final VoidCallback? onEditingComplete;
  @override
  final ValueChanged<String>? onSubmitted;
  @override
  final TapRegionCallback? onTapOutside;
  @override
  final TapRegionCallback? onTapUpOutside;
  @override
  final List<TextInputFormatter>? inputFormatters;
  @override
  final bool enabled;
  @override
  final double cursorWidth;
  @override
  final double? cursorHeight;
  @override
  final Radius cursorRadius;
  @override
  final bool cursorOpacityAnimates;
  @override
  final Color? cursorColor;
  @override
  final ui.BoxHeightStyle selectionHeightStyle;
  @override
  final ui.BoxWidthStyle selectionWidthStyle;
  @override
  final Brightness? keyboardAppearance;
  @override
  final EdgeInsets scrollPadding;
  @override
  final bool enableInteractiveSelection;
  @override
  final TextSelectionControls? selectionControls;
  @override
  final DragStartBehavior dragStartBehavior;
  @override
  final ScrollController? scrollController;
  @override
  final ScrollPhysics? scrollPhysics;
  @override
  final GestureTapCallback? onTap;
  @override
  final Iterable<String>? autofillHints;
  @override
  final Clip clipBehavior;
  @override
  final String? restorationId;
  @override
  final bool stylusHandwritingEnabled;
  @override
  final bool enableIMEPersonalizedLearning;
  @override
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  @override
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  @override
  final String? initialValue;
  @override
  final String? hintText;
  @override
  final Border? border;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final bool? filled;
  @override
  final WidgetStatesController? statesController;
  @override
  final TextMagnifierConfiguration? magnifierConfiguration;
  @override
  final SpellCheckConfiguration? spellCheckConfiguration;
  @override
  final UndoHistoryController? undoController;
  @override
  final List<InputFeature> features;
  @override
  final List<TextInputFormatter>? submitFormatters;
  @override
  final bool skipInputFeatureFocusTraversal;

  /// Creates a stateful text input widget with comprehensive configuration options.
  ///
  /// This constructor accepts all properties defined in the [TextInput] mixin,
  /// providing extensive control over text input behavior, appearance, and interactions.
  ///
  /// Most parameters mirror Flutter's [EditableText] widget while adding custom
  /// features like input features, decorations, and form integration.
  ///
  /// Key parameters include:
  /// - [controller]: Text editing controller, created automatically if null
  /// - [focusNode]: Focus node for keyboard interaction
  /// - [decoration]: Box decoration for the input container
  /// - [padding]: Inner padding around the text field
  /// - [placeholder]: Widget shown when field is empty
  /// - [enabled]: Whether input accepts user interaction, defaults to true
  /// - [readOnly]: Whether text can be edited, defaults to false
  /// - [obscureText]: Whether to hide input (for passwords), defaults to false
  /// - [maxLines]: Maximum number of lines, defaults to 1
  /// - [features]: List of input features (e.g., clear button, character count)
  ///
  /// See [TextInput] mixin documentation for full parameter details.
  const TextInputStatefulWidget({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.decoration,
    this.padding,
    this.placeholder,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.clearButtonSemanticLabel,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType = SmartDashesType.enabled,
    this.smartQuotesType = SmartQuotesType.enabled,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutside,
    this.onTapUpOutside,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(2.0),
    this.cursorOpacityAnimates = true,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.onTap,
    this.autofillHints = const [],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.enableIMEPersonalizedLearning = true,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
    this.initialValue,
    this.hintText,
    this.border,
    this.borderRadius,
    this.filled,
    this.statesController,
    this.magnifierConfiguration,
    this.spellCheckConfiguration,
    this.undoController,
    this.features = const [],
    this.submitFormatters = const [],
    this.skipInputFeatureFocusTraversal = false,
  });

  /// Creates a copy of this text field with the given properties replaced.
  ///
  /// All parameters are optional and allow selective property replacement.
  TextField copyWith({
    ValueGetter<Key?>? key,
    ValueGetter<Object>? groupId,
    ValueGetter<TextEditingController?>? controller,
    ValueGetter<String?>? initialValue,
    ValueGetter<FocusNode?>? focusNode,
    ValueGetter<UndoHistoryController?>? undoController,
    ValueGetter<BoxDecoration?>? decoration,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Widget?>? placeholder,
    ValueGetter<CrossAxisAlignment>? crossAxisAlignment,
    ValueGetter<String?>? clearButtonSemanticLabel,
    ValueGetter<TextInputType?>? keyboardType,
    ValueGetter<TextInputAction?>? textInputAction,
    ValueGetter<TextCapitalization>? textCapitalization,
    ValueGetter<TextStyle?>? style,
    ValueGetter<StrutStyle?>? strutStyle,
    ValueGetter<TextAlign>? textAlign,
    ValueGetter<TextAlignVertical?>? textAlignVertical,
    ValueGetter<TextDirection?>? textDirection,
    ValueGetter<bool>? readOnly,
    ValueGetter<bool?>? showCursor,
    ValueGetter<bool>? autofocus,
    ValueGetter<String>? obscuringCharacter,
    ValueGetter<bool>? obscureText,
    ValueGetter<bool>? autocorrect,
    ValueGetter<SmartDashesType>? smartDashesType,
    ValueGetter<SmartQuotesType>? smartQuotesType,
    ValueGetter<bool>? enableSuggestions,
    ValueGetter<int?>? maxLines,
    ValueGetter<int?>? minLines,
    ValueGetter<bool>? expands,
    ValueGetter<int?>? maxLength,
    ValueGetter<MaxLengthEnforcement?>? maxLengthEnforcement,
    ValueGetter<ValueChanged<String>?>? onChanged,
    ValueGetter<VoidCallback?>? onEditingComplete,
    ValueGetter<ValueChanged<String>?>? onSubmitted,
    ValueGetter<TapRegionCallback?>? onTapOutside,
    ValueGetter<TapRegionCallback?>? onTapUpOutside,
    ValueGetter<List<TextInputFormatter>?>? inputFormatters,
    ValueGetter<bool>? enabled,
    ValueGetter<double>? cursorWidth,
    ValueGetter<double?>? cursorHeight,
    ValueGetter<Radius>? cursorRadius,
    ValueGetter<bool>? cursorOpacityAnimates,
    ValueGetter<Color?>? cursorColor,
    ValueGetter<ui.BoxHeightStyle>? selectionHeightStyle,
    ValueGetter<ui.BoxWidthStyle>? selectionWidthStyle,
    ValueGetter<Brightness?>? keyboardAppearance,
    ValueGetter<EdgeInsets>? scrollPadding,
    ValueGetter<bool>? enableInteractiveSelection,
    ValueGetter<TextSelectionControls?>? selectionControls,
    ValueGetter<DragStartBehavior>? dragStartBehavior,
    ValueGetter<ScrollController?>? scrollController,
    ValueGetter<ScrollPhysics?>? scrollPhysics,
    ValueGetter<GestureTapCallback?>? onTap,
    ValueGetter<Iterable<String>?>? autofillHints,
    ValueGetter<Clip>? clipBehavior,
    ValueGetter<String?>? restorationId,
    ValueGetter<bool>? stylusHandwritingEnabled,
    ValueGetter<bool>? enableIMEPersonalizedLearning,
    ValueGetter<ContentInsertionConfiguration?>? contentInsertionConfiguration,
    ValueGetter<EditableTextContextMenuBuilder?>? contextMenuBuilder,
    ValueGetter<String?>? hintText,
    ValueGetter<Border?>? border,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<bool?>? filled,
    ValueGetter<WidgetStatesController?>? statesController,
    ValueGetter<TextMagnifierConfiguration?>? magnifierConfiguration,
    ValueGetter<SpellCheckConfiguration?>? spellCheckConfiguration,
    ValueGetter<List<InputFeature>>? features,
    ValueGetter<List<TextInputFormatter>?>? submitFormatters,
    ValueGetter<bool>? skipInputFeatureFocusTraversal,
  }) {
    return TextField(
      key: key == null ? this.key : key(),
      groupId: groupId == null ? this.groupId : groupId(),
      controller: controller == null ? this.controller : controller(),
      initialValue: initialValue == null ? this.initialValue : initialValue(),
      focusNode: focusNode == null ? this.focusNode : focusNode(),
      undoController:
          undoController == null ? this.undoController : undoController(),
      decoration: decoration == null ? this.decoration : decoration(),
      padding: padding == null ? this.padding : padding(),
      placeholder: placeholder == null ? this.placeholder : placeholder(),
      crossAxisAlignment: crossAxisAlignment == null
          ? this.crossAxisAlignment
          : crossAxisAlignment(),
      clearButtonSemanticLabel: clearButtonSemanticLabel == null
          ? this.clearButtonSemanticLabel
          : clearButtonSemanticLabel(),
      keyboardType: keyboardType == null ? this.keyboardType : keyboardType(),
      textInputAction:
          textInputAction == null ? this.textInputAction : textInputAction(),
      textCapitalization: textCapitalization == null
          ? this.textCapitalization
          : textCapitalization(),
      style: style == null ? this.style : style(),
      strutStyle: strutStyle == null ? this.strutStyle : strutStyle(),
      textAlign: textAlign == null ? this.textAlign : textAlign(),
      textAlignVertical: textAlignVertical == null
          ? this.textAlignVertical
          : textAlignVertical(),
      textDirection:
          textDirection == null ? this.textDirection : textDirection(),
      readOnly: readOnly == null ? this.readOnly : readOnly(),
      showCursor: showCursor == null ? this.showCursor : showCursor(),
      autofocus: autofocus == null ? this.autofocus : autofocus(),
      obscuringCharacter: obscuringCharacter == null
          ? this.obscuringCharacter
          : obscuringCharacter(),
      obscureText: obscureText == null ? this.obscureText : obscureText(),
      autocorrect: autocorrect == null ? this.autocorrect : autocorrect(),
      smartDashesType:
          smartDashesType == null ? this.smartDashesType : smartDashesType(),
      smartQuotesType:
          smartQuotesType == null ? this.smartQuotesType : smartQuotesType(),
      enableSuggestions: enableSuggestions == null
          ? this.enableSuggestions
          : enableSuggestions(),
      maxLines: maxLines == null ? this.maxLines : maxLines(),
      minLines: minLines == null ? this.minLines : minLines(),
      expands: expands == null ? this.expands : expands(),
      maxLength: maxLength == null ? this.maxLength : maxLength(),
      maxLengthEnforcement: maxLengthEnforcement == null
          ? this.maxLengthEnforcement
          : maxLengthEnforcement(),
      onChanged: onChanged == null ? this.onChanged : onChanged(),
      onEditingComplete: onEditingComplete == null
          ? this.onEditingComplete
          : onEditingComplete(),
      onSubmitted: onSubmitted == null ? this.onSubmitted : onSubmitted(),
      onTapOutside: onTapOutside == null ? this.onTapOutside : onTapOutside(),
      onTapUpOutside:
          onTapUpOutside == null ? this.onTapUpOutside : onTapUpOutside(),
      inputFormatters:
          inputFormatters == null ? this.inputFormatters : inputFormatters(),
      enabled: enabled == null ? this.enabled : enabled(),
      cursorWidth: cursorWidth == null ? this.cursorWidth : cursorWidth(),
      cursorHeight: cursorHeight == null ? this.cursorHeight : cursorHeight(),
      cursorRadius: cursorRadius == null ? this.cursorRadius : cursorRadius(),
      cursorOpacityAnimates: cursorOpacityAnimates == null
          ? this.cursorOpacityAnimates
          : cursorOpacityAnimates(),
      cursorColor: cursorColor == null ? this.cursorColor : cursorColor(),
      selectionHeightStyle: selectionHeightStyle == null
          ? this.selectionHeightStyle
          : selectionHeightStyle(),
      selectionWidthStyle: selectionWidthStyle == null
          ? this.selectionWidthStyle
          : selectionWidthStyle(),
      keyboardAppearance: keyboardAppearance == null
          ? this.keyboardAppearance
          : keyboardAppearance(),
      scrollPadding:
          scrollPadding == null ? this.scrollPadding : scrollPadding(),
      enableInteractiveSelection: enableInteractiveSelection == null
          ? this.enableInteractiveSelection
          : enableInteractiveSelection(),
      selectionControls: selectionControls == null
          ? this.selectionControls
          : selectionControls(),
      dragStartBehavior: dragStartBehavior == null
          ? this.dragStartBehavior
          : dragStartBehavior(),
      scrollController:
          scrollController == null ? this.scrollController : scrollController(),
      scrollPhysics:
          scrollPhysics == null ? this.scrollPhysics : scrollPhysics(),
      onTap: onTap == null ? this.onTap : onTap(),
      autofillHints:
          autofillHints == null ? this.autofillHints : autofillHints(),
      clipBehavior: clipBehavior == null ? this.clipBehavior : clipBehavior(),
      restorationId:
          restorationId == null ? this.restorationId : restorationId(),
      stylusHandwritingEnabled: stylusHandwritingEnabled == null
          ? this.stylusHandwritingEnabled
          : stylusHandwritingEnabled(),
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning == null
          ? this.enableIMEPersonalizedLearning
          : enableIMEPersonalizedLearning(),
      contentInsertionConfiguration: contentInsertionConfiguration == null
          ? this.contentInsertionConfiguration
          : contentInsertionConfiguration(),
      contextMenuBuilder: contextMenuBuilder == null
          ? this.contextMenuBuilder
          : contextMenuBuilder(),
      hintText: hintText == null ? this.hintText : hintText(),
      border: border == null ? this.border : border(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      filled: filled == null ? this.filled : filled(),
      statesController:
          statesController == null ? this.statesController : statesController(),
      magnifierConfiguration: magnifierConfiguration == null
          ? this.magnifierConfiguration
          : magnifierConfiguration(),
      spellCheckConfiguration: spellCheckConfiguration == null
          ? this.spellCheckConfiguration
          : spellCheckConfiguration(),
      features: features == null ? this.features : features(),
      submitFormatters:
          submitFormatters == null ? this.submitFormatters : submitFormatters(),
      skipInputFeatureFocusTraversal: skipInputFeatureFocusTraversal == null
          ? this.skipInputFeatureFocusTraversal
          : skipInputFeatureFocusTraversal(),
    );
  }
}

/// A highly customizable single-line text input widget with extensive feature support.
///
/// [TextField] provides a comprehensive text editing experience with support for
/// a wide range of input types, validation, formatting, and interactive features.
/// It serves as the foundation for most text input scenarios in the shadcn_flutter
/// design system, offering both basic text input and advanced capabilities through
/// its feature system.
///
/// Key features:
/// - Comprehensive text input with platform-native behavior
/// - Extensive customization through [InputFeature] system
/// - Built-in support for validation and formatting
/// - Configurable appearance with theming support
/// - Context menu customization and clipboard operations
/// - Keyboard shortcuts and accessibility support
/// - Form integration with automatic value management
///
/// The widget supports various input modes:
/// - Single-line text input (default)
/// - Obscured text for passwords
/// - Formatted input with custom formatters
/// - Auto-completion and suggestions
/// - Numeric input with spinners
///
/// Input features can be added to enhance functionality:
/// - Clear button for easy text clearing
/// - Password visibility toggle
/// - Copy/paste operations
/// - Auto-complete suggestions
/// - Validation indicators
/// - Custom leading/trailing widgets
///
/// Example:
/// ```dart
/// TextField(
///   hintText: 'Enter your email',
///   keyboardType: TextInputType.emailAddress,
///   features: [
///     InputClearFeature(),
///     InputRevalidateFeature(),
///   ],
///   onChanged: (text) => _handleTextChange(text),
/// );
/// ```
