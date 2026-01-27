import 'package:flutter/widgets.dart';

import '../../../../shared/theme/theme.dart';
import 'abstract_button_style.dart';
import 'button_state_property.dart';
import 'button_state_property_delegate.dart';
import 'button_theme_base.dart';

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
