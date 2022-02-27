import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "What are you looking for?",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: neutralGray),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        contentPadding: EdgeInsets.zero
                      ),
                      autofocus: true,
                      onSaved: (value) {},
                      validator: (value) {},
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.offNamed('/dashboard'),
                    child: Text(
                      "Cancel",
                      style: Themes().titleStyle,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
