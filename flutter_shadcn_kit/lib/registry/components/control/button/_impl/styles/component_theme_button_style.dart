import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import 'abstract_button_style.dart';
import 'button_state_property.dart';
import 'button_state_property_delegate.dart';
import '../themes/button_theme_base.dart';

/// ComponentThemeButtonStyle defines a reusable type for this registry module.
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
/// Stores `decoration` state/configuration for this implementation.
  ButtonStateProperty<Decoration> get decoration => _resolveDecoration;

/// Executes `_resolveDecoration` behavior for this component/composite.
  Decoration _resolveDecoration(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.decoration(context, states);
    return find(context)?.decoration?.call(context, states, resolved) ??
        resolved;
  }

  @override
/// Stores `iconTheme` state/configuration for this implementation.
  ButtonStateProperty<IconThemeData> get iconTheme => _resolveIconTheme;

  IconThemeData _resolveIconTheme(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    var resolved = fallback.iconTheme(context, states);
    return find(context)?.iconTheme?.call(context, states, resolved) ??
        resolved;
  }

  @override
/// Stores `margin` state/configuration for this implementation.
  ButtonStateProperty<EdgeInsetsGeometry> get margin => _resolveMargin;

  EdgeInsetsGeometry _resolveMargin(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    var resolved = fallback.margin(context, states);
    return find(context)?.margin?.call(context, states, resolved) ?? resolved;
  }

  @override
/// Stores `mouseCursor` state/configuration for this implementation.
  ButtonStateProperty<MouseCursor> get mouseCursor => _resolveMouseCursor;

  MouseCursor _resolveMouseCursor(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    var resolved = fallback.mouseCursor(context, states);
    return find(context)?.mouseCursor?.call(context, states, resolved) ??
        resolved;
  }

  @override
/// Stores `padding` state/configuration for this implementation.
  ButtonStateProperty<EdgeInsetsGeometry> get padding => _resolvePadding;

  EdgeInsetsGeometry _resolvePadding(
    BuildContext context,
    Set<WidgetState> states,
  ) {
    var resolved = fallback.padding(context, states);
    return find(context)?.padding?.call(context, states, resolved) ?? resolved;
  }

  @override
/// Stores `textStyle` state/configuration for this implementation.
  ButtonStateProperty<TextStyle> get textStyle => _resolveTextStyle;

/// Executes `_resolveTextStyle` behavior for this component/composite.
  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.textStyle(context, states);
    return find(context)?.textStyle?.call(context, states, resolved) ??
        resolved;
  }
}
