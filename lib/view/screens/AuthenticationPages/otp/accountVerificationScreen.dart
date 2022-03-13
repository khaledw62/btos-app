import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class AccountVerificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Verification"),
        backgroundColor: backgroundColor,
        foregroundColor: white,
      ),
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
