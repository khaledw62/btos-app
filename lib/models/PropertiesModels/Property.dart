import 'package:btos/models/PropertiesModels/TextualValue.dart';

class Property {
  int id, floors, bedrooms, bathrooms;
  TextualValue price, area, bua_area;
  String property_type_name, property_listing_type, finish_type_name, project, place;
  bool can_favourite,is_favourite;

  Property({
    required this.id,
    required this.floors,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    required this.can_favourite,
    required this.is_favourite,
    required this.area,
    required this.bua_area,
    required this.property_type_name,
    required this.property_listing_type,
    required this.finish_type_name,
    required this.project,
    required this.place,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"],
      floors: json["floors"],
      bedrooms: json["bedrooms"],
      bathrooms: json["bathrooms"],
      price: TextualValue.fromJson(json["price"]),
      area: TextualValue.fromJson(json["area"]),
      bua_area: TextualValue.fromJson(json["bua_area"]),
      property_type_name: json["property_type_name"],
      property_listing_type: json["property_listing_type"],
      finish_type_name: json["finish_type_name"]??"",
      project: "${json["project"]}",
      place: json["place"]??"",
      can_favourite: json["can_favourite"]??false,
      is_favourite: json["is_favourite"]??false,
    );
  }
}
