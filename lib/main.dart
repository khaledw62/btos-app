import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:btos/langs/translation.dart';
import 'package:btos/view/screens/AdditionalPages/locations_page.dart';
import 'package:btos/view/screens/AuthenticationPages/LogInScreen.dart';
import 'package:btos/view/screens/AuthenticationPages/forgot_password_screen.dart';
import 'package:btos/view/screens/AuthenticationPages/otp/accountVerificationScreen.dart';
import 'package:btos/view/screens/AuthenticationPages/signupScreen.dart';
import 'package:btos/view/screens/Dashboard.dart';
import 'package:btos/view/screens/MainScreanPages/Favourite.dart';
import 'package:btos/view/screens/MainScreanPages/Home.dart';
import 'package:btos/view/screens/NoConnection/NoConnectionPage.dart';
import 'package:btos/view/screens/SearchPage.dart';
import 'package:btos/view/screens/buyerPages/buyerPage.dart';
import 'package:btos/view/screens/welcomeScreen/FirstPage.dart';
import 'package:btos/view/screens/welcomeScreen/classification_page.dart';
import 'package:btos/view/screens/welcomeScreen/welcomeScreen.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/logincontroller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

late AndroidDeviceInfo androidInfo;

late IosDeviceInfo iosInfo;

getDeviceInfo() async {
  if (Platform.isAndroid) {
    androidInfo = await deviceInfo.androidInfo;
    print("D Name ${androidInfo.type}");
  }
  if (Platform.isIOS) {
    iosInfo = await deviceInfo.iosInfo;
    print("D Name ${iosInfo.name}");
  }
}

setInit() async {
  final AuthViewModel controller = Get.put(AuthViewModel(), permanent: true);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String g = (preferences.getString('token') ?? "");
  String userPref = (preferences.getString('user') ?? "");
  print("userPref       $userPref");
  if (userPref != "") {
    Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    print("setInit            $userMap");
    controller.setUserMap(userMap);
  }
  if (g != "") {
    controller.setVisitorAsUser();
    initialRoute = "/dashboard";
  } else {
    initialRoute = '/welcome_screen';
  }
}

String initialRoute = '';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setInit();
  await getDeviceInfo();
  Timer.periodic(const Duration(seconds: 3), (timer) {
    FlutterNativeSplash.remove();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BToS',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.light,
      initialRoute: initialRoute,
      translations: Translation(),
      locale: const Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: [
        GetPage(name: '/dashboard', page: () => Dashboard()),
        GetPage(name: '/noConnectionPage', page: () => const NoConnectionPage()),
        GetPage(name: '/searchPage', page: () => SearchPage()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/welcome_screen', page: () => WelcomeBtoSScreen()),
        GetPage(name: '/login', page: () => LogInPage()),
        GetPage(name: '/buyerPage', page: () => const BuyerPage()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/forgotPass', page: () => ForgotPassword()),
        GetPage(name: '/classificationPage', page: () => ClassificationPage()),
        GetPage(name: '/locationsPage', page: () => LocationsPage()),
        GetPage(name: '/accountVerificationScreen', page: () => AccountVerificationScreen()),
        GetPage(name: '/firstPage', page: () => const FirstPage()),
        GetPage(name: '/favouritePage', page: () => Favourite()),
      ],
    );
  }
}
