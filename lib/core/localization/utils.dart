import 'loc_keys.dart';

String getLanguageNameByLanguageCode(String langCode) {
  switch (langCode.toLowerCase()) {
    case 'en':
      return Loc.english();
    case 'zh':
      return Loc.mandarinChinese();
    case 'hi':
      return Loc.hindi();
    case 'es':
      return Loc.spanish();
    case 'fr':
      return Loc.french();
    case 'ar':
      return Loc.arabic();
    case 'bn':
      return Loc.bengali();
    case 'pt':
      return Loc.portuguese();
    case 'ru':
      return Loc.russian();
    case 'ur':
      return Loc.urdu();
    default:
      return 'Unknown Language';
  }
}
