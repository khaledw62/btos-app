import 'package:get/get.dart';

class RoutesController extends GetxController {
  RxBool isSeller = true.obs;
  isBuyer() => isSeller.value = false;
}
