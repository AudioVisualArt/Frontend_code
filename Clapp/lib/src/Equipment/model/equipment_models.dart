import 'dart:convert';

import 'package:Clapp/src/item/model/item_models.dart';
import 'package:flutter/material.dart';

EquipmentModel equipmentModelFromJson(String str) =>
    EquipmentModel.fromJson(json.decode(str));

String equipmentModelToJson(EquipmentModel data) => json.encode(data.toJson());

class EquipmentModel extends ItemModel {
  EquipmentModel({
    this.specs,
    this.marca,
    this.modelo,
  }) : super();

  String specs;
  String marca;
  String modelo;

  EquipmentModel.fromJson(Map<String, dynamic> json)
      : specs = json["specs"],
        marca = json["marca"],
        modelo = json["modelo"],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "titulo": titulo,
        "valor": valor,
        "id": id,
        "fotoUrl": fotoUrl,
        "itemDescription": itemDescription,
        "idOwner": idOwner,
        "specs": specs,
        "marca": marca,
        "modelo": modelo,
      };
}
