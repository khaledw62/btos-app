import 'package:btos/controllers/PropertiesControllers/PropertiesFavouriteController.dart';
import 'package:btos/widgets/Properties/PropertyCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Values/sizes.dart';

class Favourite extends GetWidget<PropertiesFavouriteController> {

  @override
  final PropertiesFavouriteController controller = Get.put(PropertiesFavouriteController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Directionality(
      textDirection: Get.locale == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              GetX<PropertiesFavouriteController>(
                  init: controller,
                  builder: (controller) {
                    return Column(
                      children: controller.propertiesFavourite.value
                          .map(
                            (e) => PropertyCard(property: e),
                      )
                          .toList(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
