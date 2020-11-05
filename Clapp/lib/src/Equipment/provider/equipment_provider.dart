import 'dart:convert';
import 'dart:io';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class EquipmentProvider {
  final String _url = utils.url;

  ActividadProvider actividadProvider = ActividadProvider();
  Future<bool> crearEquipmente(EquipmentModel equipmentModel, File foto) async {
    final url = '$_url/saveEquipment';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('Equipment');

    final StorageUploadTask uploadTask =
        postImageRef.child(equipmentModel.titulo).putFile(foto);

    final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL Image: ' + imageUrl);

    equipmentModel.fotoUrl = imageUrl;
    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: equipmentModelToJson(equipmentModel));

    print(resp.statusCode);
    print("ACTIVIDAD");
    ActividadModel activity = new ActividadModel(
        descripcion: "Has publicado un nuevo equipo",
        fecha: DateTime.now().toString(),
        tipo: "Equipo",
        contenido:
            "${equipmentModel.titulo},${equipmentModel.marca},${equipmentModel.valor}",
        photoUrl: equipmentModel.fotoUrl);
    print("QUE PASA ${activity.contenido}");

    actividadProvider.crearActividad(activity, equipmentModel.idOwner);
    return true;
  }

  Future<bool> editarEquipment(EquipmentModel equipmentModel, File foto) async {
    final url = '$_url/updateEquipment/${equipmentModel.id}';

    if (foto != null) {
      if (equipmentModel.fotoUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(equipmentModel.fotoUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('Equipment');

      final StorageUploadTask uploadTask =
          postImageRef.child(equipmentModel.titulo).putFile(foto);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      equipmentModel.fotoUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: equipmentModelToJson(equipmentModel));

    print('Edit1: ${resp.body.trim()}');

    String source = Utf8Decoder().convert(resp.bodyBytes);

    final Iterable decodeData = json.decode(source);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<EquipmentModel>> cargarEquipments() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllEquipments';
    final rsp = await http.get(url);
    print('Equipments: ' + rsp.body);

    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<EquipmentModel> equipmentModels = new List();
    if (decodeData == null) return [];

    equipmentModels =
        decodeData.map((model) => EquipmentModel.fromJson(model)).toList();

    return equipmentModels;
  }

  Future<List<EquipmentModel>> cargarEquipmentsUser(String id) async {
    final url = '$_url/getAllEquipments';
    final rsp = await http.get(url);

    final Iterable decodeData = json.decode(rsp.body);
    List<EquipmentModel> equipmentModels = new List();
    List<EquipmentModel> equipmentModelsUser = new List();
    if (decodeData == null) return null;

    equipmentModels =
        decodeData.map((model) => EquipmentModel.fromJson(model)).toList();

    equipmentModels.forEach((element) {
      if (element.idOwner == id) {
        print(id + " - " + element.idOwner);
        equipmentModelsUser.add(element);
      }
    });

    return equipmentModelsUser;
  }

  Future<List<EquipmentModel>> cargarEquipmentsNotSessionUser(String id) async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllEquipments';
    final rsp = await http.get(url);
    //print('Equipments: ' + rsp.body);

    List<EquipmentModel> equipmentModelsMarket = new List();
    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<EquipmentModel> equipmentModels = new List();
    if (decodeData == null) return [];

    equipmentModels =
        decodeData.map((model) => EquipmentModel.fromJson(model)).toList();

    for (var item in equipmentModels) {
      print(item.idOwner.compareTo(id));
      if (item.idOwner.compareTo(id) != 0) {
        equipmentModelsMarket.add(item);
      }
    }
    return equipmentModelsMarket;
  }

  Future<List<EquipmentModel>> cargarEquipmentsNotSessionUserRent(
      String id) async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllEquipments';
    final rsp = await http.get(url);
    //print('Equipments: ' + rsp.body);

    List<EquipmentModel> equipmentModelsMarket = new List();
    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<EquipmentModel> equipmentModels = new List();
    if (decodeData == null) return [];

    equipmentModels =
        decodeData.map((model) => EquipmentModel.fromJson(model)).toList();

    for (var item in equipmentModels) {
      print(item.idOwner.compareTo(id));
      if (item.idOwner.compareTo(id) != 0 && item.rent) {
        equipmentModelsMarket.add(item);
      }
    }
    return equipmentModelsMarket;
  }

  Future<List<EquipmentModel>> cargarEquipmentsNotSessionUserByTag(
      String id, String etiqueta, String marca) async {
    //print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllEquipments';
    final rsp = await http.get(url);
    //print('Equipments: ' + rsp.body);

    List<EquipmentModel> equipmentModelsMarket = new List();
    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<EquipmentModel> equipmentModels = new List();
    if (decodeData == null) return [];

    equipmentModels =
        decodeData.map((model) => EquipmentModel.fromJson(model)).toList();

    for (var item in equipmentModels) {
      print('Marca Equipo: ' +
          item.marca.toString() +
          ' Etiquita:' +
          marca.toString());
      if (item.tag.trim() == etiqueta.trim() &&
          item.marca.toUpperCase().trim() == marca) {
        equipmentModelsMarket.add(item);
      }
    }
    return equipmentModelsMarket;
  }

  Future<int> borrarProducto(EquipmentModel equipmentModel) async {
    final url = '$_url/deleteEquipment/${equipmentModel.id.toString()}';
    await FirebaseStorage.instance
        .getReferenceFromUrl(equipmentModel.fotoUrl)
        .then((value) => value.delete());
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}
