import 'dart:io';
import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/view/screens/AuthenticationPages/LogInScreen.dart';
import 'package:btos/view/screens/AuthenticationPages/signupScreen.dart';
import 'package:btos/view/screens/Home.dart';
import 'package:btos/view/screens/buyerPages/buyerPage.dart';
import 'package:btos/view/screens/welcomeScreen/welcomeScreen.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

late AndroidDeviceInfo androidInfo;

late IosDeviceInfo iosInfo;
getDeviceInfo()async{
  if(Platform.isAndroid) {
    androidInfo = await deviceInfo.androidInfo;
  }
  if(Platform.isIOS) {
    iosInfo = await deviceInfo.iosInfo;
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  getDeviceInfo();
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
        GetPage(name: '/welcome_screen', page: ()=> WelcomeBtoSScreen()),
        GetPage(name: '/login', page: ()=> LogInPage()),
        GetPage(name: '/buyerPage', page: ()=> const BuyerPage()),
        GetPage(name: '/signup', page: ()=> SignUpScreen()),
      ],
    );
  }
}
