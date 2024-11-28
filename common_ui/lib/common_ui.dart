library;

export 'package:common_lib/common_lib.dart';
export 'package:common_ui/common_ui.dart';
export 'package:common_ui/const/language_const.dart';
export 'package:common_ui/controller/controller.dart';
export 'package:common_ui/styles/styles.dart';

class CommonUi {
  factory CommonUi() => _singleton ?? CommonUi._();

  CommonUi._();

  static CommonUi? _singleton;

  static void Function()? _onTap;

  static void setOnTap(void Function()? onTap) {
    _onTap = onTap;
  }

  static void onTap() {
    _onTap?.call();
  }
}
