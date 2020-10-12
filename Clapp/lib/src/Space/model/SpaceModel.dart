import 'dart:convert';

SpaceModel contractsModelFromJson(String str) =>
    SpaceModel.fromJson(json.decode(str));

String SpaceModelToJson(SpaceModel data) => json.encode(data.toJson());

class SpaceModel {

  String id;
  String scheduleDays;
  String scheduleHours;
  String name;
  String location;
  int rating;
  String userOwner;
  String description;
  String minimumHours;
  double priceHour;
  String imageUrl;
  double priceDay;


  SpaceModel({
    this.id,
    this.scheduleDays = '',
    this.scheduleHours = '',
    this.name = '',
    //this.desiredSkills,
    this.location = "",
    this.rating=0,
    this.userOwner,
    this.description,
    this.minimumHours,
    this.priceHour,
    this.imageUrl,
    this.priceDay

  });

  factory SpaceModel.fromJson(Map<String, dynamic> json) =>
      new SpaceModel(
        id: json["id"],
        scheduleDays: json["scheduleDays"],
        scheduleHours: json["scheduleHours"],
        name: json["name"],
        location: json["location"],
        rating: json["rating"],
        userOwner: json["userOwner"],
        description: json["description"],
        minimumHours: json["minimumHours"],
        priceHour: json["priceHour"],
        imageUrl: json["imageUrl"],
        priceDay: json["priceDay"],

      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "scheduleDays": scheduleDays,
    "scheduleHours": scheduleHours,
    "name": name,
    "location": location,
    "rating": rating,
    "userOwner": userOwner,
    "description": description,
    "minimumHours": minimumHours,
    "priceHour": priceHour,
    "imageUrl": imageUrl,
    "priceDay": priceDay,
  };
}