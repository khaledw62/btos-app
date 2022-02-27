import 'dart:io';
import 'package:btos/services/api_services.dart';
import 'package:btos/view/screens/Dashboard.dart';
import 'package:btos/widgets/Values/Functions.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class AuthViewModel extends GetxController {
  RxBool logInPassVisible = true.obs;
  RxBool registrationPassVisible = true.obs;
  Map<String, String> auth = {"email": "", "password": ""};
  final googleSignIn = GoogleSignIn(signInOption: SignInOption.standard );

  setLogInPassVisible() {
    logInPassVisible.value = !(logInPassVisible.value);
  }

  setRegistrationPassVisible() {
    registrationPassVisible.value = !(registrationPassVisible.value);
  }

  logInWithEmailAndPass(BuildContext context) async {
    try {
      var value = await ApiServices().post("api/login", context, {
        "email": auth["email"],
        "password": auth["password"],
        "os": Platform.operatingSystem,
        "user_type_id": Platform.isIOS ? iosInfo.identifierForVendor : androidInfo.id,
        "device_name": Platform.isIOS ?iosInfo.name:androidInfo.device
      });
        print(value);
        if (value.containsKey("token")) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('token', value['token']["plainTextToken"]);
          Get.offAndToNamed("/dashboard");
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Authentication failed",
              message: "Authentication failed",
              messageText: Text("Authentication failed"),
            ),
          );
        }
    } catch (e) {
      print("Error = ${e.toString()}");
    }
  }

  Future logInWithGoogle() async {
     try{
       final GoogleSignInAccount? user = await googleSignIn.signIn();
       print("Userrrrrrrrrrrrr ${user!.displayName}");
       if(user == null){
         Get.rawSnackbar(
             title: "Authentication failed",
             message: "Authentication failed",
             messageText: Text("Authentication failed"),
             backgroundColor: backgroundColor
         );
       }else{
         Get.offAll(()=>Dashboard());
       }
     }catch(e){
       Get.rawSnackbar(
           title: "Authentication failed",
           message: "Authentication failed",
           messageText: const Text("Authentication failed"),
           backgroundColor: backgroundColor
       );
     }
  }

  registrationWithEmailAndPass(BuildContext context) async {
    try {
      var value = await ApiServices().post("api/register", context, {
        "name": auth["name"],
        "email": auth["email"],
        "password": auth["password"],
        "password_confirmation": auth["password_confirmation"],
        "user_type_id": "1",
      });
      print(value);
      if (value.containsKey("created")) {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', value['token']["plainTextToken"]);
        Get.offAndToNamed("/dashboard");
      } else {
        String a = extractMessageFromMap(value, "please try again");
        Get.rawSnackbar(
            title: "Authentication Failed",
            message: a,
            messageText: Text(a,style: Themes().titleStyle,),
          backgroundColor: backgroundColor
        );
      }
    } catch (e) {
      print("Error = ${e.toString()}");
    }
  }
}
