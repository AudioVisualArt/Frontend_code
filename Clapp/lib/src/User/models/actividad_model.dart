import 'dart:convert';

ActividadModel equipmentModelFromJson(String str) =>
    ActividadModel.fromJson(json.decode(str));

String actividadModelToJson(ActividadModel data)=> json.encode(data.toJson());

class ActividadModel{

  String descripcion;
  String fecha;
  String tipo;
  String contenido;
  String photoUrl;
  

  ActividadModel({
    this.descripcion,
    this.fecha,
    this.tipo,
    this.contenido,
    this.photoUrl
});

  factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
    descripcion:json["descripcion"],
    fecha: json["fecha"],
    tipo: json["tipo"],
    contenido: json["contenido"],
    photoUrl: json["photoUrl"]
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "fecha": fecha,
    "tipo": tipo,
    "contenido":contenido,
    "photoUrl":photoUrl
  };
}