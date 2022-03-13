import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/logincontroller.dart';
import '../../../widgets/Values/TextFieldInputDecoration.dart';

class ForgotPassword extends GetWidget<AuthViewModel> {
  TextEditingController mailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Form(
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
                const SizedBox(height: 14),
                SizedBox(
                  child: CustomButton(
                    buttonText: "Find Your Account",
                    onTap: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        if(GetUtils.isEmail(mailController.text)){
                          controller.forgotPassword();
                        }
                      }
                    },
                  ),
                  width: double.infinity,
                ),
              ],
            ),
          ),
          /*Column(
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
                    if(GetUtils.isEmail(mailController.text)){
                      controller.forgotPassword(mailController.text);
                    }
                  },
                ),
                width: double.infinity,
              ),
            ],
          ),*/
        ),
      ),
    );
  }
}
