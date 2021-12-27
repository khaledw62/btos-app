import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/view/screens/AuthenticationPages/LogInScreen.dart';
import 'package:btos/view/screens/Home.dart';
import 'package:btos/view/screens/buyerPages/buyerPage.dart';
import 'package:btos/view/screens/welcomeScreen/welcome_screen.dart';
import 'package:btos/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LogInController());
    return GetMaterialApp(
      title: 'BToS',
      debugShowCheckedModeBanner: false,
      theme:Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/home', page: ()=>HomeScreen()),
        GetPage(name: '/welcome_screen', page: ()=>const WelcomeScreen()),
        GetPage(name: '/login', page: ()=> LogInPage()),
        GetPage(name: '/buyerPage', page: ()=> const BuyerPage()),
      ],
    );
  }
}
