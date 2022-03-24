import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/TextFieldInputDecoration.dart';
import 'package:btos/widgets/customSocialButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController mailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  final AuthViewModel controller = Get.put(AuthViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  child: ClipRRect(
                    child: SvgPicture.asset("assets/icons/Icon.svg"),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome B TO S",
                  style: Themes().logoTitleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  "Sign in to continue",
                  style: Themes().logoSubTitleStyle,
                ),
                const SizedBox(height: 28),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: mailController,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: inputDecoration(label: "YourEmail".tr, icon: Icons.email_outlined),
                        onSaved: (value) {
                          controller.auth['email'] = value!;
                        },
                        validator: (value) {
                          if (!GetUtils.isEmail(value!)) {
                            return "InvalidEmail".tr;
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      GetX<AuthViewModel>(
                        init: controller,
                        builder: (controller) => TextFormField(
                          controller: passController,
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.logInPassVisible.value,
                          decoration: InputDecoration(
                            labelText: "Password".tr,
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: GestureDetector(
                              child: (controller.logInPassVisible.value)
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onTap: () {
                                controller.setLogInPassVisible();
                              },
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: neutralGray),
                                borderRadius: BorderRadius.circular(20.0),
                                gapPadding: 20),
                          ),
                          onSaved: (value) {
                            controller.auth['password'] = value!;
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "InvalidPassword".tr;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        child: CustomButton(
                          text: Text(
                            'login'.tr,
                            style: const TextStyle(fontWeight: FontWeight.w700, color: white, fontSize: 15),
                          ),
                          onTap: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              controller.logInWithEmailAndPass();
                            }
                          },
                        ),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Get.isDarkMode ? white : neutralDark,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 23,
                      ),
                      Text(
                        "Or Login With",
                        style: Themes().subTitleStyle,
                      ),
                      const SizedBox(
                        width: 23,
                      ),
                      Expanded(
                        child: Divider(
                          color: Get.isDarkMode ? white : neutralDark,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CustomSocialButton(
                        buttonText: "Login with Google",
                        logoPath: "assets/icons/googlelogo.svg",
                        onTap: () {
                          controller.logInWithGoogle();
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      child: CustomSocialButton(
                        buttonText: "Login with Facebook",
                        logoPath: "assets/icons/facebooklogo.svg",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 21),
                TextButton(
                    onPressed: () {
                      Get.toNamed("/forgotPass");
                    },
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
                        onPressed: () => Get.offAndToNamed("/signup"),
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
}
