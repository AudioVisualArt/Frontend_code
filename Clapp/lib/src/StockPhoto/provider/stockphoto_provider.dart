import 'dart:convert';
import 'dart:io';

import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class StockPhotoProvider {
  final String _url = utils.url;
  ActividadProvider actividadProvider = ActividadProvider();
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

    ActividadModel activity = new ActividadModel(
        descripcion: "Has publicado una nueva foto",
        fecha: DateTime.now().toString(),
        tipo: "Photo",
        contenido:
            "${stockPhotoModel.titulo},${stockPhotoModel.photoType},${stockPhotoModel.valor}",
        photoUrl: stockPhotoModel.fotoUrl);
    actividadProvider.crearActividad(activity, stockPhotoModel.idOwner);

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

  Future<List<StockPhotoModel>> cargarPhotosNotSessionUser(String id) async {
    final url = '$_url/getAllPhotos';
    final rsp = await http.get(url);

    final Iterable decodeData = json.decode(rsp.body);
    List<StockPhotoModel> stockPhotosModels = new List();
    List<StockPhotoModel> stockPhotosModelsMarket = new List();
    if (decodeData == null) return [];

    stockPhotosModels =
        decodeData.map((model) => StockPhotoModel.fromJson(model)).toList();

    stockPhotosModels.forEach((element) {
      print(element.idOwner.compareTo(id));
      if (element.idOwner.compareTo(id) != 0) {
        stockPhotosModelsMarket.add(element);
      }
    });

    return stockPhotosModelsMarket;
  }

  Future<List<StockPhotoModel>> cargarPhotosUser(String id) async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllPhotos';
    final rsp = await http.get(url);
    //print('Photos: ' + rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<StockPhotoModel> stockPhotosModels = new List();
    List<StockPhotoModel> stockPhotosModelsUser = new List();
    if (decodeData == null) return [];

    stockPhotosModels =
        decodeData.map((model) => StockPhotoModel.fromJson(model)).toList();

    stockPhotosModels.forEach((element) {
      if (element.idOwner == id) {
        print(id + " - " + element.idOwner);
        stockPhotosModelsUser.add(element);
      }
    });

    return stockPhotosModelsUser;
  }

  Future<int> borrarFoto(StockPhotoModel stockPhotoModel) async {
    final url = '$_url/deletePhoto/${stockPhotoModel.id.toString()}';
    await FirebaseStorage.instance
        .getReferenceFromUrl(stockPhotoModel.fotoUrl)
        .then((value) => value.delete());
    final rsp = await http.delete(url);

    return 1;
  }
}
