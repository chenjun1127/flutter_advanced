import 'dart:async';

import 'package:flutter_advanced/entity/user_info.dart';

//多订阅流(Broadcast),这种流可以有多个监听器监听（listener）
StreamController<UserInfo> streamController = StreamController<UserInfo>.broadcast();
