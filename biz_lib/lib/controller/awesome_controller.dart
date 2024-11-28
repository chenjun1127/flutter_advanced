import 'package:common_lib/common_lib.dart';

class AwesomeController extends GetxController {
  final RxString _title = 'My Awesome View'.obs;

  String get title => _title.value;

  set title(String value) => _title.value = value;
}
