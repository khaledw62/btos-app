import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ClassificationPage extends StatelessWidget {
  const ClassificationPage({Key? key}) : super(key: key);

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
                    Text("Welcome B TO S",style: Themes().logoTitleStyle,),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: CustomButton(
                        buttonText: "RENT",
                        onTap: () {},
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(height: 21),
                    SizedBox(
                      child: CustomButton(
                        buttonText: "RESALE",
                        onTap: () {
                        },
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(height: 21),
                    SizedBox(
                      child: CustomButton(
                        buttonText: "NEW PROJECT",
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
