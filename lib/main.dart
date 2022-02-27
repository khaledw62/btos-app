import 'dart:io';
import 'package:btos/controllers/dashboardController.dart';
import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/langs/translation.dart';
import 'package:btos/view/screens/AdditionalPages/locations_page.dart';
import 'package:btos/view/screens/AuthenticationPages/LogInScreen.dart';
import 'package:btos/view/screens/AuthenticationPages/forgot_password_screen.dart';
import 'package:btos/view/screens/AuthenticationPages/signupScreen.dart';
import 'package:btos/view/screens/Dashboard.dart';
import 'package:btos/view/screens/MainScreanPages/Home.dart';
import 'package:btos/view/screens/SearchPage.dart';
import 'package:btos/view/screens/buyerPages/buyerPage.dart';
import 'package:btos/view/screens/welcomeScreen/classification_page.dart';
import 'package:btos/view/screens/welcomeScreen/welcomeScreen.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/PropertiesControllers/PropertiesListingController.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

late AndroidDeviceInfo androidInfo;

late IosDeviceInfo iosInfo;

getDeviceInfo() async {
  if (Platform.isAndroid) {
    androidInfo = await deviceInfo.androidInfo;
  }
  if (Platform.isIOS) {
    iosInfo = await deviceInfo.iosInfo;
  }
}
String initialRoute = '/login';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getDeviceInfo();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? g = preferences.getString('token');
  if(g!=null) {
    initialRoute = "/dashboard";
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModel());
    Get.put(DashboardController(),permanent: true);
    return GetMaterialApp(
      title: 'BToS',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.light,
      initialRoute: '/signup',
      translations: Translation(),
      locale: const Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: [
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/searchPage', page: () => SearchPage()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/welcome_screen', page: () => const WelcomeBtoSScreen()),
        GetPage(name: '/login', page: () => LogInPage()),
        GetPage(name: '/buyerPage', page: () => const BuyerPage()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/forgotPass', page: () => ForgotPassword()),
        GetPage(name: '/classificationPage', page: () => const ClassificationPage()),
        GetPage(name: '/locationsPage', page: () => LocationsPage()),
      ],
    );
  }
}
