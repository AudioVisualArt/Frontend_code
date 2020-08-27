// To parse this JSON data, do
//
//     final contractModel = contractModelFromJson(jsonString);

import 'dart:convert';

ContractModel contractModelFromJson(String str) =>
    ContractModel.fromJson(json.decode(str));

String contractModelToJson(ContractModel data) => json.encode(data.toJson());

class ContractModel {
  ContractModel({
    this.city,
    this.desiredSkills,
    this.jobPosition,
    this.payment,
    this.workHours,
    this.userApplicantId,
    this.userBidderId,
    this.id,
  });

  String city;
  List<String> desiredSkills;
  String jobPosition;
  double payment;
  int workHours;
  String userApplicantId;
  String userBidderId;
  String id;

  factory ContractModel.fromJson(Map<String, dynamic> json) => ContractModel(
        city: json["city"],
        desiredSkills: List<String>.from(json["desiredSkills"].map((x) => x)),
        jobPosition: json["jobPosition"],
        payment: json["payment"].toDouble(),
        workHours: json["workHours"],
        userApplicantId: json["userApplicantId"],
        userBidderId: json["userBidderId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "desiredSkills": List<dynamic>.from(desiredSkills.map((x) => x)),
        "jobPosition": jobPosition,
        "payment": payment,
        "workHours": workHours,
        "userApplicantId": userApplicantId,
        "userBidderId": userBidderId,
        "id": id,
      };
}
