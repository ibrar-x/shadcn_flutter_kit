part of '../button.dart';

/// Implementation of [AbstractButtonStyle] providing concrete button style variants.
///
/// [ButtonVariance] implements [AbstractButtonStyle] with state property functions
/// and provides static constants for all standard button variants (primary, secondary,
/// outline, etc.). Each variant is wrapped in a [ComponentThemeButtonStyle] to enable
/// theme-level customization.
///
/// The static variance constants serve as the base styles used by [ButtonStyle]'s
/// named constructors and can be used directly when creating custom button styles.
///
/// Example:
/// ```dart
/// // Use a variant directly
/// Button(
///   style: ButtonVariance.primary,
///   child: Text('Click Me'),
/// )
/// ```
class ButtonVariance implements AbstractButtonStyle {
  /// Primary button variant with prominent filled appearance.
  ///
  /// Features high-contrast styling suitable for the main action on a screen.
  static const AbstractButtonStyle primary =
      ComponentThemeButtonStyle<PrimaryButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonPrimaryDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonPrimaryTextStyle,
      iconTheme: _buttonPrimaryIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Secondary button variant with muted appearance.
  ///
  /// Features subtle styling suitable for supporting or alternative actions.
  static const AbstractButtonStyle secondary =
      ComponentThemeButtonStyle<SecondaryButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonSecondaryDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonSecondaryTextStyle,
      iconTheme: _buttonSecondaryIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Outline button variant with border and transparent background.
  ///
  /// Features a visible border without filled background, suitable for secondary actions.
  static const AbstractButtonStyle outline =
      ComponentThemeButtonStyle<OutlineButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonOutlineDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonOutlineTextStyle,
      iconTheme: _buttonOutlineIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Ghost button variant with minimal visual presence.
  ///
  /// Features no background or border by default, only showing on hover.
  static const AbstractButtonStyle ghost =
      ComponentThemeButtonStyle<GhostButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonGhostDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonGhostTextStyle,
      iconTheme: _buttonGhostIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Link button variant resembling a text hyperlink.
  ///
  /// Features inline link styling with underline decoration.
  static const AbstractButtonStyle link =
      ComponentThemeButtonStyle<LinkButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonLinkDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonLinkTextStyle,
      iconTheme: _buttonLinkIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Text button variant with only text content.
  ///
  /// Features minimal styling with no background or border decoration.
  static const AbstractButtonStyle text =
      ComponentThemeButtonStyle<TextButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonTextTextStyle,
      iconTheme: _buttonTextIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Destructive button variant for delete/remove actions.
  ///
  /// Features warning colors (typically red) to indicate data-destructive actions.
  static const AbstractButtonStyle destructive =
      ComponentThemeButtonStyle<DestructiveButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonDestructiveDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonDestructiveTextStyle,
      iconTheme: _buttonDestructiveIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Fixed button variant with consistent dimensions.
  ///
  /// Features fixed sizing regardless of content, suitable for icon buttons.
  static const AbstractButtonStyle fixed =
      ComponentThemeButtonStyle<FixedButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonStaticTextStyle,
      iconTheme: _buttonStaticIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Menu button variant for dropdown menu triggers.
  ///
  /// Features appropriate spacing and styling for menu contexts.
  static const AbstractButtonStyle menu =
      ComponentThemeButtonStyle<MenuButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonMenuDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonMenuPadding,
      textStyle: _buttonMenuTextStyle,
      iconTheme: _buttonMenuIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Menubar button variant for horizontal menu bars.
  ///
  /// Features optimized padding and styling for menubar contexts.
  static const AbstractButtonStyle menubar =
      ComponentThemeButtonStyle<MenubarButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonMenuDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonMenubarPadding,
      textStyle: _buttonMenuTextStyle,
      iconTheme: _buttonMenuIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Muted button variant with subdued appearance.
  ///
  /// Features low-contrast styling for minimal visual impact.
  static const AbstractButtonStyle muted =
      ComponentThemeButtonStyle<MutedButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonMutedTextStyle,
      iconTheme: _buttonMutedIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  /// Card button variant with elevated appearance.
  ///
  /// Features subtle shadows and borders creating a card-like elevated look.
  static const AbstractButtonStyle card =
      ComponentThemeButtonStyle<CardButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonCardDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonCardPadding,
      textStyle: _buttonCardTextStyle,
      iconTheme: _buttonCardIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  @override
  final ButtonStateProperty<Decoration> decoration;
  @override
  final ButtonStateProperty<MouseCursor> mouseCursor;
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> padding;
  @override
  final ButtonStateProperty<TextStyle> textStyle;
  @override
  final ButtonStateProperty<IconThemeData> iconTheme;
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> margin;

