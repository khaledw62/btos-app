class TextualValue{
  dynamic value;
  String textual_value;
  TextualValue({required this.value,required this.textual_value,});
  factory TextualValue.fromJson(Map<String, dynamic> json){
    return TextualValue(value: json["value"], textual_value: json["textual_value"]);
  }
}