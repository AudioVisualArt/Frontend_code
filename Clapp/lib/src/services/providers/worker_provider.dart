import 'dart:convert';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WorkersProvider {
  final String _url = utils.url;
  static WorkersProvider _instancia;

  factory WorkersProvider({Key key, Widget child}) {

    if (_instancia == null) {
      _instancia = new WorkersProvider._internal(key: key , child: child);
    }
    return _instancia;
  }

  WorkersProvider._internal({Key key, Widget child});
  Future<String> crearWorker(WorkerModel trabajador) async {
    final url = '$_url/saveWorker';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: workerModelToJson(trabajador));

    print(resp.body);

    return resp.body;
  }

  Future<bool> editarTrabajador(WorkerModel trabajador) async {
    final url = '$_url/updateWorker/${trabajador.userId}.json';

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: workerModelToJson(trabajador));

    print('Edit 1: ${resp.body.trim()} ');

    final decodeData = json.decode(resp.body);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<WorkerModel>> cargarTrabajadores() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllWorkers';
    final rsp = await http.get(url);
    print(rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<WorkerModel> trabajadores = new List();
    if (decodeData == null) return [];

    trabajadores = decodeData.map((model) => WorkerModel.fromJson(model)).toList();

    return trabajadores;
  }

  Future<int> borrarTrabajador(String id) async {
    final url = '$_url/deleteWorker/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}
