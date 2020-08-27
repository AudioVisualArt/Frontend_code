
import 'dart:convert';

UserModel equipmentModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data)=> json.encode(data.toJson());

class UserModel{
  String id;
  int age;
  String cityResidence;
  String description;
  String email;
  String name;
  int rating;

  UserModel({
    this.email,
    this.description,
    this.name,
    this.age,
    this.cityResidence,
    this.id,
    this.rating
});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    age: json["age"],
    cityResidence: json["cityResidence"],
    description: json["description"],
    email: json["email"],
    name: json["name"],
    rating: json["rating"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "age": age,
    "cityResidence": cityResidence,
    "description": description,
    "email": email,
    "name": name,
    "rating": rating
  };
}