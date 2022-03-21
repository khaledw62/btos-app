import 'package:btos/controllers/PropertiesControllers/AddPropController.dart';
import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/Properties/AddNewProperty.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final AuthViewModel controller = Get.find();
  final DashboardController dashboardController = Get.find();
  final AddPropController addPropController = Get.put(AddPropController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            title: Text('language'.tr),
            leading: const Icon(
              Icons.emoji_flags,
              color: backgroundColor,
              size: 30,
            ),
            onTap: () => Get.updateLocale(Get.locale == const Locale("ar") ? const Locale("en") : const Locale("ar")),
          ),
          ListTile(
            title: const Text("Add Property"),
            leading: const Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
            onTap: () => dashboardController.setCurrentWidget(
              Container(child: AddProperty()),
            ),
          ),
          ListTile(
            title: Text('logout'.tr),
            leading: const Icon(Icons.logout),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
