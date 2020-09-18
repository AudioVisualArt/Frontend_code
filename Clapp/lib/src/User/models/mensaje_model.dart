
import 'dart:convert';

MensajeModel equipmentModelFromJson(String str) =>
    MensajeModel.fromJson(json.decode(str));

String messageModelToJson(MensajeModel data)=> json.encode(data.toJson());

class MensajeModel{

  String chatid;
  String usuario;
  String fecha;
  String contenido;
  int cont;
  

  MensajeModel({
    this.chatid,
    this.usuario,
    this.fecha,
    this.contenido,
    this.cont
});

  factory MensajeModel.fromJson(Map<String, dynamic> json) => MensajeModel(
    chatid:json["chatid"],
    usuario: json["usuario"],
    fecha: json["fecha"],
    contenido: json["contenido"],
    cont:json["cont"],
  );

  Map<String, dynamic> toJson() => {
    "chatid": chatid,
    "usuario": usuario,
    "fecha": fecha,
    "contenido": contenido,
    "cont":cont
  };
}