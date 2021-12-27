import 'dart:io';

import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/services/api_services.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/customSocialButton.dart';
import 'package:btos/widgets/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);
  final LogInController controller = Get.find();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: ClipRRect(
                    child: Image.asset("assets/images/signinlogo.png"),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: const InputDecoration(
                    labelText: "Your Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderSide: BorderSide(color: neutralGray)),
                  ),
                ),
                const SizedBox(height: 8),
                GetX<LogInController>(
                  init: controller,
                  builder: (controller) => TextField(
                    controller: passController,
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.passVisible.value,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(
                        child: (controller.passVisible.value)
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onTap: () {
                          controller.setPassVisible();
                        },
                      ),
                      border: const OutlineInputBorder(borderSide: BorderSide(color: neutralGray)),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  child: CustomButton(
                    buttonText: "Sign In",
                    onTap: () {
                      logInMethod(context);
                    },
                  ),
                  width: double.infinity,
                ),
                const SizedBox(height: 21),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: neutralDark,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: 23,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 21),
                    ),
                    SizedBox(
                      width: 23,
                    ),
                    Expanded(
                      child: Divider(
                        color: neutralDark,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 21),
                Container(
                  child: CustomSocialButton(
                    buttonText: "Login with Google",
                    logoPath: "assets/icons/googlelogo.svg",
                  ),
                  decoration: BoxDecoration(border: Border.all(color: neutralGray)),
                  width: double.infinity,
                ),
                const SizedBox(height: 8),
                Container(
                  child: CustomSocialButton(
                    buttonText: "Login with Facebook",
                    logoPath: "assets/icons/facebooklogo.svg",
                  ),
                  decoration: BoxDecoration(border: Border.all(color: neutralGray)),
                  width: double.infinity,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: backgroundColor),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have a account?",
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: backgroundColor),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, String> s = {};

  logInMethod(BuildContext context) async {
    try {
      ApiServices().post("api/login", context, {
        "email": mailController.text,
        "password": passController.text,
        "os": Platform.operatingSystem,
        "user_type_id": "2",
      }).then((value) {
        if (value.containsKey("token")) {
          Get.offAndToNamed("/buyerPage");
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Authentication failed",
              message: "Authentication failed",
              messageText: Text("Authentication failed"),
            ),
          );
        }
      });
    } catch (e) {
      print("Error = ${e.toString()}");
    }
  }
}
