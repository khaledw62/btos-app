import 'package:btos/models/PropertiesModels/Property.dart';
import 'package:btos/services/api_services.dart';
import 'package:get/get.dart';

class PropertiesListingController extends GetxController{
  Rx<RxList<Property>> propertiesListing = RxList<Property>().obs;
  String endPoint = "api/properties/listing";
  Rx<String?>? next;
  RxInt total = 0.obs;
  getPropertiesListing({bool isFull = false})async{
    try{
      ApiServices().get(isFull?'':endPoint,fullUrl: isFull && next!.value!=null?next!.value:null).then((value) {
        next?.value = value['links']['next'];
        total.value = value['meta']['total'];
        value["data"].forEach((element) {
          propertiesListing.value.add(Property.fromJson(element));
        });
      });
    }catch(e){

    }
  }
  @override
  void onInit() {
    getPropertiesListing();
    super.onInit();
  }
}