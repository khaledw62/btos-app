import 'package:btos/langs/ar.dart';
import 'package:btos/langs/en.dart';
import 'package:get/get.dart';

class Translation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar
  };
}