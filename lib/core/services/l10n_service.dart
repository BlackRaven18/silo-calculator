import 'package:flutter/material.dart';
import 'package:silo_calculator/generated/app_localizations.dart';

class L10nService {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

extension LocalizedContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension LocalizedGrain on AppLocalizations {
  String getLocalizedGrainName(String originalName) {
    switch (originalName) {
      case 'Pszenica':
        return grain_wheat;
      case 'Żyto':
        return grain_rye;
      case 'Jęczmień':
        return grain_barley;
      case 'Owies':
        return grain_oats;
      case 'Rzepak':
        return grain_rapeseed;
      case 'Kukurydza':
        return grain_corn;
      case 'Łubin':
        return grain_lupins;
      case 'Pszenżyto':
        return grain_triticale;
      case 'Pellet':
        return grain_pellets;
      case 'Owies dla koni':
        return grain_horse_oats;
      case 'Śruta rzepakowa':
        return grain_canola_meal;
      case 'Mieszanka paszowa':
        return grain_mash;
      case 'Groch':
        return grain_peas;
      case 'Ziarno śrutowane':
        return grain_crushed_grain;
      case 'Superfosfat':
        return grain_superphosphate;
      case 'Mocznik':
        return grain_urea;
      case 'Inny':
        return grain_other;
      default:
        return originalName;
    }
  }
}

