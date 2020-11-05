import 'dart:convert';
import 'dart:io';

import 'package:Clapp/src/Props/Model/prop_model.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class PropProvider {
  final String _url = utils.url;

  Future<bool> crearProp(PropModel propModel, File foto) async {
    final url = '$_url/saveProp';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('props');

    final StorageUploadTask uploadTask =
        postImageRef.child(propModel.titulo).putFile(foto);

    final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL ImageProp: ' + imageUrl);

    propModel.fotoUrl = imageUrl;

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: propModelToJson(propModel));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarProp(PropModel propModel, File foto) async {
    final url = '$_url/updateProp/${propModel.id}';

    if (foto != null) {
      if (propModel.fotoUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(propModel.fotoUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('props');

      final StorageUploadTask uploadTask =
          postImageRef.child(propModel.titulo).putFile(foto);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      propModel.fotoUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: propModelToJson(propModel));

    final decodeData = json.decode(resp.body);

    return true;
  }

  Future<List<PropModel>> cargarProps() async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllProps';
    final rsp = await http.get(url);
    //print('Props: ' + rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<PropModel> propsModels = new List();
    if (decodeData == null) return [];

    propsModels = decodeData.map((model) => PropModel.fromJson(model)).toList();

    //print('Props: $decodeData');

    return propsModels;
  }

  Future<List<PropModel>> cargarPropsNotSessionUser(String id) async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllProps';
    final rsp = await http.get(url);

    final Iterable decodeData = json.decode(rsp.body);
    List<PropModel> propsModels = new List();
    List<PropModel> propsModelsMarket = new List();
    if (decodeData == null) return [];

    propsModels = decodeData.map((model) => PropModel.fromJson(model)).toList();

    propsModels.forEach((element) {
      print(element.idOwner.compareTo(id));
      if (element.idOwner.compareTo(id) != 0) {
        propsModelsMarket.add(element);
      }
    });

    return propsModelsMarket;
  }

  Future<List<PropModel>> cargarPropsUser(String id) async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllProps';
    final rsp = await http.get(url);
    //print('Props: ' + rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<PropModel> propsModels = new List();
    List<PropModel> propsModelsUser = new List();
    if (decodeData == null) return [];

    propsModels = decodeData.map((model) => PropModel.fromJson(model)).toList();

    propsModels.forEach((element) {
      if (element.idOwner == id) {
        print(id + " - " + element.idOwner);
        propsModelsUser.add(element);
      }
    });
    return propsModelsUser;
  }

  Future<int> borrarProp(PropModel propModel) async {
    final url = '$_url/deleteProp/${propModel.id.toString()}';
    await FirebaseStorage.instance
        .getReferenceFromUrl(propModel.fotoUrl)
        .then((value) => value.delete());
    final rsp = await http.delete(url);
    return 1;
  }
}
