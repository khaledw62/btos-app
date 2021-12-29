import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';

class WelcomeBtoSScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.4,
                child: Image.asset("assets/images/signinlogo.png"),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      child: CustomButton(
                        buttonText: "BUYER - Tenant",
                        onTap: () {
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
                    SizedBox(
                      child: CustomButton(
                        buttonText: "SELLER",
                        onTap: () {
                        },
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(height: 21),
                    SizedBox(
                      child: CustomButton(
                        buttonText: "DEVELOPER",
                        onTap: () {
                        },
                      ),
                      width: double.infinity,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
