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
    this.rent = false,
    this.sell = true,
  }) : super();

  String specs;
  String marca;
  String modelo;
  bool rent;
  bool sell;

  EquipmentModel.fromJson(Map<String, dynamic> json)
      : specs = json["specs"],
        marca = json["marca"],
        modelo = json["modelo"],
        rent = json["rent"],
        sell = json["sell"],
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
        "rent": rent,
        "sell": sell,
      };
}
