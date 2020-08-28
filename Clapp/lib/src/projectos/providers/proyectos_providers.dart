import 'dart:convert';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class ProyectosProvider {
  final String _url = utils.url;
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProyecto(ProjectModel proyecto) async {
    final url = '$_url/saveProject';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: ProjectModelToJson(proyecto));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarProyecto(ProjectModel proyecto) async {
    final url = '$_url/updateProject/${proyecto.id}';

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: ProjectModelToJson(proyecto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<ProjectModel>> cargarProyectos(idUsuario) async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllProjects';
    final rsp = await http.get(url);
    print(rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<ProjectModel> proyectos = new List();
    if (decodeData == null) return [];

    proyectos = decodeData.map((model) => ProjectModel.fromJson(model)).toList();

    return proyectos;
  }

  Future<int> borrarProyectos(String id) async {
    final url = '$_url/deleteProjects/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}