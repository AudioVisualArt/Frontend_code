import 'dart:convert';

import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class EquipmentProvider {
  final String _url = utils.url;

  Future<bool> crearContract(ContractModel contractModel) async {
    final url = '$_url/saveContract';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: ContractModelToJson(contractModel));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarContract(ContractModel contractModel) async {

    final url = '$_url/updateContract${contractModel.id}.json';

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: ContractModelToJson(contractModel));

    print('Edit 1: ${resp.body.trim()} ');

    final decodeData = json.decode(resp.body);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<ContractModel>> cargarContracts() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllContracts';
    final rsp = await http.get(url);
    print(rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<ContractModel> contractModels = new List();
    if (decodeData == null) return [];

    contractModels =
        decodeData.map((model) => ContractModel.fromJson(model)).toList();

    return contractModels;
  }

  Future<int> borrarContract(String id) async {
    final url = '$_url/deleteContract/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }


}
