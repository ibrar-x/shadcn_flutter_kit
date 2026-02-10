part of '../../shadcn_localizations.dart';

class _ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  const _ShadcnLocalizationsDelegate();

  @override
  Future<ShadcnLocalizations> load(Locale locale) {
    return SynchronousFuture<ShadcnLocalizations>(
      lookupShadcnLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ShadcnLocalizationsDelegate old) => false;
}
