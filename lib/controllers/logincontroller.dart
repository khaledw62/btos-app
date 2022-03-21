import 'dart:convert';
import 'dart:io';
import 'package:btos/models/AuthModels/user.dart';
import 'package:btos/services/api_services.dart';
import 'package:btos/view/screens/Dashboard.dart';
import 'package:btos/widgets/DefaultSpinCircleLoader.dart';
import 'package:btos/widgets/Values/Functions.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class AuthViewModel extends GetxController {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RxBool logInPassVisible = true.obs;
  RxBool registrationPassVisible = true.obs;
  RxBool isUser = false.obs;
  Map<String, String> auth = {"email": "", "password": ""};
  Map<String, String> otpDigits = {"1": "", "2": "", "3": "", "4": "", "5": "", "6": ""};
  final googleSignIn = GoogleSignIn(signInOption: SignInOption.standard);
  Rx<User> userMap = User.fake().obs;

  setVisitorAsUser()=>isUser.value = true;

  setUserMap(Map<String,dynamic> u){
    userMap.value = User.fromJson2(u);
  }

  setLogInPassVisible() {
    logInPassVisible.value = !(logInPassVisible.value);
  }

  setRegistrationPassVisible() {
    registrationPassVisible.value = !(registrationPassVisible.value);
  }

  logInWithEmailAndPass() async {
    //setIsLogin();
    Get.dialog(
      DefaultSpinCircleLoader(),
      navigatorKey: navigatorKey,
      barrierDismissible: false,
      barrierColor: backgroundColor.withOpacity(.3),
    );
    try {
      var value = await ApiServices().post("api/login", {
        "email": auth["email"],
        "password": auth["password"],
        "os": Platform.operatingSystem,
        "user_type_id": Platform.isIOS ? iosInfo.identifierForVendor : androidInfo.id,
        "device_name": Platform.isIOS ? iosInfo.name : androidInfo.device
      });
      //setIsLogin();
      Navigator.of(Get.overlayContext!).pop();
      print("value      $value");
      if (value.containsKey("user")) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', value['token']["plainTextToken"]);
        User u = User.fromJson(value["user"]);
        Map<String, dynamic> user = u.toJson();
        bool result = await sharedPreferences.setString('user', jsonEncode(user));
        print("result     $result");
        if(result){
          isUser.value = true;
          Get.offAll(
            Dashboard(),
          );
        }
      } else {
        String a = extractMessageFromMap(value, "please try again");
        Get.rawSnackbar(
            title: "Authentication failed",
            message: "Authentication failed",
            messageText: Text(a),
            backgroundColor: backgroundColor,
            borderRadius: 30,
            icon: const Icon(
              Icons.error_outline,
              color: lightRed,
              size: 40,
            ),
            overlayColor: black.withOpacity(.7));
      }
    } catch (e) {
      //setIsLogin();
      Navigator.of(Get.overlayContext!).pop();
      print("Error = ${e.toString()}");
    }
  }

  Future logInWithGoogle() async {
    try {
      final GoogleSignInAccount? user = await googleSignIn.signIn();
      if (user == null) {
        Get.rawSnackbar(
            title: "Authentication failed",
            message: "Authentication failed",
            messageText: Text("Authentication failed"),
            backgroundColor: backgroundColor);
      } else {
        isUser.value = true;
        Get.offAll(() => Dashboard());
      }
    } catch (e) {
      Get.rawSnackbar(
          title: "Authentication failed",
          message: "Authentication failed",
          messageText: const Text("Authentication failed"),
          backgroundColor: backgroundColor);
    }
  }

  registrationWithEmailAndPass() async {
    try {
      var value = await ApiServices().post("api/register", {
        "name": auth["name"],
        "email": auth["email"],
        "password": auth["password"],
        "password_confirmation": auth["password_confirmation"],
        "user_type_id": "1",
        "device_name": Platform.isIOS ? iosInfo.name : androidInfo.device
      });
      print(value);
      if (value.containsKey("user")) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', value['token']["plainTextToken"]);
        Get.offAll(
          Dashboard(fromRegistration: true,),
        );
      } else {
        String a = extractMessageFromMap(value, "please try again");
        Get.rawSnackbar(
            title: "Authentication Failed",
            message: a,
            messageText: Text(
              a,
              style: Themes().titleStyle,
            ),
            backgroundColor: backgroundColor);
      }
    } catch (e) {
      Get.rawSnackbar(
          title: "Authentication Failed",
          message: "Authentication Failed",
          messageText: Text(
            "Authentication Failed",
            style: Themes().titleStyle,
          ),
          backgroundColor: backgroundColor);
    }
  }

  logout() async {
    Get.dialog(
      DefaultSpinCircleLoader(),
      navigatorKey: navigatorKey,
      barrierDismissible: false,
      barrierColor: backgroundColor.withOpacity(.3),
    );
    try {
      var value = await ApiServices().post("api/logout");
      //setIsLogin();
      Navigator.of(Get.overlayContext!).pop();
      if (value.containsKey("message")) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.remove('token');
        isUser.value = false;
        Get.offAndToNamed("/login");
      } else {
        String a = extractMessageFromMap(value, "please try again");
        Get.rawSnackbar(
            title: "Authentication failed",
            message: "Authentication failed",
            messageText: Text(a),
            backgroundColor: backgroundColor,
            borderRadius: 30,
            icon: const Icon(
              Icons.error_outline,
              color: lightRed,
              size: 40,
            ),
            overlayColor: black.withOpacity(.7));
      }
    } catch (e) {
      //setIsLogin();
      Navigator.of(Get.overlayContext!).pop();
      print("Error = ${e.toString()}");
    }
  }

  forgotPassword() async {
    Get.dialog(
      DefaultSpinCircleLoader(),
      navigatorKey: navigatorKey,
      barrierDismissible: false,
      barrierColor: backgroundColor.withOpacity(.3),
    );
    try {
      var value = await ApiServices().post("api/password/email", {
        "email": auth["email"],
      });
      //setIsLogin();
      print("Value ======== $value");
      Navigator.of(Get.overlayContext!).pop();
      if (value.containsKey("status")) {
        if (value['status'] == 'success') {
          Get.offAndToNamed("/otpScreen");
          Get.rawSnackbar(
              title: "",
              message: "",
              messageText: Text(value['message']),
              backgroundColor: backgroundColor,
              borderRadius: 30,
              icon: const Icon(
                Icons.error_outline,
                color: lightRed,
                size: 40,
              ),
              overlayColor: black.withOpacity(.7));
        } else {
          Get.rawSnackbar(
              title: "",
              message: "",
              messageText: Text(value['message']),
              backgroundColor: backgroundColor,
              borderRadius: 30,
              icon: const Icon(
                Icons.error_outline,
                color: lightRed,
                size: 40,
              ),
              overlayColor: black.withOpacity(.7));
          Get.offNamedUntil('login', (route) => false);
        }
      } else {
        String a = extractMessageFromMap(value, "please try again");
        Get.rawSnackbar(
            title: "Authentication failed",
            message: "Authentication failed",
            messageText: Text(a),
            backgroundColor: backgroundColor,
            borderRadius: 30,
            icon: const Icon(
              Icons.error_outline,
              color: lightRed,
              size: 40,
            ),
            overlayColor: black.withOpacity(.7));
      }
    } catch (e) {
      //setIsLogin();
      Navigator.of(Get.overlayContext!).pop();
    }
  }

  verify() async {
    Get.dialog(
      DefaultSpinCircleLoader(),
      navigatorKey: navigatorKey,
      barrierDismissible: false,
      barrierColor: backgroundColor.withOpacity(.3),
    );
    try {
      var value = await ApiServices().post("api/email/verify", {
        "code":
            "${otpDigits['1']}${otpDigits['2']}${otpDigits['3']}${otpDigits['4']}${otpDigits['5']}${otpDigits['6']}",
      });
      //setIsLogin();
      print("Value ======== $value");
      Navigator.of(Get.overlayContext!).pop();
      if (value.containsKey("status")) {
        if (value['status'] == 'success') {
          Get.offAndToNamed("/otpScreen");
          Get.rawSnackbar(
              title: "",
              message: "",
              messageText: Text(value['message']),
              backgroundColor: backgroundColor,
              borderRadius: 30,
              icon: const Icon(
                Icons.error_outline,
                color: lightRed,
                size: 40,
              ),
              overlayColor: black.withOpacity(.7));
        } else {
          Get.rawSnackbar(
              title: "",
              message: "",
              messageText: Text(value['message']),
              backgroundColor: backgroundColor,
              borderRadius: 30,
              icon: const Icon(
                Icons.error_outline,
                color: lightRed,
                size: 40,
              ),
              overlayColor: black.withOpacity(.7));
          Get.offNamedUntil('login', (route) => false);
        }
      } else {
        String a = extractMessageFromMap(value, "please try again");
        Get.rawSnackbar(
            title: "Authentication failed",
            message: "Authentication failed",
            messageText: Text(a),
            backgroundColor: backgroundColor,
            borderRadius: 30,
            icon: const Icon(
              Icons.error_outline,
              color: lightRed,
              size: 40,
            ),
            overlayColor: black.withOpacity(.7));
      }
    } catch (e) {
      //setIsLogin();
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
