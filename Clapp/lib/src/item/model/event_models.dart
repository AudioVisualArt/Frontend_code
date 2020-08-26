// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.adress,
    this.date,
    this.description,
    this.nameEvent,
    this.kinfOfEvent,
    this.id,
  });

  String adress;
  String date;
  String description;
  String nameEvent;
  String kinfOfEvent;
  String id;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        adress: json["adress"],
        date: json["date"],
        description: json["description"],
        nameEvent: json["nameEvent"],
        kinfOfEvent: json["kinfOfEvent"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "adress": adress,
        "date": date,
        "description": description,
        "nameEvent": nameEvent,
        "kinfOfEvent": kinfOfEvent,
        "id": id,
      };
}
