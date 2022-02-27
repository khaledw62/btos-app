import 'package:get/get.dart';

class DashboardController extends GetxController{
  RxInt index = 0.obs;
  setPassVisible(int index){
    this.index.value = index;
  }
}