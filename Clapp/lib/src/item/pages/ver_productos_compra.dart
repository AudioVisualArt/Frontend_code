import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/item/providers/productos_provider.dart';

class MostrarProductosCompraPage extends StatefulWidget {
  MostrarProductosCompraPage({Key key}) : super(key: key);

  @override
  _MostrarProductosCompraPageState createState() =>
      _MostrarProductosCompraPageState();
}

class _MostrarProductosCompraPageState
    extends State<MostrarProductosCompraPage> {
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
    final _screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;

          return Container(
            child: Swiper(
              itemCount: 3,
              layout: SwiperLayout.STACK,
              itemWidth: _screenSize.width * 0.7,
              itemHeight: _screenSize.height * 0.51,
              itemBuilder: (context, index) => ClipRRect(
                child: _crearItem(context, productos[index]),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ItemModel producto) {
    return Card(
      color: Color.fromRGBO(89, 122, 121, 1.0),
      elevation: 20.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          _itemFoto(context, producto),
          // ListTile(
          //   title: Text('${producto.titulo} - ${producto.valor}',
          //       style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
          //   subtitle: Text(producto.id,
          //       style: TextStyle(fontSize: 10.0, fontFamily: "Raleway")),
          //   leading: Icon(Icons.arrow_forward_ios),
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            height: 40.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(1.0),
                  child: Text('Details',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Raleway",
                          color: Colors.white)),
                  onPressed: () => Navigator.pushNamed(context, 'producto',
                      arguments: producto),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _itemFoto(BuildContext context, ItemModel producto) {
    final _screenSize = MediaQuery.of(context).size;

    if (producto.fotoUrl.isEmpty || producto.fotoUrl == null) {
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        height: _screenSize.height * 0.45,
        width: _screenSize.width * 0.7,
        fit: BoxFit.cover,
      );
    } else {
      if (producto.fotoUrl != null) {
        return FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          image: NetworkImage(producto.fotoUrl),
        );
      } else {
        return Image(
          image: AssetImage('assets/img/no-image.png'),
          height: 5.0,
          width: _screenSize.width * 0.2,
          fit: BoxFit.cover,
        );
      }
    }
  }
}
