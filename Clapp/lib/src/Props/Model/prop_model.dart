import 'dart:convert';

import 'package:Clapp/src/item/model/item_models.dart';

PropModel propModelFromJson(String str) => PropModel.fromJson(json.decode(str));

String propModelToJson(PropModel data) => json.encode(data.toJson());

class PropModel extends ItemModel {
  PropModel({
    this.propType,
    this.propTheme,
  }) : super();

  String propType;
  String propTheme;

  PropModel.fromJson(Map<String, dynamic> json)
      : propType = json["propType"],
        propTheme = json["propTheme"],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        "disponible": disponible,
        "titulo": titulo,
        "valor": valor,
        "id": id,
        "fotoUrl": fotoUrl,
        "itemDescription": itemDescription,
        "idOwner": idOwner,
        "propType": propType,
        "propTheme": propTheme,
      };
}