  /// Creates a custom [ButtonVariance] with the specified style properties.
  ///
  /// All parameters are required [ButtonStateProperty] functions that resolve
  /// values based on the button's current state.
  const ButtonVariance({
    required this.decoration,
    required this.mouseCursor,
    required this.padding,
    required this.textStyle,
    required this.iconTheme,
    required this.margin,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ButtonVariance &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode {
    return Object.hash(
        decoration, mouseCursor, padding, textStyle, iconTheme, margin);
  }

  @override
  String toString() {
    return 'ButtonVariance(decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin)';
  }
}

/// A button state property delegate that always returns the same value.
///
/// [ButtonStylePropertyAll] implements a [ButtonStatePropertyDelegate] that
/// ignores the context, states, and default value parameters, always returning
/// its stored [value]. This is useful for creating static style properties that
/// don't change based on button state.
///
/// Example:
/// ```dart
/// final alwaysRedDecoration = ButtonStylePropertyAll<Decoration>(
///   BoxDecoration(color: Colors.red),
/// );
/// ```
class ButtonStylePropertyAll<T> {
  /// The constant value to return regardless of state.
  final T value;

  /// Creates a [ButtonStylePropertyAll] with the specified constant value.
  const ButtonStylePropertyAll(this.value);

  /// Returns the stored [value], ignoring all parameters.
  ///
  /// This method signature matches [ButtonStatePropertyDelegate] for compatibility,
  /// but the [context], [states], and [value] parameters are unused.
  T call(BuildContext context, Set<WidgetState> states, T value) {
    return this.value;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ButtonStylePropertyAll<T> && other.value == value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  String toString() => 'ButtonStylePropertyAll(value: $value)';
}

/// Extension methods on [AbstractButtonStyle] for convenient style modifications.
///
/// Provides utility methods to create modified copies of button styles with
/// selective property changes. These methods enable fluent style customization
/// without manually implementing [ButtonVariance] instances.
extension ButtonStyleExtension on AbstractButtonStyle {
  /// Creates a copy of this style with selectively replaced properties.
  ///
  /// Each parameter is a [ButtonStatePropertyDelegate] that can modify or
  /// replace the corresponding style property. If all parameters are `null`,
  /// returns the original style unchanged for efficiency.
  ///
  /// Example:
  /// ```dart
  /// final customStyle = ButtonVariance.primary.copyWith(
  ///   decoration: (context, states, defaultDecoration) {
  ///     // Custom decoration logic
  ///     return myCustomDecoration;
  ///   },
  /// );
  /// ```
  AbstractButtonStyle copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    if (decoration == null &&
        mouseCursor == null &&
        padding == null &&
        textStyle == null &&
        iconTheme == null &&
        margin == null) {
      return this;
    }
    return _CopyWithButtonStyle(
      this,
      decoration,
      mouseCursor,
      padding,
      textStyle,
      iconTheme,
      margin,
    );
  }

  /// Creates a copy with custom background colors for different states.
  ///
  /// Modifies the decoration to apply state-specific background colors.
  /// Only works with [BoxDecoration]; other decoration types are returned unchanged.
  ///
  /// Parameters:
  /// - [color]: Background color for normal state
  /// - [hoverColor]: Background color when hovered
  /// - [focusColor]: Background color when focused
  /// - [disabledColor]: Background color when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.primary.withBackgroundColor(
  ///   color: Colors.blue,
  ///   hoverColor: Colors.blue.shade700,
  /// );
  /// ```
  AbstractButtonStyle withBackgroundColor(
      {Color? color,
      Color? hoverColor,
      Color? focusColor,
      Color? disabledColor}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            color: states.disabled
                ? disabledColor ?? decoration.color
                : states.hovered
                    ? hoverColor ?? decoration.color
                    : states.focused
                        ? focusColor ?? decoration.color
                        : color,
          );
        }
        return decoration;
      },
    );
  }

  /// Creates a copy with custom foreground colors for different states.
  ///
  /// Modifies both text style and icon theme to apply state-specific foreground
  /// colors for text and icons.
  ///
  /// Parameters:
  /// - [color]: Foreground color for normal state
  /// - [hoverColor]: Foreground color when hovered
  /// - [focusColor]: Foreground color when focused
  /// - [disabledColor]: Foreground color when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.outline.withForegroundColor(
  ///   color: Colors.black,
  ///   disabledColor: Colors.grey,
  /// );
  /// ```
  AbstractButtonStyle withForegroundColor(
      {Color? color,
      Color? hoverColor,
      Color? focusColor,
      Color? disabledColor}) {
    return copyWith(
      textStyle: (context, states, textStyle) {
        return textStyle.copyWith(
          color: states.disabled
              ? disabledColor ?? textStyle.color
              : states.hovered
                  ? hoverColor ?? textStyle.color
                  : states.focused
                      ? focusColor ?? textStyle.color
                      : color,
        );
      },
      iconTheme: (context, states, iconTheme) {
        return iconTheme.copyWith(
          color: states.disabled
              ? disabledColor ?? iconTheme.color
              : states.hovered
                  ? hoverColor ?? iconTheme.color
                  : states.focused
                      ? focusColor ?? iconTheme.color
                      : color,
        );
      },
    );
  }

  /// Creates a copy with custom borders for different states.
  ///
  /// Modifies the decoration to apply state-specific borders.
  /// Only works with [BoxDecoration]; other decoration types are returned unchanged.
  ///
  /// Parameters:
  /// - [border]: Border for normal state
  /// - [hoverBorder]: Border when hovered
  /// - [focusBorder]: Border when focused
  /// - [disabledBorder]: Border when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.outline.withBorder(
  ///   border: Border.all(color: Colors.blue),
  ///   hoverBorder: Border.all(color: Colors.blue.shade700, width: 2),
  /// );
  /// ```
  AbstractButtonStyle withBorder(
      {Border? border,
      Border? hoverBorder,
      Border? focusBorder,
      Border? disabledBorder}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            border: states.disabled
                ? disabledBorder ?? decoration.border
                : states.hovered
                    ? hoverBorder ?? decoration.border
                    : states.focused
                        ? focusBorder ?? decoration.border
                        : border,
          );
        }
        return decoration;
      },
    );
  }

  /// Creates a copy with custom border radius for different states.
  ///
  /// Modifies the decoration to apply state-specific border radius.
  /// Only works with [BoxDecoration]; other decoration types are returned unchanged.
  ///
  /// Parameters:
  /// - [borderRadius]: Border radius for normal state
  /// - [hoverBorderRadius]: Border radius when hovered
  /// - [focusBorderRadius]: Border radius when focused
  /// - [disabledBorderRadius]: Border radius when disabled
  ///
  /// Example:
  /// ```dart
  /// final style = ButtonVariance.primary.withBorderRadius(
  ///   borderRadius: BorderRadius.circular(8),
  ///   hoverBorderRadius: BorderRadius.circular(12),
  /// );
  /// ```
  AbstractButtonStyle withBorderRadius(
      {BorderRadiusGeometry? borderRadius,
      BorderRadiusGeometry? hoverBorderRadius,
      BorderRadiusGeometry? focusBorderRadius,
      BorderRadiusGeometry? disabledBorderRadius}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            borderRadius: states.disabled
                ? disabledBorderRadius ?? decoration.borderRadius
                : states.hovered
                    ? hoverBorderRadius ?? decoration.borderRadius
                    : states.focused
                        ? focusBorderRadius ?? decoration.borderRadius
                        : borderRadius,
          );
        }
        return decoration;
      },
    );
  }

  /// Creates a copy with custom padding for different states.
  ///
  /// Modifies the padding to apply state-specific values.
  ///
  /// Parameters:
  /// - [padding]: Padding for normal state
  /// - [hoverPadding]: Padding when hovered
  /// - [focusPadding]: Padding when focused
  /// - [disabledPadding]: Padding when disabled
  ///
  /// Note: The implementation currently doesn't change padding based on state
  /// due to a limitation in the state resolution logic, but the API is provided
  /// for consistency with other style properties.
  AbstractButtonStyle withPadding(
      {EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? hoverPadding,
      EdgeInsetsGeometry? focusPadding,
      EdgeInsetsGeometry? disabledPadding}) {
    return copyWith(
      padding: (context, states, padding) {
        return states.disabled
            ? disabledPadding ?? padding
            : states.hovered
                ? hoverPadding ?? padding
                : states.focused
                    ? focusPadding ?? padding
                    : padding;
      },
    );
  }
}

