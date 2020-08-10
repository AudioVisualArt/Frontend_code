import 'package:Clapp/src/User/models/producto_models.dart';
import 'package:Clapp/src/User/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class MostrarProductosPage extends StatefulWidget {
  @override
  _MostrarProductosPageState createState() => _MostrarProductosPageState();
}

class _MostrarProductosPageState extends State<MostrarProductosPage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Productos en FireBase'),
      ),
      body: _crearListado(),
    ));
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) =>
                _crearItem(context, productos[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto) {
    return ListTile(
      title: Text('${producto.titulo} - ${producto.valor}'),
      subtitle: Text(producto.id),
      onTap: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}
