import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor
          ),
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
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    child: CustomButton(
                      buttonText: "SALE",
                      onTap: (){}/*=>Get.offAndToNamed("/classificationPage")*/,
                    ),
                    width: double.infinity,
                  ),
                  const SizedBox(height: 21),
                  SizedBox(
                    child: CustomButton(
                      buttonText: "RENT",
                      onTap: (){}/*=>Get.offAndToNamed("/login")*/,
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
