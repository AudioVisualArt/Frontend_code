import 'dart:convert';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';
import 'package:Clapp/src/projectos/bloc/project_bloc.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProyectosProvider extends InheritedWidget{
  final String _url = utils.url;

  static ProyectosProvider _instancia;

  factory ProyectosProvider({Key key, Widget child}) {

    if (_instancia == null) {
      _instancia = new ProyectosProvider._internal(key: key , child: child);
    }
    return _instancia;
  }

  ProyectosProvider._internal({ Key key, Widget child})
      : super(key: key , child: child);


  Future<String> crearProyecto(ProjectModel proyecto) async {
    final url = '$_url/saveProject';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: ProjectModelToJson(proyecto));

    print(resp.body);

    return resp.body;
  }

  Future<bool> editarProyecto(ProjectModel proyecto) async {
    final url = '$_url/updateProject/${proyecto.id}';

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: ProjectModelToJson(proyecto));

    final decodeData = resp.body;

    print(decodeData);

    return true;
  }

  Future<List<UserModel>> cargarColaboradores(idProject) async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getCollaborators/$idProject';
    final rsp = await http.get(url);
    //print(rsp.body.toString());

    final Iterable decodeData = json.decode(rsp.body);
    List<UserModel> users = new List();
    if (decodeData == null) return [];

    users =
        decodeData.map((model) => UserModel.fromJson(model)).toList();

    return users;
  }
  Future<WorkerModel> cargarWorkerInfo(idUser) async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getWorkerUserId/$idUser';
    final rsp = await http.get(url);

    WorkerModel worker = WorkerModel.fromJson(json.decode(rsp.body));
    return worker;
  }

  Future<List<ProjectModel>> cargarProyectos(idUsuario) async {

    final url = '$_url/getAllProjectsUser/$idUsuario';
    print("la url que se trata de acceder es: $url");
    final rsp = await http.get(url);
    //print(rsp.body.toString());

    final Iterable decodeData = json.decode(rsp.body);
    List<ProjectModel> proyectos = new List();
    if (decodeData == null) return [];

    proyectos =
        decodeData.map((model) => ProjectModel.fromJson(model)).toList();

    return proyectos;
  }
  Future<List<ProjectModel>> cargarTodosProyectos() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllProjects';
    final rsp = await http.get(url);
    //print(rsp.body.toString());

    final Iterable decodeData = json.decode(rsp.body);
    List<ProjectModel> proyectos = new List();
    if (decodeData == null) return [];

    proyectos =
        decodeData.map((model) => ProjectModel.fromJson(model)).toList();

    return proyectos;
  }


  Future<int> borrarProyectos(String id) async {
    print("se borrara el proyecto con id: $id");
    final url = '$_url/deleteProject/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }

  final projectBloc = ProjectBloc();

  static ProjectBloc of (BuildContext context){

    return context.dependOnInheritedWidgetOfExactType<ProyectosProvider>().projectBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}