/// Function signature for button state property delegates with default value.
///
/// [ButtonStatePropertyDelegate] extends [ButtonStateProperty] by adding a
/// `value` parameter representing the default or base value. This allows delegates
/// to modify existing values rather than always creating them from scratch.
///
/// The delegate receives:
/// - [context]: Build context for accessing theme data
/// - [states]: Current widget states
/// - [value]: The default value from the base style
///
/// Returns the final property value of type [T], which may be the default value,
/// a modified version of it, or a completely new value.
///
/// Example:
/// ```dart
/// ButtonStatePropertyDelegate<Color> customColor = (context, states, defaultColor) {
///   if (states.contains(WidgetState.disabled)) {
///     return defaultColor.withOpacity(0.5); // Modify default
///   }
///   return defaultColor; // Use default
/// };
/// ```
typedef ButtonStatePropertyDelegate<T> = T Function(
    BuildContext context, Set<WidgetState> states, T value);

class _CopyWithButtonStyle implements AbstractButtonStyle {
  final ButtonStatePropertyDelegate<Decoration>? _decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? _mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? _padding;
  final ButtonStatePropertyDelegate<TextStyle>? _textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? _iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? _margin;
  final AbstractButtonStyle _delegate;

  const _CopyWithButtonStyle(
    this._delegate,
    this._decoration,
    this._mouseCursor,
    this._padding,
    this._textStyle,
    this._iconTheme,
    this._margin,
  );

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (_iconTheme == null) {
      return _delegate.iconTheme;
    }
    return _buildIconTheme;
  }

  IconThemeData _buildIconTheme(BuildContext context, Set<WidgetState> states) {
    return _iconTheme!(context, states, _delegate.iconTheme(context, states));
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (_textStyle == null) {
      return _delegate.textStyle;
    }
    return _buildTextStyle;
  }

  TextStyle _buildTextStyle(BuildContext context, Set<WidgetState> states) {
    return _textStyle!(context, states, _delegate.textStyle(context, states));
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (_padding == null) {
      return _delegate.padding;
    }
    return _buildPadding;
  }

  EdgeInsetsGeometry _buildPadding(
      BuildContext context, Set<WidgetState> states) {
    return _padding!(context, states, _delegate.padding(context, states));
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    if (_mouseCursor == null) {
      return _delegate.mouseCursor;
    }
    return _buildMouseCursor;
  }

  MouseCursor _buildMouseCursor(BuildContext context, Set<WidgetState> states) {
    return _mouseCursor!(
        context, states, _delegate.mouseCursor(context, states));
  }

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (_decoration == null) {
      return _delegate.decoration;
    }
    return _buildDecoration;
  }

  Decoration _buildDecoration(BuildContext context, Set<WidgetState> states) {
    return _decoration!(context, states, _delegate.decoration(context, states));
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    if (_margin == null) {
      return _delegate.margin;
    }
    return _buildMargin;
  }

  EdgeInsetsGeometry _buildMargin(
      BuildContext context, Set<WidgetState> states) {
    return _margin!(context, states, _delegate.margin(context, states));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CopyWithButtonStyle &&
        other._delegate == _delegate &&
        other._decoration == _decoration &&
        other._mouseCursor == _mouseCursor &&
        other._padding == _padding &&
        other._textStyle == _textStyle &&
        other._iconTheme == _iconTheme &&
        other._margin == _margin;
  }

  @override
  int get hashCode {
    return Object.hash(_delegate, _decoration, _mouseCursor, _padding,
        _textStyle, _iconTheme, _margin);
  }

  @override
  String toString() {
    return '_CopyWithButtonStyle(_delegate: $_delegate, _decoration: $_decoration, _mouseCursor: $_mouseCursor, _padding: $_padding, _textStyle: $_textStyle, _iconTheme: $_iconTheme, _margin: $_margin)';
  }
}
