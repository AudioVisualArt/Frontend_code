import 'dart:convert';

import 'package:Clapp/src/Finance/Model/Finance.dart';
import 'package:Clapp/src/Finance/pages/finances.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class FinancesProvider extends InheritedWidget {
  final String _url = utils.url;

  static FinancesProvider _instancia;

  factory FinancesProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new FinancesProvider._internal(key: key, child: child);
    }
    return _instancia;
  }
  FinancesProvider._internal({ Key key, Widget child})
      : super(key: key , child: child);


  Future<List<FinanceModel>> cargarFinanzas(idProject) async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllFinancesProjects/$idProject';
    final rsp = await http.get(url);
    //print(rsp.body.toString());

    final Iterable decodeData = json.decode(rsp.body);
    List<FinanceModel> finances = new List();
    if (decodeData == null) return [];

    finances =
        decodeData.map((model) => FinanceModel.fromJson(model)).toList();

    return finances;
  }


  @override
  bool updateShouldNotify( InheritedWidget oldWidget) => true;

}