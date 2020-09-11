// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ItemModel productoModelFromJson(String str) =>
    ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String id;
  String titulo;
  double valor;
  bool disponible;
  String fotoUrl;
  String itemDescription;
  String idOwner;

  ItemModel({
    this.idOwner,
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoUrl = "",
    this.itemDescription = '',
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => new ItemModel(
        disponible: json["disponible"],
        titulo: json["titulo"],
        valor: json["valor"],
        id: json["id"],
        fotoUrl: json["fotoUrl"],
        itemDescription: json["itemDescription"],
        idOwner: json["idOwner"],
      );

  Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "titulo": titulo,
        "valor": valor,
        "id": id,
        "fotoUrl": fotoUrl,
        "itemDescription": itemDescription,
        "idOwner": idOwner,
      };
}
