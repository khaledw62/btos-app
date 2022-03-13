import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final AuthViewModel controller = Get.put(AuthViewModel());

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
            title: Text('logout'.tr),
            leading: const Icon(Icons.logout),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
