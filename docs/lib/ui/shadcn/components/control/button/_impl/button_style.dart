part of '../button.dart';

class ButtonSize {
  /// The scaling factor applied to button dimensions.
  ///
  /// A value of 1.0 represents normal size, values less than 1.0 create smaller
  /// buttons, and values greater than 1.0 create larger buttons.
  final double scale;

  /// Creates a [ButtonSize] with the specified scaling factor.
  const ButtonSize(this.scale);

  /// Standard button size (scale: 1.0).
  static const ButtonSize normal = ButtonSize(1);

  /// Extra small button size (scale: 0.5).
  static const ButtonSize xSmall = ButtonSize(1 / 2);

  /// Small button size (scale: 0.75).
  static const ButtonSize small = ButtonSize(3 / 4);

  /// Large button size (scale: 2.0).
  static const ButtonSize large = ButtonSize(2);

  /// Extra large button size (scale: 3.0).
  static const ButtonSize xLarge = ButtonSize(3);
}

/// A function that modifies button padding based on density requirements.
///
/// Takes the base padding and returns modified padding appropriate for the
/// desired button density level.
typedef DensityModifier = EdgeInsets Function(EdgeInsets padding);

/// Defines the padding density for button components.
///
/// [ButtonDensity] controls how much internal padding buttons have, affecting
/// their overall size and touch target area. Different density levels are
/// appropriate for different use cases and layout constraints.
///
/// Example:
/// ```dart
/// Button.primary(
///   style: ButtonStyle.primary().copyWith(density: ButtonDensity.compact),
///   child: Text('Compact Button'),
/// );
/// ```
class ButtonDensity {
  /// Function that modifies base padding to achieve the desired density.
  final DensityModifier modifier;

  /// Creates a [ButtonDensity] with the specified padding modifier.
  const ButtonDensity(this.modifier);

  /// Standard padding density (no modification).
  static const ButtonDensity normal = ButtonDensity(_densityNormal);

  /// Increased padding for more comfortable touch targets.
  static const ButtonDensity comfortable = ButtonDensity(_densityComfortable);

  /// Square padding suitable for icon-only buttons.
  static const ButtonDensity icon = ButtonDensity(_densityIcon);

  /// Comfortable square padding for icon-only buttons.
  static const ButtonDensity iconComfortable =
      ButtonDensity(_densityIconComfortable);

  /// Dense square padding for compact icon buttons.
  static const ButtonDensity iconDense = ButtonDensity(_densityIconDense);

  /// Reduced padding for tighter layouts (50% of normal).
  static const ButtonDensity dense = ButtonDensity(_densityDense);

  /// Minimal padding for very compact layouts (zero padding).
  static const ButtonDensity compact = ButtonDensity(_densityCompact);
}

EdgeInsets _densityNormal(EdgeInsets padding) {
  return padding;
}

EdgeInsets _densityDense(EdgeInsets padding) {
  return padding * 0.5;
}

EdgeInsets _densityCompact(EdgeInsets padding) {
  return EdgeInsets.zero;
}

EdgeInsets _densityIcon(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))));
}

EdgeInsets _densityIconComfortable(EdgeInsets padding) {
  return EdgeInsets.all(
      max(padding.top, max(padding.bottom, max(padding.left, padding.right))));
}

EdgeInsets _densityIconDense(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))) *
          0.5);
}

EdgeInsets _densityComfortable(EdgeInsets padding) {
  return padding * 2;
}

/// Defines the shape style for button components.
///
/// [ButtonShape] determines the border radius and overall shape of buttons,
/// allowing for rectangular buttons with rounded corners or fully circular buttons.
enum ButtonShape {
  /// Rectangular button with theme-appropriate rounded corners.
  rectangle,

  /// Circular button with equal width and height.
  circle,
}

/// Function signature for button state-dependent properties.
///
/// [ButtonStateProperty] is a function type that resolves a property value based
/// on the current widget states (hovered, pressed, focused, disabled, etc.) and
/// build context. This allows button styles to dynamically adapt their appearance
/// based on user interactions.
///
/// Parameters:
/// - [context]: The build context for accessing theme data
/// - [states]: Set of current widget states (e.g., `{WidgetState.hovered, WidgetState.pressed}`)
///
/// Returns the property value of type [T] appropriate for the current states.
///
/// Example:
/// ```dart
/// ButtonStateProperty<Color> backgroundColor = (context, states) {
///   if (states.contains(WidgetState.disabled)) return Colors.grey;
///   if (states.contains(WidgetState.pressed)) return Colors.blue.shade700;
///   if (states.contains(WidgetState.hovered)) return Colors.blue.shade400;
///   return Colors.blue;
/// };
/// ```
typedef ButtonStateProperty<T> = T Function(
    BuildContext context, Set<WidgetState> states);

