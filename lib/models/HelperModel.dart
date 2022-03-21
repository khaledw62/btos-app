class HelperModel {
  int id;
  String name;

  HelperModel({required this.id, required this.name});

  factory HelperModel.fromJson(Map<String, dynamic> json) {
    return HelperModel(id: json['id'], name: json['name']);
  }
}
