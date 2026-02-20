import '../variants/button_theme_base.dart';
import '../variants/card_button_theme.dart';
import '../variants/destructive_button_theme.dart';
import '../variants/fixed_button_theme.dart';
import '../variants/ghost_button_theme.dart';
import '../variants/link_button_theme.dart';
import '../variants/menu_button_theme.dart';
import '../variants/menubar_button_theme.dart';
import '../variants/muted_button_theme.dart';
import '../variants/outline_button_theme.dart';
import '../variants/primary_button_theme.dart';
import '../variants/secondary_button_theme.dart';
import '../variants/text_button_theme.dart';

/// Global token override entrypoint for the button component.
class ButtonThemeTokensConfig {
  const ButtonThemeTokensConfig._();

  /// Global component theme override for `PrimaryButtonTheme`.
  static const PrimaryButtonTheme? primary = null;
  static const String primaryType = 'PrimaryButtonTheme';
  static const Map<String, Object?> primaryDefaults = <String, Object?>{};
  static const Map<String, Object?> primaryTokens = <String, Object?>{};

  /// Global component theme override for `SecondaryButtonTheme`.
  static const SecondaryButtonTheme? secondary = null;
  static const String secondaryType = 'SecondaryButtonTheme';
  static const Map<String, Object?> secondaryDefaults = <String, Object?>{};
  static const Map<String, Object?> secondaryTokens = <String, Object?>{};

  /// Global component theme override for `OutlineButtonTheme`.
  static const OutlineButtonTheme? outline = null;
  static const String outlineType = 'OutlineButtonTheme';
  static const Map<String, Object?> outlineDefaults = <String, Object?>{};
  static const Map<String, Object?> outlineTokens = <String, Object?>{};

  /// Global component theme override for `GhostButtonTheme`.
  static const GhostButtonTheme? ghost = null;
  static const String ghostType = 'GhostButtonTheme';
  static const Map<String, Object?> ghostDefaults = <String, Object?>{};
  static const Map<String, Object?> ghostTokens = <String, Object?>{};

  /// Global component theme override for `LinkButtonTheme`.
  static const LinkButtonTheme? link = null;
  static const String linkType = 'LinkButtonTheme';
  static const Map<String, Object?> linkDefaults = <String, Object?>{};
  static const Map<String, Object?> linkTokens = <String, Object?>{};

  /// Global component theme override for `TextButtonTheme`.
  static const TextButtonTheme? text = null;
  static const String textType = 'TextButtonTheme';
  static const Map<String, Object?> textDefaults = <String, Object?>{};
  static const Map<String, Object?> textTokens = <String, Object?>{};

  /// Global component theme override for `DestructiveButtonTheme`.
  static const DestructiveButtonTheme? destructive = null;
  static const String destructiveType = 'DestructiveButtonTheme';
  static const Map<String, Object?> destructiveDefaults = <String, Object?>{};
  static const Map<String, Object?> destructiveTokens = <String, Object?>{};

  /// Global component theme override for `FixedButtonTheme`.
  static const FixedButtonTheme? fixed = null;
  static const String fixedType = 'FixedButtonTheme';
  static const Map<String, Object?> fixedDefaults = <String, Object?>{};
  static const Map<String, Object?> fixedTokens = <String, Object?>{};

  /// Global component theme override for `MenuButtonTheme`.
  static const MenuButtonTheme? menu = null;
  static const String menuType = 'MenuButtonTheme';
  static const Map<String, Object?> menuDefaults = <String, Object?>{};
  static const Map<String, Object?> menuTokens = <String, Object?>{};

  /// Global component theme override for `MenubarButtonTheme`.
  static const MenubarButtonTheme? menubar = null;
  static const String menubarType = 'MenubarButtonTheme';
  static const Map<String, Object?> menubarDefaults = <String, Object?>{};
  static const Map<String, Object?> menubarTokens = <String, Object?>{};

  /// Global component theme override for `MutedButtonTheme`.
  static const MutedButtonTheme? muted = null;
  static const String mutedType = 'MutedButtonTheme';
  static const Map<String, Object?> mutedDefaults = <String, Object?>{};
  static const Map<String, Object?> mutedTokens = <String, Object?>{};

  /// Global component theme override for `CardButtonTheme`.
  static const CardButtonTheme? card = null;
  static const String cardType = 'CardButtonTheme';
  static const Map<String, Object?> cardDefaults = <String, Object?>{};
  static const Map<String, Object?> cardTokens = <String, Object?>{};

  /// Resolves the configured global override for a button theme subtype.
  static T? resolve<T extends ButtonTheme>() {
    if (T == PrimaryButtonTheme) return primary as T?;
    if (T == SecondaryButtonTheme) return secondary as T?;
    if (T == OutlineButtonTheme) return outline as T?;
    if (T == GhostButtonTheme) return ghost as T?;
    if (T == LinkButtonTheme) return link as T?;
    if (T == TextButtonTheme) return text as T?;
    if (T == DestructiveButtonTheme) return destructive as T?;
    if (T == FixedButtonTheme) return fixed as T?;
    if (T == MenuButtonTheme) return menu as T?;
    if (T == MenubarButtonTheme) return menubar as T?;
    if (T == MutedButtonTheme) return muted as T?;
    if (T == CardButtonTheme) return card as T?;
    return null;
  }
}
