import 'package:btos/controllers/SystemManagers/routesController.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WelcomeBtoSScreen extends StatelessWidget {
  RoutesController routesController = Get.put(RoutesController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      "Browse as",
                      style: Themes().logoSubTitleStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: CustomButton(
                        buttonText: "BUYER - TENANT",
                        onTap: () {
                          routesController.isBuyer();
                          Get.offAndToNamed("/classificationPage");
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
                        onTap: ()=>Get.offAndToNamed("/classificationPage"),
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(height: 21),
                    SizedBox(
                      child: CustomButton(
                        buttonText: "DEVELOPER",
                        onTap: ()=>Get.offAndToNamed("/login"),
                      ),
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}