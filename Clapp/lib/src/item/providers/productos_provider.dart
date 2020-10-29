import 'dart:convert';
import 'dart:io';

import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = utils.url;

  Future<Map> crearProducto(ItemModel producto, File foto) async {
    final url = '$_url/saveItem';

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child('Producto');

    final StorageUploadTask uploadTask =
        postImageRef.child(producto.titulo).putFile(foto);

    final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    print('URL Image: ' + imageUrl);

    producto.fotoUrl = imageUrl;

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: itemModelToJson(producto));

    print(resp.statusCode);

    return {'ok': true, 'fotoUrl': imageUrl};
  }

  Future<bool> editarProducto(ItemModel producto, File foto) async {
    final url = '$_url/updateItem/${producto.id}';

    if (foto != null) {
      if (producto.fotoUrl.isNotEmpty) {
        final delete = (await FirebaseStorage.instance
            .getReferenceFromUrl(producto.fotoUrl)
            .then((value) => value.delete()));
      }
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child('Producto');

      final StorageUploadTask uploadTask =
          postImageRef.child(producto.titulo).putFile(foto);

      final imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

      producto.fotoUrl = imageUrl;
    }

    final resp = await http.put(url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: itemModelToJson(producto));

    print('Edit 1: ${resp.body.trim()} ');

    final decodeData = json.decode(resp.body);

    print('Edit: $decodeData');

    return true;
  }

  Future<List<ItemModel>> cargarProductos() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllItems';
    final rsp = await http.get(url);
    print(rsp.body);
    String source = Utf8Decoder().convert(rsp.bodyBytes);

    final Iterable decodeData = json.decode(source);
    List<ItemModel> productos = new List();
    if (decodeData == null) return [];

    productos = decodeData.map((model) => ItemModel.fromJson(model)).toList();

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/deleteItem/$id';
    final rsp = await http.delete(url);

    //print(json.decode(rsp.body));

    return 1;
  }
}
