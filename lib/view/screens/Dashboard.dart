import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/view/screens/MainScreanPages/Account.dart';
import 'package:btos/view/screens/MainScreanPages/Explore.dart';
import 'package:btos/view/screens/MainScreanPages/Favourite.dart';
import 'package:btos/view/screens/MainScreanPages/Home.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Dashboard extends StatelessWidget {
  final DashboardController dashboardController = Get.find();
  List<Widget> pages = [
    HomeScreen(),
    Explore(),
    Favourite(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).copyWith().backgroundColor,
      body: GetX<DashboardController>(
        builder: (dashboardController) => pages[dashboardController.index.value],
      ),
      bottomNavigationBar: getBottomBar(),
    );
  }

  int index = 0;

  Widget getBottomBar() {
    return GetX<DashboardController>(
      init: dashboardController,
      builder: (newController) => BottomNavigationBar(
        selectedItemColor: backgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 30,
            ),
            label: 'Favourite',
            activeIcon: Icon(
              Icons.favorite,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
            ),
            label: 'Account',
            activeIcon: Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ],
        onTap: (index) {
          newController.setPassVisible(index);
        },
        currentIndex: newController.index.value,
        showUnselectedLabels: true,
        unselectedItemColor: Get.isDarkMode ? white : neutralDark,
        backgroundColor: Get.isDarkMode ? neutralDark : white,
      ),
    );
  }
}
