import 'package:flutter/widgets.dart';

///
/// @author chenjun
/// @date 2022-07-19
/// @desc 多语言相关的常量
///

enum LanguageType {
  ///简体中文国家码
  simpleChinese('简体中文', Locale('zh', 'CN')),

  ///繁体中文
  traditionalChinese('繁體中文', Locale('zh', 'TW')),

  ///英语
  english('English', Locale('en')),

  ///西班牙语
  spanish('Español', Locale('es')),

  ///韩语
  korean('한국어', Locale('ko')),

  ///日本语
  japanese('日本語', Locale('ja')),

  ///越南语
  vietnamese('Tiếng Việt', Locale('vi', 'VN')),

  ///泰语
  thai('ภาษาไทย', Locale('th')),

  ///阿拉伯语
  arabic('اللغة العربية', Locale('ar')),

  ///法语
  french('Français', Locale('fr')),

  ///葡萄牙
  portuguese('Português', Locale('pt'));

  const LanguageType(this.name, this.locale);

  final String name;
  final Locale locale;

  String get code => locale.code;

  bool get isChineseSimple => this == LanguageType.simpleChinese;

  bool get isChineseTraditional => this == LanguageType.traditionalChinese;

  bool get isChinese => isChineseSimple || isChineseTraditional;

  bool get isArabic => this == LanguageType.arabic;

  bool get isKorean => this == LanguageType.korean;

  bool get isEnglish => this == LanguageType.english;

  bool get isThai => this == LanguageType.thai;

  bool get isSpanish => this == LanguageType.spanish;

  bool get isJapanese => this == LanguageType.japanese;

  bool get isVietnamese => this == LanguageType.vietnamese;

  bool get isFrench => this == LanguageType.french;

  bool get isPortuguese => this == LanguageType.portuguese;

  bool get isRTL => isArabic;

  static LanguageType fromLocale(Locale locale, {LanguageType defaultType = LanguageType.simpleChinese}) {
    for (final LanguageType type in LanguageType.values) {
      if (type.locale == locale) {
        return type;
      }
    }
    return defaultType;
  }
}

extension LocaleEx on Locale {
  static Locale fromString(String locale) {
    final List<String> codes = locale.split('_');
    if (codes.length == 2) {
      return Locale(codes.first, codes.last);
    } else {
      return Locale(codes.first);
    }
  }

  String get code => countryCode == null ? languageCode : '${languageCode}_$countryCode';
}

class LanguageConst {
  ///简体中文国家码
  static const String chinese_country_code = 'CN';

  ///简体中文
  static const String simple_chinese = 'zh';

  ///繁体中文
  static const String traditional_chinese = 'zh_TW';

  ///英语
  static const String english = 'en';

  ///西班牙语
  static const String es = 'es';

  ///韩语
  static const String ko = 'ko';

  ///日本语
  static const String ja = 'ja';

  ///越南语
  static const String vi = 'vi_VN';

  ///泰语
  static const String th = 'th';

  ///阿拉伯语
  static const String ar = 'ar';

  ///法语
  static const String fr = 'fr';

  ///葡萄牙
  static const String pt = 'pt';

  static const List<LanguageType> dateFormatZh = <LanguageType>[
    LanguageType.simpleChinese,
    LanguageType.traditionalChinese,
    LanguageType.korean,
    LanguageType.japanese
  ];
  static const List<LanguageType> dateFormatEn = <LanguageType>[
    LanguageType.english,
    LanguageType.spanish
  ]; //['en', 'es', 'cs_CZ'];
  static const List<LanguageType> dateFormatTh = <LanguageType>[
    LanguageType.thai,
    LanguageType.french
  ]; //['th', 'fr', 'de', 'tr_TR', 'ru'];
  static const List<LanguageType> dateFormatPo = <LanguageType>[LanguageType.portuguese];
  static const List<LanguageType> dateFormatAr = <LanguageType>[LanguageType.arabic];
  static const List<LanguageType> dateFormatVi = <LanguageType>[LanguageType.vietnamese];
  static const List<LanguageType> monthLowerCase = <LanguageType>[
    LanguageType.spanish,
    LanguageType.french,
    LanguageType.portuguese
  ];
}
