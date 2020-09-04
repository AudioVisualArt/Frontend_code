

import 'dart:convert';

WorkerModel workerModelFromJson(String str) =>
    WorkerModel.fromJson(json.decode(str));

String workerModelToJson(WorkerModel data) => json.encode(data.toJson());

class WorkerModel {
  String userId;
  String mainRol;
  String description;
  List<String> briefcase;
  String profesion;
  String estudios;


  WorkerModel({
    this.userId,
    this.mainRol,
    this.description ,
    this.briefcase ,
    this.profesion ,
    this.estudios,

  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => new WorkerModel(
    userId: json["userIde"],
    mainRol: json["mainRol"],
    description: json["description"],
    briefcase: json["briefcase"],
    profesion: json["profesion"],
    estudios: json["estudios"],

  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "mainRol": mainRol,
    "description": description,
    "briefcase": briefcase,
    "profesion": profesion,
    "estudios": estudios,

  };
}
