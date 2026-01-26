part of '../button.dart';

abstract class ButtonTheme extends ComponentThemeData {
  /// Optional decoration override (background, border, shadows).
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Optional mouse cursor override.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Optional padding override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Optional text style override.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Optional icon theme override.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Optional margin override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// Creates a [ButtonTheme] with optional style property delegates.
  ///
  /// All parameters are optional, allowing selective override of specific
  /// style properties while leaving others to use default values.
  const ButtonTheme(
      {this.decoration,
      this.mouseCursor,
      this.padding,
      this.textStyle,
      this.iconTheme,
      this.margin});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ButtonTheme &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode => Object.hash(
      decoration, mouseCursor, padding, textStyle, iconTheme, margin);

  @override
  String toString() =>
      '$runtimeType{decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin}';
}

/// Theme-aware button style that integrates with the component theme system.
///
/// [ComponentThemeButtonStyle] implements [AbstractButtonStyle] and provides
/// automatic theme integration by looking up theme overrides from the widget tree's
/// [ComponentTheme]. If a theme override is found, it's applied; otherwise, the
/// fallback style is used.
///
/// This enables global button style customization through the theme system while
/// maintaining type-safe access to specific button theme types.
///
/// Example:
/// ```dart
/// const ComponentThemeButtonStyle<PrimaryButtonTheme>(
///   fallback: ButtonVariance.primary,
/// )
/// ```
class ComponentThemeButtonStyle<T extends ButtonTheme>
    implements AbstractButtonStyle {
  /// The fallback style used when no theme override is found.
  final AbstractButtonStyle fallback;

  /// Creates a [ComponentThemeButtonStyle] with the specified fallback style.
  ///
  /// Parameters:
  /// - [fallback] (required): The default style used when theme override is not available.
  const ComponentThemeButtonStyle({required this.fallback});

  /// Looks up the button theme of type [T] from the component theme.
  ///
  /// Returns the theme instance if found in the widget tree, or `null` if not present.
  T? find(BuildContext context) {
    return ComponentTheme.maybeOf<T>(context);
  }

  @override
  ButtonStateProperty<Decoration> get decoration => _resolveDecoration;

  Decoration _resolveDecoration(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.decoration(context, states);
    return find(context)?.decoration?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme => _resolveIconTheme;

  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.iconTheme(context, states);
    return find(context)?.iconTheme?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin => _resolveMargin;

  EdgeInsetsGeometry _resolveMargin(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.margin(context, states);
    return find(context)?.margin?.call(context, states, resolved) ?? resolved;
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor => _resolveMouseCursor;

  MouseCursor _resolveMouseCursor(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.mouseCursor(context, states);
    return find(context)?.mouseCursor?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding => _resolvePadding;

  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.padding(context, states);
    return find(context)?.padding?.call(context, states, resolved) ?? resolved;
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle => _resolveTextStyle;

  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.textStyle(context, states);
    return find(context)?.textStyle?.call(context, states, resolved) ??
        resolved;
  }
}

/// Extension methods for [ShapeDecoration] providing copyWith functionality.
///
/// Adds a `copyWith` method to [ShapeDecoration] for creating modified copies
/// with selectively updated properties, similar to the pattern used in Flutter
/// for other decoration types.
extension ShapeDecorationExtension on ShapeDecoration {
  /// Creates a copy of this [ShapeDecoration] with specified properties replaced.
  ///
  /// Parameters:
  /// - [shape]: Replacement shape border
  /// - [color]: Replacement fill color
  /// - [gradient]: Replacement gradient
  /// - [shadows]: Replacement shadow list
  /// - [image]: Replacement decoration image
  ///
  /// Returns a new [ShapeDecoration] with the specified properties updated
  /// and all other properties copied from the original.
  ShapeDecoration copyWith({
    ShapeBorder? shape,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
  }) {
    return ShapeDecoration(
      color: color ?? this.color,
      image: image ?? this.image,
      shape: shape ?? this.shape,
      gradient: gradient ?? this.gradient,
      shadows: shadows ?? this.shadows,
    );
  }
}

/// Extension methods for [Decoration] providing type-safe copyWith operations.
///
/// Adds convenience methods to [Decoration] for creating modified copies when
/// the decoration is either a [BoxDecoration] or [ShapeDecoration]. These methods
/// handle type checking and provide appropriate defaults when the decoration
/// doesn't match the expected type.
extension DecorationExtension on Decoration {
  /// Creates a [BoxDecoration] copy with specified properties replaced.
  ///
  /// If this decoration is a [BoxDecoration], creates a modified copy.
  /// Otherwise, creates a new [BoxDecoration] with the provided properties.
  ///
  /// Parameters:
  /// - [color]: Replacement or new background color
  /// - [image]: Replacement or new decoration image
  /// - [border]: Replacement or new border
  /// - [borderRadius]: Replacement or new border radius
  /// - [boxShadow]: Replacement or new shadow list
  /// - [gradient]: Replacement or new gradient
  /// - [shape]: Replacement or new box shape
  /// - [backgroundBlendMode]: Replacement or new blend mode
  ///
  /// Returns a [BoxDecoration] with the specified properties.
  BoxDecoration copyWithIfBoxDecoration({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BoxShape? shape,
    BlendMode? backgroundBlendMode,
  }) {
    if (this is BoxDecoration) {
      var boxDecoration = this as BoxDecoration;
      return BoxDecoration(
        color: color ?? boxDecoration.color,
        image: image ?? boxDecoration.image,
        border: border ?? boxDecoration.border,
        borderRadius: borderRadius ?? boxDecoration.borderRadius,
        boxShadow: boxShadow ?? boxDecoration.boxShadow,
        gradient: gradient ?? boxDecoration.gradient,
        shape: shape ?? boxDecoration.shape,
        backgroundBlendMode:
            backgroundBlendMode ?? boxDecoration.backgroundBlendMode,
      );
    }
    return BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
      shape: shape ?? BoxShape.rectangle,
      backgroundBlendMode: backgroundBlendMode,
    );
  }

  /// Creates a [ShapeDecoration] copy with specified properties replaced.
  ///
  /// If this decoration is a [ShapeDecoration], creates a modified copy.
  /// Otherwise, creates a new [ShapeDecoration] with the provided properties.
  ///
  /// Parameters:
  /// - [shape]: Replacement or new shape border
  /// - [color]: Replacement or new fill color
  /// - [gradient]: Replacement or new gradient
  /// - [shadows]: Replacement or new shadow list
  /// - [image]: Replacement or new decoration image
  ///
  /// Returns a [ShapeDecoration] with the specified properties.
  ShapeDecoration copyWithIfShapeDecoration({
    ShapeBorder? shape,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
  }) {
    if (this is ShapeDecoration) {
      var shapeDecoration = this as ShapeDecoration;
      return ShapeDecoration(
        color: color ?? shapeDecoration.color,
        image: image ?? shapeDecoration.image,
        shape: shape ?? shapeDecoration.shape,
        gradient: gradient ?? shapeDecoration.gradient,
        shadows: shadows ?? shapeDecoration.shadows,
      );
    }
    return ShapeDecoration(
      color: color,
      image: image,
      shape: shape ?? const RoundedRectangleBorder(),
      gradient: gradient,
      shadows: shadows,
    );
  }
}

/// Theme configuration for primary button styling.
///
/// [PrimaryButtonTheme] extends [ButtonTheme] to provide theme-level customization
/// for primary buttons. It can be registered in the component theme system to
/// override default primary button styles throughout the application.
///
/// Example:
/// ```dart
/// PrimaryButtonTheme(
///   decoration: (context, states, defaultValue) {
///     // Customize primary button decoration
///     return customDecoration;
///   },
/// )
/// ```
class PrimaryButtonTheme extends ButtonTheme {
  /// Creates a [PrimaryButtonTheme] with optional style property delegates.
  const PrimaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  PrimaryButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return PrimaryButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for secondary button styling.
///
/// Provides theme-level customization for secondary buttons through the component
/// theme system. Secondary buttons have muted styling suitable for supporting actions.
class SecondaryButtonTheme extends ButtonTheme {
  /// Creates a [SecondaryButtonTheme] with optional style property delegates.
  const SecondaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  SecondaryButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return SecondaryButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for outline button styling.
///
/// Provides theme-level customization for outline buttons through the component
/// theme system. Outline buttons feature borders with transparent backgrounds.
class OutlineButtonTheme extends ButtonTheme {
  /// Creates an [OutlineButtonTheme] with optional style property delegates.
  const OutlineButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  OutlineButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return OutlineButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for ghost button styling.
///
/// Provides theme-level customization for ghost buttons. Ghost buttons have minimal
/// visual presence with no background or border by default.
class GhostButtonTheme extends ButtonTheme {
  /// Creates a [GhostButtonTheme] with optional style property delegates.
  const GhostButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  GhostButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return GhostButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for link button styling.
///
/// Provides theme-level customization for link buttons. Link buttons appear as
/// inline hyperlinks with underline decoration.
class LinkButtonTheme extends ButtonTheme {
  /// Creates a [LinkButtonTheme] with optional style property delegates.
  const LinkButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  LinkButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return LinkButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for text button styling.
///
/// Provides theme-level customization for text buttons. Text buttons display only
/// their text content without background or border decoration.
class TextButtonTheme extends ButtonTheme {
  /// Creates a [TextButtonTheme] with optional style property delegates.
  const TextButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  TextButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return TextButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for destructive button styling.
///
/// Provides theme-level customization for destructive buttons. Destructive buttons
/// use warning colors (typically red) for actions that delete or remove data.
class DestructiveButtonTheme extends ButtonTheme {
  /// Creates a [DestructiveButtonTheme] with optional style property delegates.
  const DestructiveButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  DestructiveButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return DestructiveButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for fixed button styling.
///
/// Provides theme-level customization for fixed buttons. Fixed buttons maintain
/// consistent dimensions regardless of content.
class FixedButtonTheme extends ButtonTheme {
  /// Creates a [FixedButtonTheme] with optional style property delegates.
  const FixedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  FixedButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return FixedButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for menu button styling.
///
/// Provides theme-level customization for menu buttons. Menu buttons are designed
/// for triggering dropdown menus with appropriate spacing and styling.
class MenuButtonTheme extends ButtonTheme {
  /// Creates a [MenuButtonTheme] with optional style property delegates.
  const MenuButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  MenuButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return MenuButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for menubar button styling.
///
/// Provides theme-level customization for menubar buttons. Menubar buttons are
/// optimized for horizontal menu bars with appropriate padding and hover effects.
class MenubarButtonTheme extends ButtonTheme {
  /// Creates a [MenubarButtonTheme] with optional style property delegates.
  const MenubarButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  MenubarButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return MenubarButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for muted button styling.
///
/// Provides theme-level customization for muted buttons. Muted buttons use
/// low-contrast colors for minimal visual impact while remaining functional.
class MutedButtonTheme extends ButtonTheme {
  /// Creates a [MutedButtonTheme] with optional style property delegates.
  const MutedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  MutedButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return MutedButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

/// Theme configuration for card button styling.
///
/// Provides theme-level customization for card buttons. Card buttons feature
/// subtle shadows and borders creating an elevated, card-like appearance.
class CardButtonTheme extends ButtonTheme {
  /// Creates a [CardButtonTheme] with optional style property delegates.
  const CardButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  /// Creates a copy of this theme with selectively replaced properties.
  CardButtonTheme copyWith({
    ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration,
    ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding,
    ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle,
    ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme,
    ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin,
  }) {
    return CardButtonTheme(
      decoration: decoration == null ? this.decoration : decoration(),
      mouseCursor: mouseCursor == null ? this.mouseCursor : mouseCursor(),
      padding: padding == null ? this.padding : padding(),
      textStyle: textStyle == null ? this.textStyle : textStyle(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      margin: margin == null ? this.margin : margin(),
    );
  }
}

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
