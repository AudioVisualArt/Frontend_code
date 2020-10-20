import 'dart:convert';

ActividadModel equipmentModelFromJson(String str) =>
    ActividadModel.fromJson(json.decode(str));

String actividadModelToJson(ActividadModel data)=> json.encode(data.toJson());

class ActividadModel{

  String descripcion;
  String fecha;
  String tipo;
  

  ActividadModel({
    this.descripcion,
    this.fecha,
    this.tipo,
});

  factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
    descripcion:json["descripcion"],
    fecha: json["fecha"],
    tipo: json["tipo"],
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "fecha": fecha,
    "tipo": tipo,
  };
}