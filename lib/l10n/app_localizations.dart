import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ms.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en'),
    Locale('ms'),
    Locale.fromSubtags(languageCode: 'ms', scriptCode: 'Arab')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @memorizationInfo.
  ///
  /// In en, this message translates to:
  /// **'Memorization Info'**
  String get memorizationInfo;

  /// No description provided for @hasKhatam.
  ///
  /// In en, this message translates to:
  /// **'Has Khatam'**
  String get hasKhatam;

  /// No description provided for @currentJuz.
  ///
  /// In en, this message translates to:
  /// **'Current Juz'**
  String get currentJuz;

  /// No description provided for @currentMaqra.
  ///
  /// In en, this message translates to:
  /// **'Current Maqra'**
  String get currentMaqra;

  /// No description provided for @editInfo.
  ///
  /// In en, this message translates to:
  /// **'Edit Info'**
  String get editInfo;

  /// No description provided for @schedules.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules;

  /// No description provided for @sorry.
  ///
  /// In en, this message translates to:
  /// **'Your schedules will start tomorrow. ☺️'**
  String get sorry;

  /// No description provided for @seeUpcomingSchedules.
  ///
  /// In en, this message translates to:
  /// **'See Upcoming Schedules'**
  String get seeUpcomingSchedules;

  /// No description provided for @seeSchedulesHistory.
  ///
  /// In en, this message translates to:
  /// **'See Schedules History'**
  String get seeSchedulesHistory;

  /// No description provided for @overallProgress.
  ///
  /// In en, this message translates to:
  /// **'Overall Progress'**
  String get overallProgress;

  /// No description provided for @fullyMemorized.
  ///
  /// In en, this message translates to:
  /// **'Fully Memorized'**
  String get fullyMemorized;

  /// No description provided for @partiallyMemorized.
  ///
  /// In en, this message translates to:
  /// **'Partially Memorized'**
  String get partiallyMemorized;

  /// No description provided for @notMemorized.
  ///
  /// In en, this message translates to:
  /// **'Not Memorized'**
  String get notMemorized;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Apperance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color Scheme'**
  String get color;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @danger.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get danger;

  /// No description provided for @resetSchedules.
  ///
  /// In en, this message translates to:
  /// **'Reset Schedules'**
  String get resetSchedules;

  /// No description provided for @resetData.
  ///
  /// In en, this message translates to:
  /// **'Reset Data'**
  String get resetData;

  /// No description provided for @extra.
  ///
  /// In en, this message translates to:
  /// **'Extras'**
  String get extra;

  /// No description provided for @guide.
  ///
  /// In en, this message translates to:
  /// **'User Guide'**
  String get guide;

  /// No description provided for @sendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get sendFeedback;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @upcomingSchedules.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Schedules'**
  String get upcomingSchedules;

  /// No description provided for @scheduleHistory.
  ///
  /// In en, this message translates to:
  /// **'Schedule History'**
  String get scheduleHistory;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No History Found'**
  String get noHistory;

  /// No description provided for @have.
  ///
  /// In en, this message translates to:
  /// **'Have you finished memorizing the Quran?'**
  String get have;

  /// No description provided for @fill.
  ///
  /// In en, this message translates to:
  /// **'Fill in your current memorization info'**
  String get fill;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose a number between'**
  String get choose;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm changes'**
  String get confirm;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid Input'**
  String get invalidInput;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'An app to assist hafiz in scheduling timetables.'**
  String get about;

  /// No description provided for @resetScheduleAbout.
  ///
  /// In en, this message translates to:
  /// **'The app will generate new schedules as if you are new to the app.\nUseful if you have edited your memorization info.'**
  String get resetScheduleAbout;

  /// No description provided for @resetDataAbout.
  ///
  /// In en, this message translates to:
  /// **'All app data will be deleted and cannot be restored.'**
  String get resetDataAbout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'reset'**
  String get reset;

  /// No description provided for @noResult.
  ///
  /// In en, this message translates to:
  /// **'No Results.'**
  String get noResult;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection!'**
  String get noInternet;

  /// No description provided for @memorizedMaqras.
  ///
  /// In en, this message translates to:
  /// **'Memorized Maqras'**
  String get memorizedMaqras;

  /// No description provided for @which.
  ///
  /// In en, this message translates to:
  /// **'Which maqras did you still remember?'**
  String get which;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @scheduleDetails.
  ///
  /// In en, this message translates to:
  /// **'Schedule Details'**
  String get scheduleDetails;

  /// No description provided for @reviewType.
  ///
  /// In en, this message translates to:
  /// **'Review Type'**
  String get reviewType;

  /// No description provided for @portion.
  ///
  /// In en, this message translates to:
  /// **'Portion'**
  String get portion;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @typeDetail.
  ///
  /// In en, this message translates to:
  /// **'Type Details'**
  String get typeDetail;

  /// No description provided for @sabaqDetails.
  ///
  /// In en, this message translates to:
  /// **'New Memorization'**
  String get sabaqDetails;

  /// No description provided for @sabqiDetails.
  ///
  /// In en, this message translates to:
  /// **'Review of recent memorized parts'**
  String get sabqiDetails;

  /// No description provided for @manzilDetails.
  ///
  /// In en, this message translates to:
  /// **'Review Old Memorization'**
  String get manzilDetails;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get completed;

  /// No description provided for @incompleted.
  ///
  /// In en, this message translates to:
  /// **'Mark as Incompleted'**
  String get incompleted;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;
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
      <String>['ar', 'en', 'ms'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'ms':
      {
        switch (locale.scriptCode) {
          case 'Arab':
            return AppLocalizationsMsArab();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'ms':
      return AppLocalizationsMs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
