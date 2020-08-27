import 'dart:convert';

ProjectModel projectsModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String ProjectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  String contacto;
  List<String> crew;
  //List<String>locations;
  String proyectName;
  String projectType;
  String description;


  ProjectModel({
    this.contacto = "",
    this.crew ,
    this.proyectName = "",
    this.projectType = "",

    this.description = "",


  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      new ProjectModel(
        contacto: json["contacto"],

        crew: json["crew "],
        proyectName: json["proyectName"],
        projectType: json["projectType"],
        description: json["description"],


      );

  Map<String, dynamic> toJson() => {
    "contacto": contacto,

    "crew": crew,
    "proyectName": proyectName,
    "projectType": projectType,

    "description": description,
  };
}
