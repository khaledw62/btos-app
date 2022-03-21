import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/view/screens/MainScreanPages/Account.dart';
import 'package:btos/view/screens/MainScreanPages/Explore.dart';
import 'package:btos/view/screens/MainScreanPages/FavouritePages/MainFavouritePage.dart';
import 'package:btos/view/screens/MainScreanPages/Home.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  bool? fromRegistration;

  Dashboard({this.fromRegistration});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController dashboardController = Get.put(DashboardController(),permanent: true);

  List<Widget> pages = [
    HomeScreen(),
    Explore(),
    MainFavouritePage(),
    Account(),
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).copyWith().backgroundColor,
      body: SafeArea(
        child: GetX<DashboardController>(
          init: dashboardController,
          builder: (dashboardController)=>dashboardController.currentWidget.value,
        ),
      ),
      bottomNavigationBar: getBottomBar(),
    );
  }

  int index = 0;

  Widget getBottomBar() {
    return GetX<DashboardController>(
      init: dashboardController,
      builder: (dashboardController)=>BottomNavigationBar(
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
          dashboardController.setCurrentWidget(Container(child: pages[index],));
          dashboardController.setIndex(index);
        },
        currentIndex: dashboardController.index.value,
        showUnselectedLabels: true,
        unselectedItemColor: Get.isDarkMode ? white : neutralDark,
        backgroundColor: Get.isDarkMode ? neutralDark : white,
      ),
    );
  }
}
