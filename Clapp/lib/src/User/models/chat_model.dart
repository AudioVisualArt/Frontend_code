
import 'dart:convert';

import 'package:Clapp/src/User/models/mensaje_model.dart';

ChatModel equipmentModelFromJson(String str) =>
    ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data)=> json.encode(data.toJson());

class ChatModel{
  String chatId;
  String usuarioO;
  String usuarioD;
  String photoUrlD;
  String photoUrlO;
	String nameO;
  String nameD;
  String fecha;
  List<MensajeModel> mensajes;
  

  ChatModel({
    this.chatId,
    this.usuarioO,
    this.usuarioD,
    this.photoUrlO,
    this.photoUrlD,
    this.nameO,
    this.nameD,
    this.fecha,
});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatId: json["chatId"],
    usuarioO: json["usuarioO"],
    usuarioD: json["usuarioD"],
    photoUrlO: json["photoUrlO"],
    photoUrlD: json["photoUrlD"],
    nameO:json["nameO"],
    nameD:json["nameD"],
    fecha: json["fecha"],
  );

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "usuarioO": usuarioO,
    "usuarioD": usuarioD,
    "mensajes": mensajes,
    "photoUrlO":photoUrlO,
    "photoUrlD":photoUrlD,
    "nameO":nameO,
    "nameD":nameD,
    "fecha":fecha
  };

}