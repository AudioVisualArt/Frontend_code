import 'dart:convert';

import 'package:Clapp/src/item/model/item_models.dart';

ScreenPlayModel screenPlayModelFromJson(String str) =>
    ScreenPlayModel.fromJson(json.decode(str));

String screenPlayModelToJson(ScreenPlayModel data) =>
    json.encode(data.toJson());

class ScreenPlayModel extends ItemModel {
  ScreenPlayModel({
    this.topic,
    this.pages,
    this.sinopsis,
  }) : super();

  String topic;
  int pages;
  String sinopsis;

  ScreenPlayModel.fromJson(Map<String, dynamic> json)
      : topic = json["topic"],
        pages = json["pages"],
        sinopsis = json["sinopsis"],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "titulo": titulo,
        "valor": valor,
        "id": id,
        "fotoUrl": fotoUrl,
        "itemDescription": itemDescription,
        "idOwner": idOwner,
        "topic": topic,
        "pages": pages,
        "sinopsis": sinopsis,
      };
}
