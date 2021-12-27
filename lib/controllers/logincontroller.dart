import 'package:get/get.dart';

class LogInController extends GetxController{
  RxBool passVisible = true.obs;
  setPassVisible(){
    passVisible.value = !(passVisible.value);
  }
}