/// Abstract interface defining the style properties for button components.
///
/// [AbstractButtonStyle] specifies the contract for button styling, requiring
/// implementations to provide state-dependent values for decoration, cursor,
/// padding, text style, icon theme, and margin. This abstraction allows for
/// flexible button theming while maintaining a consistent API.
///
/// All properties return [ButtonStateProperty] functions that resolve values
/// based on the button's current interactive state (hovered, pressed, focused, etc.).
///
/// Implementations include [ButtonStyle] and [ButtonVariance], which provide
/// concrete styling configurations for different button types.
abstract class AbstractButtonStyle {
  /// Returns the decoration (background, border, shadows) based on button state.
  ButtonStateProperty<Decoration> get decoration;

  /// Returns the mouse cursor appearance based on button state.
  ButtonStateProperty<MouseCursor> get mouseCursor;

  /// Returns the internal padding based on button state.
  ButtonStateProperty<EdgeInsetsGeometry> get padding;

  /// Returns the text style based on button state.
  ButtonStateProperty<TextStyle> get textStyle;

  /// Returns the icon theme based on button state.
  ButtonStateProperty<IconThemeData> get iconTheme;

  /// Returns the external margin based on button state.
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}

/// Configurable button style combining variance, size, density, and shape.
///
/// [ButtonStyle] implements [AbstractButtonStyle] and provides a composable way
/// to create button styles by combining a base variance (primary, secondary, outline,
/// etc.) with size, density, and shape modifiers. This allows for flexible button
/// customization while maintaining consistency.
///
/// The class provides named constructors for common button variants (primary,
/// secondary, outline, etc.) and can be further customized with size and density options.
///
/// Example:
/// ```dart
/// // Create a large primary button
/// const ButtonStyle.primary(
///   size: ButtonSize.large,
///   density: ButtonDensity.comfortable,
/// )
///
/// // Create a small outline button with circular shape
/// const ButtonStyle.outline(
///   size: ButtonSize.small,
///   shape: ButtonShape.circle,
/// )
/// ```
class ButtonStyle implements AbstractButtonStyle {
  /// The base style variance (primary, secondary, outline, etc.).
  final AbstractButtonStyle variance;

  /// The size configuration affecting padding and minimum dimensions.
  final ButtonSize size;

  /// The density configuration affecting spacing and compactness.
  final ButtonDensity density;

  /// The shape configuration (rectangle or circle).
  final ButtonShape shape;

  /// Creates a custom [ButtonStyle] with the specified variance and modifiers.
  ///
  /// Parameters:
  /// - [variance] (required): The base button style variant
  /// - [size]: The button size. Defaults to [ButtonSize.normal]
  /// - [density]: The button density. Defaults to [ButtonDensity.normal]
  /// - [shape]: The button shape. Defaults to [ButtonShape.rectangle]
  const ButtonStyle({
    required this.variance,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  });

