// ═══════════════════════════════════════════════════════════
// COMPONENT THEME CONFIG
// Registration wiring (do not edit manually)
// ═══════════════════════════════════════════════════════════

import 'button_theme_defaults.dart';
import 'button_theme_tokens.dart';

class ButtonThemeConfig {
  const ButtonThemeConfig._();

  static const Object? primaryButtonTheme = null;
  static const String primaryButtonThemeType = 'PrimaryButtonTheme';
  static const PrimaryButtonThemeDefaults primaryButtonThemeDefaults = PrimaryButtonThemeDefaults();
  static const PrimaryButtonThemeTokens primaryButtonThemeTokenConfig = primaryButtonThemeTokens;

  static const Object? secondaryButtonTheme = null;
  static const String secondaryButtonThemeType = 'SecondaryButtonTheme';
  static const SecondaryButtonThemeDefaults secondaryButtonThemeDefaults = SecondaryButtonThemeDefaults();
  static const SecondaryButtonThemeTokens secondaryButtonThemeTokenConfig = secondaryButtonThemeTokens;

  static const Object? outlineButtonTheme = null;
  static const String outlineButtonThemeType = 'OutlineButtonTheme';
  static const OutlineButtonThemeDefaults outlineButtonThemeDefaults = OutlineButtonThemeDefaults();
  static const OutlineButtonThemeTokens outlineButtonThemeTokenConfig = outlineButtonThemeTokens;

  static const Object? ghostButtonTheme = null;
  static const String ghostButtonThemeType = 'GhostButtonTheme';
  static const GhostButtonThemeDefaults ghostButtonThemeDefaults = GhostButtonThemeDefaults();
  static const GhostButtonThemeTokens ghostButtonThemeTokenConfig = ghostButtonThemeTokens;

  static const Object? linkButtonTheme = null;
  static const String linkButtonThemeType = 'LinkButtonTheme';
  static const LinkButtonThemeDefaults linkButtonThemeDefaults = LinkButtonThemeDefaults();
  static const LinkButtonThemeTokens linkButtonThemeTokenConfig = linkButtonThemeTokens;

  static const Object? textButtonTheme = null;
  static const String textButtonThemeType = 'TextButtonTheme';
  static const TextButtonThemeDefaults textButtonThemeDefaults = TextButtonThemeDefaults();
  static const TextButtonThemeTokens textButtonThemeTokenConfig = textButtonThemeTokens;

  static const Object? destructiveButtonTheme = null;
  static const String destructiveButtonThemeType = 'DestructiveButtonTheme';
  static const DestructiveButtonThemeDefaults destructiveButtonThemeDefaults = DestructiveButtonThemeDefaults();
  static const DestructiveButtonThemeTokens destructiveButtonThemeTokenConfig = destructiveButtonThemeTokens;

  static const Object? fixedButtonTheme = null;
  static const String fixedButtonThemeType = 'FixedButtonTheme';
  static const FixedButtonThemeDefaults fixedButtonThemeDefaults = FixedButtonThemeDefaults();
  static const FixedButtonThemeTokens fixedButtonThemeTokenConfig = fixedButtonThemeTokens;

  static const Object? menuButtonTheme = null;
  static const String menuButtonThemeType = 'MenuButtonTheme';
  static const MenuButtonThemeDefaults menuButtonThemeDefaults = MenuButtonThemeDefaults();
  static const MenuButtonThemeTokens menuButtonThemeTokenConfig = menuButtonThemeTokens;

  static const Object? menubarButtonTheme = null;
  static const String menubarButtonThemeType = 'MenubarButtonTheme';
  static const MenubarButtonThemeDefaults menubarButtonThemeDefaults = MenubarButtonThemeDefaults();
  static const MenubarButtonThemeTokens menubarButtonThemeTokenConfig = menubarButtonThemeTokens;

  static const Object? mutedButtonTheme = null;
  static const String mutedButtonThemeType = 'MutedButtonTheme';
  static const MutedButtonThemeDefaults mutedButtonThemeDefaults = MutedButtonThemeDefaults();
  static const MutedButtonThemeTokens mutedButtonThemeTokenConfig = mutedButtonThemeTokens;

  static const Object? cardButtonTheme = null;
  static const String cardButtonThemeType = 'CardButtonTheme';
  static const CardButtonThemeDefaults cardButtonThemeDefaults = CardButtonThemeDefaults();
  static const CardButtonThemeTokens cardButtonThemeTokenConfig = cardButtonThemeTokens;

  static T? resolve<T>() {
    if (T.toString() == primaryButtonThemeType) {
      return primaryButtonTheme as T?;
    }
    if (T.toString() == secondaryButtonThemeType) {
      return secondaryButtonTheme as T?;
    }
    if (T.toString() == outlineButtonThemeType) {
      return outlineButtonTheme as T?;
    }
    if (T.toString() == ghostButtonThemeType) {
      return ghostButtonTheme as T?;
    }
    if (T.toString() == linkButtonThemeType) {
      return linkButtonTheme as T?;
    }
    if (T.toString() == textButtonThemeType) {
      return textButtonTheme as T?;
    }
    if (T.toString() == destructiveButtonThemeType) {
      return destructiveButtonTheme as T?;
    }
    if (T.toString() == fixedButtonThemeType) {
      return fixedButtonTheme as T?;
    }
    if (T.toString() == menuButtonThemeType) {
      return menuButtonTheme as T?;
    }
    if (T.toString() == menubarButtonThemeType) {
      return menubarButtonTheme as T?;
    }
    if (T.toString() == mutedButtonThemeType) {
      return mutedButtonTheme as T?;
    }
    if (T.toString() == cardButtonThemeType) {
      return cardButtonTheme as T?;
    }
    return null;
  }
}
