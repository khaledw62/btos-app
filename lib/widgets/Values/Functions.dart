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