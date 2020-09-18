import 'dart:convert';

import 'dart:ffi';

import 'package:Clapp/src/item/model/item_models.dart';

StockPhotoModel stockPhotoModelFromJson(String str) =>
    StockPhotoModel.fromJson(json.decode(str));

String stockPhotoModelToJson(StockPhotoModel data) =>
    json.encode(data.toJson());

class StockPhotoModel extends ItemModel {
  StockPhotoModel({
    this.photoType,
    this.width,
    this.height,
  }) : super();

  String photoType;
  Float width;
  Float height;

  StockPhotoModel.fromJson(Map<String, dynamic> json)
      : photoType = json["photoType"],
        width = json["width"].toDouble(),
        height = json["height"].toDouble(),
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "titulo": titulo,
        "valor": valor,
        "id": id,
        "fotoUrl": fotoUrl,
        "itemDescription": itemDescription,
        "idOwner": idOwner,
        "photoType": photoType,
        "width": width,
        "height": height,
      };
}
