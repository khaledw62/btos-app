import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/TextFieldInputDecoration.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController comPassController = TextEditingController();
  final AuthViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.3,
                child: Image.asset("assets/images/signinlogo.png"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofillHints: const [AutofillHints.name],
                          decoration: inputDecoration(label: "FullName".tr, icon: Icons.person),
                          onSaved: (value) {
                            controller.auth['name'] = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "InvalidInput".tr;
                            }
                          },
                        ),
                        const SizedBox(height: 21),
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
                        const SizedBox(height: 21),
                        GetX<AuthViewModel>(
                          init: controller,
                          builder: (controller) => TextFormField(
                            controller: passController,
                            autofillHints: const [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: controller.registrationPassVisible.value,
                            decoration: InputDecoration(
                              labelText: "Password".tr,
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                child: (controller.registrationPassVisible.value)
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onTap: () {
                                  controller.setRegistrationPassVisible();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: neutralGray),
                                borderRadius: BorderRadius.circular(20.0),
                                gapPadding: 20,
                              ),
                            ),
                            onSaved: (value) {
                              controller.auth['password'] = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "InvalidPassword".tr;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 21),
                        GetX<AuthViewModel>(
                          init: controller,
                          builder: (controller) => TextFormField(
                            controller: comPassController,
                            autofillHints: const [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: controller.registrationPassVisible.value,
                            decoration: InputDecoration(
                              labelText: "confirm password",
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                child: (controller.registrationPassVisible.value)
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onTap: () {
                                  controller.setRegistrationPassVisible();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: neutralGray),
                                borderRadius: BorderRadius.circular(20.0),
                                gapPadding: 20,
                              ),
                            ),
                            onSaved: (value) {
                              controller.auth['password_confirmation'] = value!;
                            },
                            validator: (value) {
                              if (value != passController.text) {
                                return "InvalidPassword".tr;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 21),
                        SizedBox(
                          child: CustomButton(
                            buttonText: "signup".tr,
                            onTap: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                controller.registrationWithEmailAndPass();
                              }
                            },
                          ),
                          width: double.infinity,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "have a account?",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () => Get.offAndToNamed("/login"),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: backgroundColor),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
