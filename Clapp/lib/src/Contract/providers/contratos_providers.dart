import 'dart:convert';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';
import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class ContratosProvider {
  final String _url = utils.url;
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearContrato(ContractModel contrato) async {
    final url = '$_url/saveContract';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: ContractModelToJson(contrato));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarContrato(ContractModel contrato) async {
    final url = '$_url/updateContract/${contrato.id}';

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: ContractModelToJson(contrato));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<ContractModel>> cargarContratosPropietario(String idUsuario) async {
    print("la url que se trata de acceder es: $_url");
    print("con el id usuario: $idUsuario");
    final url = '$_url/getAllContractsBidder/$idUsuario';
    final rsp = await http.get(url);
    print(rsp.body);

    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<ContractModel> contratos = new List();
    if (decodeData == null) return [];

    contratos = decodeData.map((model) => ContractModel.fromJson(model)).toList();

    return contratos;
  }

  Future<int> borrarContrato(String id) async {
    final url = '$_url/deleteContract/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }

  Future<List<ContractModel>> cargarContratosProoyecto(String idProyecto) async {
    print("la url que se trata de acceder es: $_url");
    print("con el id usuario: $idProyecto");
    final url = '$_url/getAllContractsProject/$idProyecto';
    final rsp = await http.get(url);
    print(rsp.body);
    String source = Utf8Decoder().convert(rsp.bodyBytes);
    final Iterable decodeData = json.decode(source);
    List<ContractModel> contratos = new List();
    if (decodeData == null) return [];

    contratos = decodeData.map((model) => ContractModel.fromJson(model)).toList();

    return contratos;
  }

  Future<List<ContractModel>> cargarContratosOfrecidos(String idUsuario)async {
    print("la url que se trata de acceder es: $_url");
    print("con el id usuario: $idUsuario");
    final url = '$_url/getAllContractsRecibed/$idUsuario';
    final rsp = await http.get(url);
    print(rsp.body);
    String source = Utf8Decoder().convert(rsp.bodyBytes);
    final Iterable decodeData = json.decode(source);
    List<ContractModel> contratos = new List();
    if (decodeData == null) return [];

    contratos = decodeData.map((model) => ContractModel.fromJson(model)).toList();

    return contratos;
  }
}