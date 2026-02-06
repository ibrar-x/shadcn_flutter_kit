part of '../../shadcn_localizations.dart';

class ShadcnLocalizations {
  const ShadcnLocalizations(this.locale);

  final Locale locale;

  static ShadcnLocalizations of(BuildContext context) {
    return Localizations.of<ShadcnLocalizations>(
            context, ShadcnLocalizations) ??
        const ShadcnLocalizations(Locale('en'));
  }

  static const LocalizationsDelegate<ShadcnLocalizations> delegate =
      _ShadcnLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[delegate];

  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  String get commandEmpty => 'No results found';
  String get commandSearch => 'Type a command or search...';
  String get commandMoveUp => 'Move up';
  String get commandMoveDown => 'Move down';
  String get commandActivate => 'Activate';
  String get buttonCancel => 'Cancel';
  String get buttonSave => 'Save';
  String get buttonPrevious => 'Previous';
  String get buttonNext => 'Next';
  String get datePickerSelectYear => 'Select a year';
  String get placeholderDatePicker => 'Pick a date';
  String get timeAM => 'AM';
  String get timePM => 'PM';
  String get timeHour => 'Hour';
  String get timeMinute => 'Minute';
  String get timeSecond => 'Second';
  String get placeholderTimePicker => 'Select a time';
  String get placeholderDurationPicker => 'Select a duration';
  String get durationDay => 'Day';
  String get durationHour => 'Hour';
  String get durationMinute => 'Minute';
  String get durationSecond => 'Second';
  String get timeDaysAbbreviation => 'DD';
  String get timeHoursAbbreviation => 'HH';
  String get timeMinutesAbbreviation => 'MM';
  String get timeSecondsAbbreviation => 'SS';
  String get menuCut => 'Cut';
  String get menuCopy => 'Copy';
  String get menuPaste => 'Paste';
  String get menuSelectAll => 'Select all';
  String get menuShare => 'Share';
  String get menuSearchWeb => 'Search web';
  String get menuLiveTextInput => 'Live text input';
  String get menuUndo => 'Undo';
  String get menuRedo => 'Redo';
  String get menuDelete => 'Delete';
  String get refreshTriggerRefreshing => 'Refreshing...';
  String get refreshTriggerComplete => 'Refresh complete';
  String get refreshTriggerPull => 'Pull to refresh';
  String get refreshTriggerRelease => 'Release to refresh';
  String get placeholderColorPicker => 'Pick a color';
  String get colorPickerTabRGB => 'RGB';
  String get colorPickerTabHSL => 'HSL';
  String get colorPickerTabHSV => 'HSV';
  String get colorPickerTabHEX => 'HEX';
  String get colorRed => 'Red';
  String get colorGreen => 'Green';
  String get colorBlue => 'Blue';
  String get colorAlpha => 'Alpha';
  String get colorHue => 'Hue';
  String get colorSaturation => 'Saturation';
  String get colorLightness => 'Lightness';
  String get colorValue => 'Value';

  String formLengthLessThan(int limit) =>
      'Must be shorter than $limit characters.';

  String formLengthGreaterThan(int limit) =>
      'Must be at least $limit characters.';

  String get formPasswordDigits => 'Must include at least one digit.';

  String get formPasswordLowercase => 'Must include at least one lowercase letter.';

  String get formPasswordUppercase => 'Must include at least one uppercase letter.';

  String get formPasswordSpecial => 'Must include at least one special character.';

  String get invalidValue => 'Invalid value provided.';

  String get invalidEmail => 'Invalid email address.';

  String get invalidURL => 'Invalid URL.';

  String get monthJanuary => 'January';
  String get monthFebruary => 'February';
  String get monthMarch => 'March';
  String get monthApril => 'April';
  String get monthMay => 'May';
  String get monthJune => 'June';
  String get monthJuly => 'July';
  String get monthAugust => 'August';
  String get monthSeptember => 'September';
  String get monthOctober => 'October';
  String get monthNovember => 'November';
  String get monthDecember => 'December';

  String get abbreviatedMonday => 'Mon';
  String get abbreviatedTuesday => 'Tue';
  String get abbreviatedWednesday => 'Wed';
  String get abbreviatedThursday => 'Thu';
  String get abbreviatedFriday => 'Fri';
  String get abbreviatedSaturday => 'Sat';
  String get abbreviatedSunday => 'Sun';

  String get abbreviatedJanuary => 'Jan';
  String get abbreviatedFebruary => 'Feb';
  String get abbreviatedMarch => 'Mar';
  String get abbreviatedApril => 'Apr';
  String get abbreviatedMay => 'May';
  String get abbreviatedJune => 'Jun';
  String get abbreviatedJuly => 'Jul';
  String get abbreviatedAugust => 'Aug';
  String get abbreviatedSeptember => 'Sep';
  String get abbreviatedOctober => 'Oct';
  String get abbreviatedNovember => 'Nov';
  String get abbreviatedDecember => 'Dec';

  String getAbbreviatedWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return abbreviatedMonday;
      case DateTime.tuesday:
        return abbreviatedTuesday;
      case DateTime.wednesday:
        return abbreviatedWednesday;
      case DateTime.thursday:
        return abbreviatedThursday;
      case DateTime.friday:
        return abbreviatedFriday;
      case DateTime.saturday:
        return abbreviatedSaturday;
      case DateTime.sunday:
        return abbreviatedSunday;
      default:
        throw ArgumentError.value(weekday, 'weekday');
    }
  }

  String getMonth(int month) {
    switch (month) {
      case DateTime.january:
        return monthJanuary;
      case DateTime.february:
        return monthFebruary;
      case DateTime.march:
        return monthMarch;
      case DateTime.april:
        return monthApril;
      case DateTime.may:
        return monthMay;
      case DateTime.june:
        return monthJune;
      case DateTime.july:
        return monthJuly;
      case DateTime.august:
        return monthAugust;
      case DateTime.september:
        return monthSeptember;
      case DateTime.october:
        return monthOctober;
      case DateTime.november:
        return monthNovember;
      case DateTime.december:
        return monthDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  String getAbbreviatedMonth(int month) {
    switch (month) {
      case DateTime.january:
        return abbreviatedJanuary;
      case DateTime.february:
        return abbreviatedFebruary;
      case DateTime.march:
        return abbreviatedMarch;
      case DateTime.april:
        return abbreviatedApril;
      case DateTime.may:
        return abbreviatedMay;
      case DateTime.june:
        return abbreviatedJune;
      case DateTime.july:
        return abbreviatedJuly;
      case DateTime.august:
        return abbreviatedAugust;
      case DateTime.september:
        return abbreviatedSeptember;
      case DateTime.october:
        return abbreviatedOctober;
      case DateTime.november:
        return abbreviatedNovember;
      case DateTime.december:
        return abbreviatedDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }
}
