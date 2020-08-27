import 'dart:convert';

import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = utils.url;

  Future<bool> crearProducto(ItemModel producto) async {
    final url = '$_url/saveItem';

    final resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: itemModelToJson(producto));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarProducto(ItemModel producto) async {
    final url = '$_url/updateItem/${producto.id}.json';

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

    final Iterable decodeData = json.decode(rsp.body);
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