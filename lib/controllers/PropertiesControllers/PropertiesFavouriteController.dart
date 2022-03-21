import 'dart:io';

import 'package:btos/models/PropertiesModels/Property.dart';
import 'package:btos/services/api_services.dart';
import 'package:get/get.dart';

class PropertiesFavouriteController extends GetxController{
  Rx<RxList<Property>> propertiesFavourite = RxList<Property>().obs;
  String endPoint = "api/favourite/properties";
  getPropertiesFavourite({bool isFull = false})async{
    try{
      ApiServices().get(endPoint).then((value) {
        print("propertiesFavourite length before ${propertiesFavourite.value.length}");
        propertiesFavourite.value.clear();
        value["data"].forEach((element) {
          propertiesFavourite.value.add(Property.fromJson(element));
        });
        print("propertiesFavourite length after ${propertiesFavourite.value.length}");
      });
    }catch(e){
      print("Error        ${e.toString()}");
    }
  }
}