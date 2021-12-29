import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController comPassController = TextEditingController();
  final LogInController controller = Get.find();

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
                  child: Column(
                    children: [
                      TextField(
                        controller: mailController,
                        keyboardType: TextInputType.text,
                        autofillHints: const [AutofillHints.name],
                        decoration: const InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(borderSide: BorderSide(color: neutralGray)),
                        ),
                      ),
                      const SizedBox(height: 21),
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
                      const SizedBox(height: 21),
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
                      const SizedBox(height: 21),
                      GetX<LogInController>(
                        init: controller,
                        builder: (controller) => TextField(
                          controller: comPassController,
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.passVisible.value,
                          decoration: InputDecoration(
                            labelText: "confirm password",
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
                      const SizedBox(height: 21),
                      SizedBox(
                        child: CustomButton(
                          buttonText: "Sign Up",
                          onTap: () {},
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
                              )),
                        ],
                      )
                    ],
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
