import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/item/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class MostrarProductosPage extends StatefulWidget {
  MostrarProductosPage();
  @override
  _MostrarProductosPageState createState() => _MostrarProductosPageState();
}

class _MostrarProductosPageState extends State<MostrarProductosPage> {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final idUsuario = ModalRoute.of(context).settings.arguments;

    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Productos',
            style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                _crearListado();
              });
            },
          ),
        ],
      ),
      body: _crearListado(),
    ));
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
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

  Widget _crearItem(BuildContext context, ItemModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          productosProvider.borrarProducto(producto.id);
        },
        child: Card(
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}',
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                subtitle: Text(producto.id,
                    style: TextStyle(fontSize: 10.0, fontFamily: "Raleway")),
                leading: Icon(Icons.arrow_forward_ios),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text('Details',
                        style:
                            TextStyle(fontSize: 15.0, fontFamily: "Raleway")),
                    onPressed: () => Navigator.pushNamed(context, 'producto',
                        arguments: producto),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
