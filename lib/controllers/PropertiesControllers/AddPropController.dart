import 'dart:async';
import 'package:btos/models/HelperModel.dart';
import 'package:btos/services/api_services.dart';
import 'package:get/get.dart';

class AddPropController extends GetxController{
  Rx<RxList<HelperModel>> addPropData = RxList<HelperModel>().obs;
  String endPoint = "api/get-helpers/property";
  RxBool dataIsLoaded = false.obs;
  Map<Map<String,bool>,List<HelperModel>> data = {};
  getAddPropertyData()async{
    try{
      ApiServices().get(endPoint).then((value) {
        data = {};
        value.forEach((key, value) {
          value.forEach((key, value) {
            List<HelperModel> r = [];
            value['0'].forEach((element) {
              r.add(HelperModel.fromJson(element));
            });
            data[{key:value['required']}] = r;
          });
        });
        update();
        dataIsLoaded.value = true;
      });
    }catch(e){
      Timer(const Duration(seconds: 10),getAddPropertyData());
    }
  }
  @override
  void onInit() {
    getAddPropertyData();
    Timer.periodic(const Duration(minutes: 10),(r)=> getAddPropertyData());
    super.onInit();
  }
}