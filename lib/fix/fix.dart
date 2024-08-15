import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CACertHttpOverrides extends HttpOverrides {
  CACertHttpOverrides(this.certificatePath);

  final String certificatePath;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final SecurityContext clientContext = SecurityContext()..setTrustedCertificates(certificatePath);
    return super.createHttpClient(clientContext);
  }
}

void fixCACert(String path) {
  if (Platform.isLinux) {
    HttpOverrides.global = CACertHttpOverrides(path);
  }
}

void fixTargetPlatform() {
  if (kDebugMode && (Platform.isAndroid || Platform.isMacOS)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
  }
}

const Set<PointerDeviceKind> _kTouchLikeDeviceTypes = <PointerDeviceKind>{
  PointerDeviceKind.touch,
  PointerDeviceKind.mouse,
  PointerDeviceKind.stylus,
  PointerDeviceKind.invertedStylus,
  PointerDeviceKind.unknown,
};

///如何在 Flutter 应用中使用它来确保桌面应用支持鼠标、触控板等设备的拖拽滚动效果。
mixin DesktopScrollBehaviorMixin on ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => _kTouchLikeDeviceTypes;

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;
}

class _DesktopScrollBehavior extends MaterialScrollBehavior with DesktopScrollBehaviorMixin {
  const _DesktopScrollBehavior();
}

ScrollBehavior? fixDesktopPlatformDragDevice() {
  if (Platform.isMacOS || Platform.isLinux) {
    return const _DesktopScrollBehavior();
  } else {
    return null;
  }
}
