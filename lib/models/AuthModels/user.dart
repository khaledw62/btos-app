import 'package:btos/models/AuthModels/userType.dart';

class User {
  int id;
  String name, email;
  bool verified;
  int user_type_id;
  String user_type_name;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.verified,
    required this.user_type_id,
    required this.user_type_name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        verified: json["verified"],
        user_type_id: json["user_type"]['id'],
        user_type_name: json["user_type"]['name'],
      );
  factory User.fromJson2(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    verified: json["verified"],
    user_type_id: json["user_type_id"],
    user_type_name: json["user_type_name"],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'verified': verified,
      'user_type_id': user_type_id,
      'user_type_name': user_type_name
    };
  }
  factory User.fake()=>User(id: -1, name: "", email: "", verified: false, user_type_id: -1, user_type_name: "");

}
