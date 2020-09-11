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
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Productos',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                _crearListado(_screenSize);
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: _crearListado(_screenSize),
            padding: EdgeInsets.all(4.0),
            height: _screenSize.height * 0.7,
          ),
          _crearBotonAgregar(),
        ],
      ),
    ));
  }

  Widget _crearListado(Size size) {
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
                            TextStyle(fontSize: 13.0, fontFamily: "Raleway")),
                    onPressed: () => Navigator.pushNamed(context, 'producto',
                        arguments: producto),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _crearBotonAgregar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      label: Text('Agregar Item',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
      textColor: Colors.white,
      icon: Icon(
        Icons.add_to_photos,
        color: Colors.white,
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 42.0),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}
