part of '../../shadcn_localizations.dart';


class _ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  const _ShadcnLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ShadcnLocalizations.supportedLocales
      .any((supported) => supported.languageCode == locale.languageCode);

  @override
  Future<ShadcnLocalizations> load(Locale locale) async {
    return ShadcnLocalizations(locale);
  }

  @override
  bool shouldReload(_ShadcnLocalizationsDelegate old) => false;
}
