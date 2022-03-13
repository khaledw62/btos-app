import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'accountVerificationForm.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "Account Verification",
                style: Themes().titleStyle,
              ),
              const Text("We sent your code to +20 155 081 ***"),
              buildTimer(),
              const AccountVerificationForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: const Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 300.0, end: 0.0),
          duration: const Duration(minutes: 5),
          builder: (_, dynamic value, child) => Text(
            "${(value/60).toInt()+1} minutes",
            style: const TextStyle(color: backgroundColor),
          ),
          onEnd: ()=>Get.offNamedUntil('/forgotPass', (route) => false),
        ),
      ],
    );
  }
}