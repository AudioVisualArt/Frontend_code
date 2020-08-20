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

  ItemModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoUrl="",
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      new ItemModel(
        disponible: json["disponible"],
        titulo: json["titulo"],
        valor: json["valor"],
        id: json["id"],
        fotoUrl: json["fotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "titulo": titulo,
        "valor": valor,
        "id": id,
        "fotoUrl": fotoUrl,
      };
}
