import 'dart:convert';
import 'dart:io';

import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class StockPhotoProvider {
  final String _url = utils.url;

  Future<bool> crearPhoto(StockPhotoModel stockPhotoModel, File foto) async {
    final url = '$_url/savePhoto';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('StockPhoto');

    final StorageUploadTask uploadTask =
        postImageRef.child(stockPhotoModel.titulo).putFile(foto);

    final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL ImageStock: ' + imageUrl);

    stockPhotoModel.fotoUrl = imageUrl;

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: stockPhotoModelToJson(stockPhotoModel));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarPhoto(StockPhotoModel stockPhotoModel, File foto) async {
    final url = '$_url/updatePhoto/${stockPhotoModel.id}';

    if (foto != null) {
      if (stockPhotoModel.fotoUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(stockPhotoModel.fotoUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('StockPhoto');

      final StorageUploadTask uploadTask =
          postImageRef.child(stockPhotoModel.titulo).putFile(foto);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      stockPhotoModel.fotoUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: stockPhotoModelToJson(stockPhotoModel));

    final decodeData = json.decode(resp.body);

    return true;
  }

  Future<List<StockPhotoModel>> cargarPhotos() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllPhotos';
    final rsp = await http.get(url);
    print('Photos: ' + rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<StockPhotoModel> stockPhotosModels = new List();
    if (decodeData == null) return [];

    stockPhotosModels =
        decodeData.map((model) => StockPhotoModel.fromJson(model)).toList();

    print('Photos: $decodeData');

    return stockPhotosModels;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/deletePhoto/$id';
    final rsp = await http.delete(url);

    return 1;
  }
}
