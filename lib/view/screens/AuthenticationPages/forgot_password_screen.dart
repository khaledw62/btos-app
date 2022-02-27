import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  TextEditingController mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find your Account"),
        backgroundColor: backgroundColor,
        foregroundColor: white,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Enter Your E-Mail"),
               TextField(
                controller: mailController,
                autofocus: true,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "E-Mail",
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                child: CustomButton(
                  buttonText: "Find Your Account",
                  onTap: () {
                  },
                ),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
