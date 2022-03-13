import 'package:btos/models/PropertiesModels/Property.dart';
import 'package:btos/services/api_services.dart';
import 'package:get/get.dart';

class PropertiesFavouriteController extends GetxController{
  Rx<RxList<Property>> propertiesFavourite = RxList<Property>().obs;
  String endPoint = "api/favourite/properties";
  getPropertiesFavourite({bool isFull = false})async{
    try{
      ApiServices().get(endPoint).then((value) {
        print("Favourite Values = $value");
        value["data"].forEach((element) {
          propertiesFavourite.value.add(Property.fromJson(element));
        });
      });
    }catch(e){
    }
  }
  @override
  void onInit() {
    /*getPropertiesFavourite();*/
    super.onInit();
  }
  @override
  void update([List<Object>? ids, bool condition = true]) {
    print("update");
    super.update(ids, condition);
  }
  @override
  void refresh() {
    print("refresh");
    super.refresh();
  }
  @override
  void onReady() {
    print("onReady");
    super.onReady();
  }
  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart {
    print("onStart");
    return super.onStart;
  }
}