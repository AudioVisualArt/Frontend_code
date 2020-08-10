import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:Clapp/src/User/models/producto_models.dart';

class ProductosProvider {
  final String _url = 'https://clappauth.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json';
    final rsp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(rsp.body);
    final List<ProductoModel> productos = new List();

    if (decodeData == null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });

    return productos;
  }
}
