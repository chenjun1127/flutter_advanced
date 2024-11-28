import 'package:flutter/material.dart';

class FontFamily {
  static const String mainFontFamily = 'MainFont';
  static const String oppoMedium = 'OPPOSans-M';

  static const List<String> fontFamilyFallback = <String>[
    'NanumGothic-Regular',
    'NotoSansThai-Regular',
    oppoMedium,
    'SourceSansPro-Regular',
    'Amiri-Regular',
    'Rubik-Regular',
  ];
}

class FontStyle {
  static TextStyle defaultTitle = const TextStyle(
    fontFamily: FontFamily.mainFontFamily,
    fontFamilyFallback: FontFamily.fontFamilyFallback,
    decoration: TextDecoration.none,
  );
  static TextStyle default300Title = defaultTitle.copyWith(
    fontWeight: FontWeight.w300,
  );
  static TextStyle default400Title = defaultTitle.copyWith(
    fontWeight: FontWeight.w400,
  );
  static TextStyle default500Title = defaultTitle.copyWith(
    fontWeight: FontWeight.w500,
  );
  static TextStyle default600Title = defaultTitle.copyWith(
    fontWeight: FontWeight.w600,
  );
  static TextStyle subText = defaultTitle.copyWith(
    fontSize: 22,
    color: const Color.fromRGBO(255, 255, 255, 0.8),
  );
  static TextStyle smallText = defaultTitle.copyWith(
    fontSize: 18,
    color: const Color.fromRGBO(255, 255, 255, 0.5),
  );
  static TextStyle title = FontStyle.defaultTitle.merge(
    const TextStyle(
      fontFamily: FontFamily.mainFontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      decoration: TextDecoration.none,
    ),
  );
}
