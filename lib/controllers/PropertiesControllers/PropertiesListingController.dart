import 'package:btos/models/PropertiesModels/Property.dart';
import 'package:btos/services/api_services.dart';
import 'package:get/get.dart';

class PropertiesListingController extends GetxController{
  Rx<RxList<Property>> propertiesListing = RxList<Property>().obs;
  String endPoint = "api/props/listing";
  Rx<Property> property = Property.fake().obs;
  Rx<String?> next = Rx<String?>(null);
  RxInt total = 0.obs;
  getPropertiesListing({bool isFull = false})async{
    try{
      ApiServices().get(isFull?'':endPoint,fullUrl: isFull && next.value!=null?next.value:null).then((value) {
        print("properties Values = $value");
        next.value = value['links']['next'];
        //total.value = value['meta']['total']??0;
        if(!isFull)propertiesListing.value.clear();
        value["data"].forEach((element) {
          propertiesListing.value.add(Property.fromJson(element));
        });
      });
    }catch(e){
    }
  }
  getProperty(int id)async{
    try{
      clearProperty();
      ApiServices().get("api/props/show/$id").then((value) {
        property.value = Property.fromJson(value['data']);
      });
    }catch(e){
    }
  }
  clearProperty()=>property.value = Property.fake();
}