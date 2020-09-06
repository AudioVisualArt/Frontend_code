

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
  //String userApplicantId;
  String userBidderId;
  String id;
  String projectId;
  bool accepted =false;


  ContractModel({
    this.id,
    this.city = '',
    this.payment = 0.0,
    this.jobPosition = '',
    //this.desiredSkills,
    this.workHours = 0,
    //this.userApplicantId,
    this.userBidderId,
    this.projectId,
    this.accepted
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      new ContractModel(
        city: json["city"],
       // desiredSkills: json["desiredSkills"],
        jobPosition: json["jobPosition"],
        payment: json["payment"],
        workHours: json["workHours"],
        //userApplicantId: json["userApplicantId"],
        userBidderId: json["userBidderId"],
        id: json["id"],
        projectId: json["projectId"],
        accepted: json["accepted"]

      );

  Map<String, dynamic> toJson() => {
    "city": city,
    //"desiredSkills": desiredSkills,
    "jobPosition": jobPosition,
    "payment": payment,
    "workHours": workHours,
   // "userApplicantId": userApplicantId,
    "userBidderId": userBidderId,
    "id": id,
    "projectId": projectId,
    "accepted": accepted
  };
}
