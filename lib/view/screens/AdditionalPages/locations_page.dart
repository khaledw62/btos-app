import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({Key? key}) : super(key: key);
  List<String> locations = [
    "ALL",
    "RED SEA",
    "NEW CAPITAL",
    "NEW CAIRO",
    "OCTOBER & ZAYED",
    "SOKHNA",
    "NORTH COAST",
    "OTHERS"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CHOOSE LOCATION",
          style: Themes().appbarTitle,
        ),
        backgroundColor: white,
        centerTitle: false,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: neutralGray,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Column(
            children: locations
                .map((e) => Column(
                      children: [
                        SizedBox(
                          child: CustomButton(
                            buttonText: e,
                            onTap: () {},
                          ),
                          width: double.infinity,
                        ),
                        const SizedBox(height: 21),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
