import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

String extractMessageFromMap(Map data, String defult) {
  String message = '';
  if (data.containsKey("message")) {
    message = data["message"];
  } else if (data.containsKey("errors")) {
    message = "${data["errors"][0]}";
  }
  if (message.isEmpty) {
    message = defult;
  }
  return message;
}

void showSnack(String message){
  Get.rawSnackbar(
      title: "",
      message: "",
      messageText: Text('aaaaaa $message',style: TextStyle(color: white)),
      backgroundColor: backgroundColor,
      borderRadius: 30,
      overlayColor: black.withOpacity(.7));
}