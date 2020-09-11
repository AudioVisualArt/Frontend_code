import 'dart:convert';

import 'package:Clapp/src/item/model/item_models.dart';

EquipmentModel equipmentModelFromJson(String str) =>
    EquipmentModel.fromJson(json.decode(str));

String equipmentModelToJson(EquipmentModel data) => json.encode(data.toJson());

class EquipmentModel extends ItemModel {
  EquipmentModel({
    this.specs,
    this.marca,
    this.modelo,
  });

  String specs;
  String marca;
  String modelo;

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
        specs: json["specs"],
        marca: json["marca"],
        modelo: json["modelo"],
      );

  Map<String, dynamic> toJson() => {
        "specs": specs,
        "marca": marca,
        "modelo": modelo,
      };
}
