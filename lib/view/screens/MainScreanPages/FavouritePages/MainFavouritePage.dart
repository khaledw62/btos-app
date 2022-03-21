import 'package:btos/controllers/PropertiesControllers/PropertiesFavouriteController.dart';
import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/view/screens/MainScreanPages/Favourite.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainFavouritePage extends StatefulWidget {
  @override
  State<MainFavouritePage> createState() => _MainFavouritePageState();
}

class _MainFavouritePageState extends State<MainFavouritePage> {
  final PropertiesFavouriteController controller = Get.put(PropertiesFavouriteController());
  final DashboardController dashboardController = Get.find();
  @override
  void initState() {
    controller.getPropertiesFavourite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "Your Favourite",
                style: Themes().titleStyle,
              ),
              leading: CircleAvatar(
                radius: 23,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: backgroundColor),
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: const Icon(Icons.favorite_border, color: lightRed),
                ),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              ),
              trailing: CircleAvatar(
                radius: 15,
                foregroundColor: white,
                child: GetX<PropertiesFavouriteController>(
                  init: controller,
                  builder: (controller) => Text("${controller.propertiesFavourite.value.length}"),
                ),
                backgroundColor: backgroundColor,
              ),
              onTap: ()=>dashboardController.setCurrentWidget(Container(child: Favourite(),)),
            )
          ],
        ),
      ),
    );
  }
}
