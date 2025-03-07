import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:compras_app/generated/l10n.dart'; // Importa o l10n.dart gerado

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'pt', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('pt'),
    Locale('es'),
  ];
}