  /// Creates a primary button style with prominent filled appearance.
  ///
  /// Primary buttons use the theme's primary color with high contrast, making them
  /// ideal for the main action on a screen.
  const ButtonStyle.primary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  /// Creates a secondary button style with muted appearance.
  ///
  /// Secondary buttons have less visual prominence than primary buttons, suitable
  /// for supporting or alternative actions.
  const ButtonStyle.secondary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  /// Creates an outline button style with border and no background.
  ///
  /// Outline buttons feature a border with transparent background, providing a
  /// clear but subtle appearance for secondary actions.
  const ButtonStyle.outline({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  /// Creates a ghost button style with minimal visual presence.
  ///
  /// Ghost buttons have no background or border, only showing on hover, making
  /// them ideal for tertiary actions.
  const ButtonStyle.ghost({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  /// Creates a link button style resembling a text hyperlink.
  ///
  /// Link buttons appear as inline links with underline decoration, typically
  /// used for navigation or inline actions.
  const ButtonStyle.link({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  /// Creates a text-only button style with no background or border.
  ///
  /// Text buttons display only their text content, making them the most minimal
  /// button style for unobtrusive actions.
  const ButtonStyle.text({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  /// Creates a destructive button style for delete/remove actions.
  ///
  /// Destructive buttons use warning colors (typically red) to indicate actions
  /// that remove or delete data.
  const ButtonStyle.destructive({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  /// Creates a fixed-size button style with consistent dimensions.
  ///
  /// Fixed buttons maintain specific dimensions regardless of content, useful
  /// for icon buttons or grid layouts.
  const ButtonStyle.fixed({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  /// Creates a menu button style for dropdown menu triggers.
  ///
  /// Menu buttons are designed for triggering dropdown menus, with appropriate
  /// spacing and styling for menu contexts.
  const ButtonStyle.menu({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menu;

  /// Creates a menubar button style for menubar items.
  ///
  /// Menubar buttons are optimized for horizontal menu bars with appropriate
  /// padding and hover effects.
  const ButtonStyle.menubar({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menubar;

  /// Creates a muted button style with subdued appearance.
  ///
  /// Muted buttons use low-contrast colors for minimal visual impact while
  /// remaining functional.
  const ButtonStyle.muted({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.muted;

  /// Creates a primary icon button style with compact icon density.
  ///
  /// Icon buttons are optimized for displaying icons without text, using
  /// [ButtonDensity.icon] for appropriate spacing.
  const ButtonStyle.primaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  /// Creates a secondary icon button style with compact icon density.
  const ButtonStyle.secondaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  /// Creates an outline icon button style with compact icon density.
  const ButtonStyle.outlineIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  /// Creates a ghost icon button style with compact icon density.
  const ButtonStyle.ghostIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  /// Creates a link icon button style with compact icon density.
  const ButtonStyle.linkIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  /// Creates a text icon button style with compact icon density.
  const ButtonStyle.textIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  /// Creates a destructive icon button style with compact icon density.
  const ButtonStyle.destructiveIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  /// Creates a fixed icon button style with compact icon density.
  const ButtonStyle.fixedIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  /// Creates a card button style with elevated appearance.
  ///
  /// Card buttons feature subtle shadows and borders creating an elevated,
  /// card-like appearance suitable for content-heavy layouts.
  const ButtonStyle.card({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.card;

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (shape == ButtonShape.circle) {
      return _resolveCircleDecoration;
    }
    return variance.decoration;
  }

  Decoration _resolveCircleDecoration(
      BuildContext context, Set<WidgetState> states) {
    var decoration = variance.decoration(context, states);
    if (decoration is BoxDecoration) {
      return BoxDecoration(
        color: decoration.color,
        image: decoration.image,
        border: decoration.border,
        borderRadius: null,
        boxShadow: decoration.boxShadow,
        gradient: decoration.gradient,
        shape: BoxShape.circle,
        backgroundBlendMode: decoration.backgroundBlendMode,
      );
    } else if (decoration is ShapeDecoration) {
      return decoration.copyWith(
        shape: shape == ButtonShape.circle ? const CircleBorder() : null,
      );
    } else {
      throw Exception('Unsupported decoration type ${decoration.runtimeType}');
    }
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    return variance.mouseCursor;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (size == ButtonSize.normal && density == ButtonDensity.normal) {
      return variance.padding;
    }
    return _resolvePadding;
  }

  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    return density.modifier(
        variance.padding(context, states).optionallyResolve(context) *
            size.scale);
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (size == ButtonSize.normal) {
      return variance.textStyle;
    }
    return _resolveTextStyle;
  }

  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var fontSize = variance.textStyle(context, states).fontSize;
    if (fontSize == null) {
      final textStyle = DefaultTextStyle.of(context).style;
      fontSize = textStyle.fontSize ?? 14;
    }
    return variance.textStyle(context, states).copyWith(
          fontSize: fontSize * size.scale,
        );
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (size == ButtonSize.normal) {
      return variance.iconTheme;
    }
    return _resolveIconTheme;
  }

  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var iconSize = variance.iconTheme(context, states).size;
    iconSize ??= IconTheme.of(context).size ?? 24;
    return variance.iconTheme(context, states).copyWith(
          size: iconSize * size.scale,
        );
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    return variance.margin;
  }
}
