import 'dart:convert';
import 'dart:io';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class EquipmentProvider {
  final String _url = utils.url;

  Future<bool> crearEquipmente(EquipmentModel equipmentModel, File foto) async {
    final url = '$_url/saveEquipment';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('Producto');

    final StorageUploadTask uploadTask =
        postImageRef.child(equipmentModel.titulo).putFile(foto);

    final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL Image : ' + imageUrl);

    equipmentModel.fotoUrl = imageUrl;

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: equipmentModelToJson(equipmentModel));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarEquipment(EquipmentModel equipmentModel, File foto) async {
    final url = '$_url/updateEquipment${equipmentModel.id}.json';

    if (foto != null) {
      if (equipmentModel.fotoUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(equipmentModel.fotoUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('Producto');

      final StorageUploadTask uploadTask =
          postImageRef.child(equipmentModel.titulo).putFile(foto);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      equipmentModel.fotoUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: equipmentModelToJson(equipmentModel));

    print('Edit 1: ${resp.body.trim()}');

    final decodeData = json.decode(resp.body);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<EquipmentModel>> cargarEquipments() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllEquipments';
    final rsp = await http.get(url);
    print('Equipments: ' + rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<EquipmentModel> equipmentModels = new List();
    if (decodeData == null) return [];

    equipmentModels =
        decodeData.map((model) => EquipmentModel.fromJson(model)).toList();

    return equipmentModels;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/deleteEquipment/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}
