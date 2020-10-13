


import 'dart:convert';

FinanceModel financeModelFromJson(String str) =>
    FinanceModel.fromJson(json.decode(str));

String FinanceModelToJson(FinanceModel data) => json.encode(data.toJson());


class FinanceModel {

  String id;
  String projectId;
  String title;
  double quantity;
  double percentage;

  FinanceModel({
    this.id,
    this.projectId,
    this.title,
    this.quantity,
    this.percentage
});
  factory FinanceModel.fromJson(Map<String, dynamic> json) =>
      new FinanceModel(
         id:json["id"],
        projectId:json["projectId"],
        title:json["title"],
        quantity:json["quantity"],
        percentage:json["percentage"]

      );
  Map<String, dynamic> toJson() => {
    "id":id,
    "projectId": projectId,
    "title": title,
    "quantity":quantity,
    "percentage": percentage
  };
}