import 'dart:convert';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';

import 'package:http/http.dart' as http;
import 'file:///E:/Tesis_Code/Clapp/lib/src/item/model/producto_models.dart';

class ProductosProvider {
  final String _url = 'https://clappauth.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/productos/${producto.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final rsp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(rsp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
      //print(productos[0].titulo);
    });

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final rsp = await http.delete(url);

    print(json.decode(rsp.body));

    return 1;
  }
}
