import 'dart:io';
import 'package:btos/controllers/PropertiesControllers/AddPropController.dart';
import 'package:btos/models/HelperModel.dart';
import 'package:btos/widgets/CustomButton.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Values/TextFieldInputDecoration.dart';

class AddProperty extends StatefulWidget {
  AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<XFile> selectedImages = [];
  TextEditingController priceController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  final AddPropController addPropController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: GetX<AddPropController>(
          init: addPropController,
          builder: (addPropController) => addPropController.dataIsLoaded.value
              ? Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        child: Image.asset("assets/images/addimageprop.png"),
                        onTap: () async {
                          List<XFile> selected;
                          selected = await ImagePicker().pickMultiImage() ?? [];
                          if (selected != []) {
                            setState(() {
                              selectedImages = selected;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        direction: Axis.horizontal,
                        children: selectedImages
                            .map((e) => SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Image.file(File(e.path), fit: BoxFit.cover),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecorationWithNoIcon(label: "price (EGP)"),
                        onSaved: (value) {},
                        validator: (value) {
                          if(value==null||value.isEmpty) {
                            return "This field is required";
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: downPaymentController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecorationWithNoIcon(label: "down payment"),
                        onSaved: (value) {},
                        validator: (value) {
                          if(value==null||value.isEmpty) {
                            return "This field is required";
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: bedroomsController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecorationWithNoIcon(label: "bedrooms"),
                        onSaved: (value) {},
                        validator: (value) {
                          if(value==null||value.isEmpty) {
                            return "This field is required";
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: bathroomsController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecorationWithNoIcon(label: "bathrooms"),
                        onSaved: (value) {},
                        validator: (value) {
                          if(value==null||value.isEmpty) {
                            return "This field is required";
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: areaController,
                        keyboardType: TextInputType.number,
                        decoration: inputDecorationWithNoIcon(label: "area (m2)"),
                        onSaved: (value) {},
                        validator: (value) {
                          if(value==null||value.isEmpty) {
                            return "This field is required";
                          }
                        },
                      ),
                      Column(children: [
                        const SizedBox(height: 8),
                        ...addPropController.data.entries
                            .map((entry) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: DropdownSearch<HelperModel>(
                                    items: entry.value,
                                    itemAsString: (HelperModel? u) => u!.name,
                                    showClearButton: true,
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: entry.key.entries.first.key,
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: neutralGray),
                                          borderRadius: BorderRadius.circular(5.0),
                                          gapPadding: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: neutralGray),
                                          borderRadius: BorderRadius.circular(20.0),
                                          gapPadding: 20),
                                    ),
                                    showSearchBox: true,
                                    mode: Mode.MENU,
                                    validator: (HelperModel? value) {
                                      if(entry.key.entries.first.value && value==null) {
                                        return "This field is required";
                                      }
                                    },
                                    onChanged: (HelperModel? val) {},
                                  ),
                                ))
                            .toList()
                      ]),
                      const SizedBox(height: 14),
                      SizedBox(
                        child: CustomButton(
                          text: const Text(
                            'SUBMIT AD',
                            style: TextStyle(fontWeight: FontWeight.w700, color: white, fontSize: 15),
                          ),
                          onTap: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                            }
                          },
                        ),
                        width: double.infinity,
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
