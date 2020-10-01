import 'dart:convert';

import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:Clapp/src/utils/utils.dart' as utils;


class SpacesProvider {
  final String _url = utils.url;
  static SpacesProvider _instancia;

  factory SpacesProvider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new SpacesProvider._internal(key: key, child: child);
    }
    return _instancia;
  }

  SpacesProvider._internal({Key key, Widget child});

  Future<List<SpaceModel>> cargarTrabajadores() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllSpaces';
    final rsp = await http.get(url);
    print(rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<SpaceModel> espacios = new List();
    if (decodeData == null) return [];

    espacios = decodeData.map((model) => SpaceModel.fromJson(model)).toList();

    return espacios;
  }
}