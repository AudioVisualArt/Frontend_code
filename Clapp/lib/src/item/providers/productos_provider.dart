import 'dart:convert';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';

import 'package:http/http.dart' as http;
import 'file:///E:/Tesis_Code/Clapp/lib/src/item/model/item_models.dart';

class ProductosProvider {
  final String _url = 'http://192.168.0.12:8080';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ItemModel producto) async {
    final url = '$_url/saveItem';

    final resp = await http.post(url,headers: <String, String>{
      'Content-Type': 'application/json',
    },body: itemModelToJson(producto));

    print(resp.statusCode);

    return true;
  }

  Future<bool> editarProducto(ItemModel producto) async {
    final url = '$_url/updateItem/${producto.id}';

    final resp = await http.put(url,headers: <String, String>{
    'Content-Type': 'application/json'}, body: itemModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

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
