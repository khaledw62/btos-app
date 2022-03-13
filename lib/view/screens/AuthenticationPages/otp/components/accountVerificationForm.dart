import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/OtpInputDecoration.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AccountVerificationForm extends StatefulWidget {
  const AccountVerificationForm({
    Key? key,
  }) : super(key: key);

  @override
  _AccountVerificationFormState createState() => _AccountVerificationFormState();
}

class _AccountVerificationFormState extends State<AccountVerificationForm>{
  final AuthViewModel controller = Get.find();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                  onSaved: (value) {
                    controller.otpDigits['1'] = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "InvalidInput".tr;
                    }
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                  onSaved: (value) {
                    controller.otpDigits['2'] = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "InvalidInput".tr;
                    }
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                  onSaved: (value) {
                    controller.otpDigits['3'] = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "InvalidInput".tr;
                    }
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin5FocusNode),
                  onSaved: (value) {
                    controller.otpDigits['4'] = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "InvalidInput".tr;
                    }
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin6FocusNode),
                  onSaved: (value) {
                    controller.otpDigits['5'] = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "InvalidInput".tr;
                    }
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onSaved: (value) {
                    controller.otpDigits['6'] = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "InvalidInput".tr;
                    }
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          SizedBox(
            child: CustomButton(
              buttonText: "Continue",
              onTap: () {
                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  controller.verify();
                }
              },
            ),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}