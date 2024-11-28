import 'dart:ui';

import 'package:common_ui/common_ui.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();
  final Rx<String> _languageCode = (LanguageConst.english).obs;

  set language(LanguageType value) {
    JLogger.i('LanguageController set value:$value');
    Get.updateLocale(value.locale);
    _languageCode.value = value.locale.code;
  }

  bool get isChineseSimple => _languageCode.value == LanguageConst.simpleChinese;

  bool get isChineseTraditional => language.isChineseTraditional;

  bool get isChinese => language.isChinese;

  bool get isArabic => language.isArabic;

  bool get isKorean => language.isKorean;

  bool get isEnglish => language.isEnglish;

  bool get isThai => language.isThai;

  bool get isSpanish => language.isSpanish;

  bool get isJapanese => language.isJapanese;

  bool get isVietnamese => language.isVietnamese;

  bool get isFrench => language.isFrench;

  bool get isPortuguese => language.isPortuguese;

  bool get isRTL => language.isRTL;

  LanguageType get language {
    final Locale locale = LocaleEx.fromString(_languageCode());
    return LanguageType.fromLocale(locale);
  }
}
