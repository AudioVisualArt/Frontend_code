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

  Future<List<SpaceModel>> cargarEspacios() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllSpaces';
    final rsp = await http.get(url,headers: <String, String>{
    'Content-Type': 'application/json; charset=utf-8'});
    print(rsp.body);
    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<SpaceModel> espacios = new List();
    if (decodeData == null) return [];

    espacios = decodeData.map((model) => SpaceModel.fromJson(model)).toList();

    return espacios;
  }
}