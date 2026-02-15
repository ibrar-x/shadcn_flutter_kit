part of '../../shadcn_localizations.dart';


/// _ShadcnLocalizationsDelegate defines a reusable type for this registry module.
class _ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  const _ShadcnLocalizationsDelegate();

  @override
/// Executes `isSupported` behavior for this component/composite.
  bool isSupported(Locale locale) => ShadcnLocalizations.supportedLocales
      .any((supported) => supported.languageCode == locale.languageCode);

  @override
  Future<ShadcnLocalizations> load(Locale locale) async {
    return ShadcnLocalizations(locale);
  }

  @override
/// Executes `shouldReload` behavior for this component/composite.
  bool shouldReload(_ShadcnLocalizationsDelegate old) => false;
}
