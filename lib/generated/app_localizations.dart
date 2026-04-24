import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('pl'),
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Silo Capacity Calculator'**
  String get app_title;

  /// No description provided for @silo_saved.
  ///
  /// In en, this message translates to:
  /// **'Silo updated: '**
  String get silo_saved;

  /// No description provided for @save_silo.
  ///
  /// In en, this message translates to:
  /// **'SAVE SILO'**
  String get save_silo;

  /// No description provided for @update_silo.
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get update_silo;

  /// No description provided for @new_silo.
  ///
  /// In en, this message translates to:
  /// **'New silo'**
  String get new_silo;

  /// No description provided for @crop.
  ///
  /// In en, this message translates to:
  /// **'Crop:'**
  String get crop;

  /// No description provided for @density.
  ///
  /// In en, this message translates to:
  /// **'Density:'**
  String get density;

  /// No description provided for @grain_max.
  ///
  /// In en, this message translates to:
  /// **'Grain amount (MAX):'**
  String get grain_max;

  /// No description provided for @current_amount.
  ///
  /// In en, this message translates to:
  /// **'Current amount'**
  String get current_amount;

  /// No description provided for @cylinder.
  ///
  /// In en, this message translates to:
  /// **'cylinder'**
  String get cylinder;

  /// No description provided for @hopper.
  ///
  /// In en, this message translates to:
  /// **'hopper'**
  String get hopper;

  /// No description provided for @capacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// No description provided for @radius.
  ///
  /// In en, this message translates to:
  /// **'Radius (r)'**
  String get radius;

  /// No description provided for @cyl_height.
  ///
  /// In en, this message translates to:
  /// **'Cylinder height (h1)'**
  String get cyl_height;

  /// No description provided for @hop_height.
  ///
  /// In en, this message translates to:
  /// **'Hopper height (h2)'**
  String get hop_height;

  /// No description provided for @rename_silo.
  ///
  /// In en, this message translates to:
  /// **'Rename silo'**
  String get rename_silo;

  /// No description provided for @delete_silo.
  ///
  /// In en, this message translates to:
  /// **'Delete silo'**
  String get delete_silo;

  /// No description provided for @silo_name.
  ///
  /// In en, this message translates to:
  /// **'Silo name'**
  String get silo_name;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @create_new_silo.
  ///
  /// In en, this message translates to:
  /// **'Create new silo'**
  String get create_new_silo;

  /// No description provided for @tonnes.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get tonnes;

  /// No description provided for @kg_m3.
  ///
  /// In en, this message translates to:
  /// **'kg/m³'**
  String get kg_m3;

  /// No description provided for @my_silos.
  ///
  /// In en, this message translates to:
  /// **'My silos'**
  String get my_silos;

  /// No description provided for @no_silos.
  ///
  /// In en, this message translates to:
  /// **'No saved silos yet'**
  String get no_silos;

  /// No description provided for @theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get theme_dark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @pl.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get pl;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @es.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get es;

  /// No description provided for @de.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get de;

  /// No description provided for @save_silo_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Save silo'**
  String get save_silo_dialog_title;

  /// No description provided for @default_silo_name.
  ///
  /// In en, this message translates to:
  /// **'Silo'**
  String get default_silo_name;

  /// No description provided for @provide_silo_name.
  ///
  /// In en, this message translates to:
  /// **'Enter name for this record:'**
  String get provide_silo_name;

  /// No description provided for @silo_name_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Wheat Silo 1'**
  String get silo_name_hint;

  /// No description provided for @silo_saved_to_list.
  ///
  /// In en, this message translates to:
  /// **'Silo saved to the list!'**
  String get silo_saved_to_list;

  /// No description provided for @provide_new_name.
  ///
  /// In en, this message translates to:
  /// **'Enter new name:'**
  String get provide_new_name;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'CHANGE'**
  String get change;

  /// No description provided for @name_changed_to.
  ///
  /// In en, this message translates to:
  /// **'Name changed to: '**
  String get name_changed_to;

  /// No description provided for @grain_wheat.
  ///
  /// In en, this message translates to:
  /// **'Wheat'**
  String get grain_wheat;

  /// No description provided for @grain_rye.
  ///
  /// In en, this message translates to:
  /// **'Rye'**
  String get grain_rye;

  /// No description provided for @grain_barley.
  ///
  /// In en, this message translates to:
  /// **'Barley'**
  String get grain_barley;

  /// No description provided for @grain_corn.
  ///
  /// In en, this message translates to:
  /// **'Maize'**
  String get grain_corn;

  /// No description provided for @grain_rapeseed.
  ///
  /// In en, this message translates to:
  /// **'Canola'**
  String get grain_rapeseed;

  /// No description provided for @grain_oats.
  ///
  /// In en, this message translates to:
  /// **'Oats'**
  String get grain_oats;

  /// No description provided for @grain_lupins.
  ///
  /// In en, this message translates to:
  /// **'Lupins'**
  String get grain_lupins;

  /// No description provided for @grain_triticale.
  ///
  /// In en, this message translates to:
  /// **'Triticale'**
  String get grain_triticale;

  /// No description provided for @grain_pellets.
  ///
  /// In en, this message translates to:
  /// **'Pellets'**
  String get grain_pellets;

  /// No description provided for @grain_horse_oats.
  ///
  /// In en, this message translates to:
  /// **'Horse Oats'**
  String get grain_horse_oats;

  /// No description provided for @grain_canola_meal.
  ///
  /// In en, this message translates to:
  /// **'Canola Meal'**
  String get grain_canola_meal;

  /// No description provided for @grain_mash.
  ///
  /// In en, this message translates to:
  /// **'Mash'**
  String get grain_mash;

  /// No description provided for @grain_peas.
  ///
  /// In en, this message translates to:
  /// **'Peas'**
  String get grain_peas;

  /// No description provided for @grain_crushed_grain.
  ///
  /// In en, this message translates to:
  /// **'Crushed Grain'**
  String get grain_crushed_grain;

  /// No description provided for @grain_superphosphate.
  ///
  /// In en, this message translates to:
  /// **'Superphosphate'**
  String get grain_superphosphate;

  /// No description provided for @grain_urea.
  ///
  /// In en, this message translates to:
  /// **'Urea'**
  String get grain_urea;

  /// No description provided for @grain_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get grain_other;

  /// No description provided for @tonnage_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Tonnages displayed are an approximate indication only and will vary depending on the individual grain and pellet weights.'**
  String get tonnage_disclaimer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
