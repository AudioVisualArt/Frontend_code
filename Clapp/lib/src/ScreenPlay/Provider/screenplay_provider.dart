import 'dart:convert';
import 'dart:io';
import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ScreenPlayProvider {
  final String _url = utils.url;

  Future<StorageUploadTask> crearScreenPlay(
      ScreenPlayModel screenplayModel, PlatformFile screenplay) async {
    final url = '$_url/saveScreen';

    String fileName;
    String filePath;
    String extensionFile;

    fileName = screenplay.path.split('/').last;
    filePath = screenplay.path;
    extensionFile = fileName.split('.').last;

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('ScreenPlay');

    final StorageUploadTask uploadTask =
        postImageRef.child(screenplayModel.titulo).putFile(
              File(filePath),
              StorageMetadata(
                contentType: '${FileType.any}/$extensionFile',
              ),
            );

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

    return uploadTask;
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

    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<ScreenPlayModel> screenplayModels = new List();
    if (decodeData == null) return [];

    screenplayModels =
        decodeData.map((model) => ScreenPlayModel.fromJson(model)).toList();

    return screenplayModels;
  }

  Future<List<ScreenPlayModel>> cargarScreenPlaysNotSessionUser(
      String id) async {
    final url = '$_url/getAllScreen';
    final rsp = await http.get(url);
    print('ScreenPlays: ' + rsp.body);

    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<ScreenPlayModel> screenplayModels = new List();
    List<ScreenPlayModel> screenplayModelsMarket = new List();
    if (decodeData == null) return [];

    screenplayModels =
        decodeData.map((model) => ScreenPlayModel.fromJson(model)).toList();

    screenplayModels.forEach((element) {
      print(element.idOwner.compareTo(id));
      if (element.idOwner.compareTo(id) != 0) {
        screenplayModelsMarket.add(element);
      }
    });

    return screenplayModelsMarket;
  }

  Future<int> borrarScreenPlay(ScreenPlayModel screenplayModel) async {
    final url = '$_url/deleteScreen/${screenplayModel.id.toString()}';
    await FirebaseStorage.instance
        .getReferenceFromUrl(screenplayModel.fotoUrl)
        .then((value) => value.delete());
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }

  Future<File> createFileOfPdfUrl(ScreenPlayModel screenPlayModel) async {
    final url = screenPlayModel.fotoUrl;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
