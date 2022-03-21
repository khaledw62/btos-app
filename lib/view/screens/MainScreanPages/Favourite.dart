import 'package:btos/controllers/PropertiesControllers/PropertiesFavouriteController.dart';
import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/view/screens/MainScreanPages/FavouritePages/MainFavouritePage.dart';
import 'package:btos/widgets/Properties/PropertyCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favourite extends StatefulWidget {
  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final PropertiesFavouriteController controller = Get.find();
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: ListView(
            children: [
              AppBar(
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => dashboardController.setCurrentWidget(Container(
                    child: MainFavouritePage(),
                  )),
                  icon: const Icon(
                    Icons.clear,
                    size: 35,
                  ),
                ),
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
