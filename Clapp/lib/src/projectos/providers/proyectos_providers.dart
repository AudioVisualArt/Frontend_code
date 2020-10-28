import 'dart:convert';
import 'dart:io';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';
import 'package:Clapp/src/projectos/bloc/project_bloc.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<ProjectModel> cargarProyecto(String Idproyecto) async {
    final url = '$_url/getProject/$Idproyecto';
    final rsp = await http.get(url);

    ProjectModel project = ProjectModel.fromJson(json.decode(rsp.body));
    return project;
  }

  Future<StorageUploadTask> editarProyecto(ProjectModel proyecto, PlatformFile resumen_ejecutivo, PlatformFile carpeta_madre) async {
    final url = '$_url/updateProject/${proyecto.id}';

    String fileName;
    String filePath;
    String extensionFile;

    fileName = resumen_ejecutivo.path.split('/').last;
    filePath = resumen_ejecutivo.path;
    extensionFile = fileName.split('.').last;

    final StorageReference postImageRef =
    FirebaseStorage.instance.ref().child('Project_excutive_summary');

    final StorageUploadTask uploadTask =
    postImageRef.child(proyecto.id).putFile(
      File(filePath),
      StorageMetadata(
        contentType: '${FileType.any}/$extensionFile',
      ),
    );

    final excutivesummaryUrl =
    await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL ScreenPlay: ' + excutivesummaryUrl);

    proyecto.executive_summary = excutivesummaryUrl;

    String fileName2;
    String filePath2;
    String extensionFile2;

    fileName2 = carpeta_madre.path.split('/').last;
    filePath2 = carpeta_madre.path;
    extensionFile2 = fileName2.split('.').last;

    final StorageReference postImageRef2 =
    FirebaseStorage.instance.ref().child('Project_main_file');

    final StorageUploadTask uploadTask2 =
    postImageRef2.child(proyecto.id).putFile(
      File(filePath2),
      StorageMetadata(
        contentType: '${FileType.any}/$extensionFile2',
      ),
    );

    final mainFile =
    await (await uploadTask2.onComplete).ref.getDownloadURL();

    print('URL ScreenPlay: ' + excutivesummaryUrl);

    proyecto.main_file = mainFile;



    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: ProjectModelToJson(proyecto));

    final decodeData = resp.body;

    print(decodeData);

    return uploadTask;
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

    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
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

    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
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
