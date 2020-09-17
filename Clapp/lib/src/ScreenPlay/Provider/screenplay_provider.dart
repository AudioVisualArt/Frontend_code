import 'dart:convert';
import 'dart:io';
import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:http/http.dart' as http;

import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';

class ScreenPlayProvider {
  final String _url = utils.url;

  Future<bool> crearScreenPlay(
      ScreenPlayModel screenplayModel, File screenplay) async {
    final url = '$_url/saveScreen';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('ScreenPlay');

    final StorageUploadTask uploadTask =
        postImageRef.child(screenplayModel.titulo).putFile(screenplay);

    final screenplayUrl =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL ScreenPlay: ' + screenplayUrl);

    screenplayModel.fotoUrl = screenplayUrl;

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: screenPlayModelToJson(screenplayModel));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarScreenPlay(
      ScreenPlayModel screenplayModel, File screenplay) async {
    final url = '$_url/updateScreen/${screenplayModel.id}';

    if (screenplay != null) {
      if (screenplayModel.fotoUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(screenplayModel.fotoUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('ScreenPlay');

      final StorageUploadTask uploadTask =
          postImageRef.child(screenplayModel.titulo).putFile(screenplay);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      screenplayModel.fotoUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: screenPlayModelToJson(screenplayModel));

    print('Edit1: ${resp.body.trim()}');

    final decodeData = json.decode(resp.body);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<ScreenPlayModel>> cargarScreenPlays() async {
    final url = '$_url/getAllScreen';
    final rsp = await http.get(url);
    print('ScreenPlays: ' + rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<ScreenPlayModel> screenplayModels = new List();
    if (decodeData == null) return [];

    screenplayModels =
        decodeData.map((model) => ScreenPlayModel.fromJson(model)).toList();

    return screenplayModels;
  }

  Future<int> borrarScreenPlay(String id) async {
    final url = '$_url/deleteEquipment/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}
