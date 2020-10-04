

import 'dart:convert';

ContractModel contractsModelFromJson(String str) =>
    ContractModel.fromJson(json.decode(str));

String ContractModelToJson(ContractModel data) => json.encode(data.toJson());

class ContractModel {
  String city;
 // List<String> desiredSkills;
  String jobPosition;
  double payment;
  int workHours;
  String userApplicantId;
  String userBidderId;
  String id;
  String projectId;
  bool acceptedBidder =false;
  bool acceptedApplicant =false;
  double latitud;
  double longitud;


  ContractModel({
    this.id,
    this.city = '',
    this.payment = 0.0,
    this.jobPosition = '',
    //this.desiredSkills,
    this.workHours = 0,
    this.userApplicantId,
    this.userBidderId,
    this.projectId,
    this.acceptedBidder,
    this.acceptedApplicant,
    this.latitud,
    this.longitud

  });

  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      new ContractModel(
        city: json["city"],
       // desiredSkills: json["desiredSkills"],
        jobPosition: json["jobPosition"],
        payment: json["payment"],
        workHours: json["workHours"],
        userApplicantId: json["userApplicantId"],
        userBidderId: json["userBidderId"],
        id: json["id"],
        projectId: json["projectId"],
        acceptedBidder: json["acceptedBidder"],
        acceptedApplicant: json["acceptedApplicant"],
        latitud: json["latitud"],
        longitud:json["longitud"],

      );

  Map<String, dynamic> toJson() => {
    "city": city,
    //"desiredSkills": desiredSkills,
    "jobPosition": jobPosition,
    "payment": payment,
    "workHours": workHours,
    "userApplicantId": userApplicantId,
    "userBidderId": userBidderId,
    "id": id,
    "projectId": projectId,
    "acceptedBidder": acceptedBidder,
    "acceptedApplicant": acceptedApplicant,
    "latitud": latitud,
    "longitud" : longitud
  };
}
