// GENERATED: component theming architecture config file.
// Wires defaults + tokens to theme registry.

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

import 'button_theme_defaults.dart';
import 'button_theme_tokens.dart';

class ButtonThemeConfig {
  const ButtonThemeConfig._();

  /// Global component theme override for `PrimaryButtonTheme`.
  static const PrimaryButtonTheme? primary = null;
  static const String primaryType = 'PrimaryButtonTheme';
  static const ButtonThemeConfigPrimaryDefaults primaryDefaults =
      ButtonThemeConfigPrimaryDefaults();
  static const ButtonThemeConfigPrimaryTokens primaryTokens =
      ButtonThemeConfigPrimaryTokens();

  /// Global component theme override for `SecondaryButtonTheme`.
  static const SecondaryButtonTheme? secondary = null;
  static const String secondaryType = 'SecondaryButtonTheme';
  static const ButtonThemeConfigSecondaryDefaults secondaryDefaults =
      ButtonThemeConfigSecondaryDefaults();
  static const ButtonThemeConfigSecondaryTokens secondaryTokens =
      ButtonThemeConfigSecondaryTokens();

  /// Global component theme override for `OutlineButtonTheme`.
  static const OutlineButtonTheme? outline = null;
  static const String outlineType = 'OutlineButtonTheme';
  static const ButtonThemeConfigOutlineDefaults outlineDefaults =
      ButtonThemeConfigOutlineDefaults();
  static const ButtonThemeConfigOutlineTokens outlineTokens =
      ButtonThemeConfigOutlineTokens();

  /// Global component theme override for `GhostButtonTheme`.
  static const GhostButtonTheme? ghost = null;
  static const String ghostType = 'GhostButtonTheme';
  static const ButtonThemeConfigGhostDefaults ghostDefaults =
      ButtonThemeConfigGhostDefaults();
  static const ButtonThemeConfigGhostTokens ghostTokens =
      ButtonThemeConfigGhostTokens();

  /// Global component theme override for `LinkButtonTheme`.
  static const LinkButtonTheme? link = null;
  static const String linkType = 'LinkButtonTheme';
  static const ButtonThemeConfigLinkDefaults linkDefaults =
      ButtonThemeConfigLinkDefaults();
  static const ButtonThemeConfigLinkTokens linkTokens =
      ButtonThemeConfigLinkTokens();

  /// Global component theme override for `TextButtonTheme`.
  static const TextButtonTheme? text = null;
  static const String textType = 'TextButtonTheme';
  static const ButtonThemeConfigTextDefaults textDefaults =
      ButtonThemeConfigTextDefaults();
  static const ButtonThemeConfigTextTokens textTokens =
      ButtonThemeConfigTextTokens();

  /// Global component theme override for `DestructiveButtonTheme`.
  static const DestructiveButtonTheme? destructive = null;
  static const String destructiveType = 'DestructiveButtonTheme';
  static const ButtonThemeConfigDestructiveDefaults destructiveDefaults =
      ButtonThemeConfigDestructiveDefaults();
  static const ButtonThemeConfigDestructiveTokens destructiveTokens =
      ButtonThemeConfigDestructiveTokens();

  /// Global component theme override for `FixedButtonTheme`.
  static const FixedButtonTheme? fixed = null;
  static const String fixedType = 'FixedButtonTheme';
  static const ButtonThemeConfigFixedDefaults fixedDefaults =
      ButtonThemeConfigFixedDefaults();
  static const ButtonThemeConfigFixedTokens fixedTokens =
      ButtonThemeConfigFixedTokens();

  /// Global component theme override for `MenuButtonTheme`.
  static const MenuButtonTheme? menu = null;
  static const String menuType = 'MenuButtonTheme';
  static const ButtonThemeConfigMenuDefaults menuDefaults =
      ButtonThemeConfigMenuDefaults();
  static const ButtonThemeConfigMenuTokens menuTokens =
      ButtonThemeConfigMenuTokens();

  /// Global component theme override for `MenubarButtonTheme`.
  static const MenubarButtonTheme? menubar = null;
  static const String menubarType = 'MenubarButtonTheme';
  static const ButtonThemeConfigMenubarDefaults menubarDefaults =
      ButtonThemeConfigMenubarDefaults();
  static const ButtonThemeConfigMenubarTokens menubarTokens =
      ButtonThemeConfigMenubarTokens();

  /// Global component theme override for `MutedButtonTheme`.
  static const MutedButtonTheme? muted = null;
  static const String mutedType = 'MutedButtonTheme';
  static const ButtonThemeConfigMutedDefaults mutedDefaults =
      ButtonThemeConfigMutedDefaults();
  static const ButtonThemeConfigMutedTokens mutedTokens =
      ButtonThemeConfigMutedTokens();

  /// Global component theme override for `CardButtonTheme`.
  static const CardButtonTheme? card = null;
  static const String cardType = 'CardButtonTheme';
  static const ButtonThemeConfigCardDefaults cardDefaults =
      ButtonThemeConfigCardDefaults();
  static const ButtonThemeConfigCardTokens cardTokens =
      ButtonThemeConfigCardTokens();

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
