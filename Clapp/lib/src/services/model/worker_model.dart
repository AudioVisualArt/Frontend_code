

import 'dart:convert';

WorkerModel workerModelFromJson(String str) =>
    WorkerModel.fromJson(json.decode(str));

String workerModelToJson(WorkerModel data) => json.encode(data.toJson());

class WorkerModel {
  String userId;
  String mainRol;
  String description;
  List<String> briefcase;
  String profession;
  String studies;
  String hvUrl;
  double minPayment;
  double maxPayment;



  WorkerModel({
    this.userId,
    this.mainRol,
    this.description ,
    this.briefcase ,
    this.profession ,
    this.studies,
    this.hvUrl,
    this.maxPayment,
    this.minPayment

  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => new WorkerModel(
    userId: json["userId"],
    mainRol: json["mainRol"],
    description: json["description"],
    briefcase: json["briefcase"],
    profession: json["profession"],
    studies: json["studies"],
      hvUrl: json["hvUrl"],
      maxPayment: json["maxPayment"],
      minPayment: json["minPayment"]
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "mainRol": mainRol,
    "description": description,
    "briefcase": briefcase,
    "profession": profession,
    "studies": studies,
    "hvUrl": hvUrl,
    "minPayment":minPayment,
    "maxPayment":maxPayment

  };
}
