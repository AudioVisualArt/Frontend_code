import 'dart:convert';
import 'dart:math';

import 'dart:io';
import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    final rsp = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8'
    });
    print(rsp.body);
    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<SpaceModel> espacios = new List();
    if (decodeData == null) return [];

    espacios = decodeData.map((model) => SpaceModel.fromJson(model)).toList();

    return espacios;
  }

  Future<String> crearEspacio(SpaceModel espacio, File foto) async {
    final url = '$_url/saveSpace';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('Space');

    final StorageUploadTask uploadTask =
        postImageRef.child(espacio.name).putFile(foto);

    final imagenUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL Space image es: ' + imagenUrl);

    espacio.imageUrl = imagenUrl;

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: SpaceModelToJson(espacio));

    print(resp.statusCode);

    return imagenUrl;
  }

  Future<bool> editarEspacio(SpaceModel espacio, File foto) async {
    final url = '$_url/updateSpace/${espacio.id}';

    if (foto != null) {
      if (espacio.imageUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(espacio.imageUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('Space');

      final StorageUploadTask uploadTask =
          postImageRef.child(espacio.name).putFile(foto);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      espacio.imageUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: SpaceModelToJson(espacio));

    final decodeData = json.decode(resp.body);

    return true;
  }
  Future<List<SpaceModel>> cargarEspaciosUsuario(idUsuario) async {

    final url = '$_url/getAllSpacesUser/$idUsuario';
    print("la url que se trata de acceder es: $url");
    final rsp = await http.get(url);
    //print(rsp.body.toString());

    final Iterable decodeData = json.decode(rsp.body);
    List<SpaceModel> spaces = new List();
    if (decodeData == null) return [];

    spaces =
        decodeData.map((model) => SpaceModel.fromJson(model)).toList();

    return spaces;
  }
}
