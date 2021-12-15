import 'package:btos/view/screens/Home.dart';
import 'package:btos/view/screens/welcomeScreen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PToS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome_screen',
      getPages: [
        GetPage(name: '/home', page: ()=>HomeScreen()),
        GetPage(name: '/welcome_screen', page: ()=>const WelcomeScreen()),
      ],
    );
  }
}
