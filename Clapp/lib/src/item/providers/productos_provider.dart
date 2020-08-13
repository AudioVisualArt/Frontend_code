import 'dart:convert';
import 'package:Clapp/src/User/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'file:///E:/Tesis_Code/Clapp/lib/src/item/model/producto_models.dart';

class ProductosProvider {
  final String _url = 'http://192.168.0.12:8080';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/saveProduct';

    final resp = await http.post(url,headers: <String, String>{
      'Content-Type': 'application/json',
    },body: productoModelToJson(producto));

    return true;
  }

  Future<bool> editarProducto(ProductoModel producto) async {
    final url = '$_url/getAllProducts/${producto.id}';

    final resp = await http.put(url,headers: <String, String>{
    'Content-Type': 'application/json'}, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    print("la url que se trata de acceder es: $_url");
    final url = '$_url/getAllProducts';
    print("la url que se trata de acceder es: $url");
    final rsp = await http.get(url);
    print(rsp.body);

    final Iterable decodeData = json.decode(rsp.body);
    List<ProductoModel> productos = new List();
    print("el json es: $decodeData");
    if (decodeData == null) return [];
    print("el json es: $decodeData");

    productos = decodeData.map((model) => ProductoModel.fromJson(model)).toList();
    /*decodeData.forEach((prod) {
      ProductoModel prodTemp = ProductoModel.fromJson(prod);
      print("el producto: $prodTemp");
      //prodTemp.id = id;
      productos.add(prodTemp);
      print(productos[0].titulo);
    });*/

    return productos;
  }

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final rsp = await http.delete(url);

    print(json.decode(rsp.body));

    return 1;
  }
}
