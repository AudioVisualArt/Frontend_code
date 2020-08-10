import 'package:flutter/material.dart';

import 'package:Clapp/src/User/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      //Ejemplo Rest Api Firebase
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(50.0),
          child: _crearBotones(context),
        ),
      ),
    );
  }

  Widget _crearBotones(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          label: Text('Ingresar Producto'),
          textColor: Colors.white,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          color: Color.fromRGBO(89, 122, 121, 1.0),
          onPressed: () => Navigator.pushNamed(context, 'producto'),
        ),
        RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          label: Text('Ver Inventario'),
          textColor: Colors.white,
          icon: Icon(Icons.art_track, color: Colors.white),
          color: Color.fromRGBO(89, 122, 121, 1.0),
          onPressed: () => Navigator.pushNamed(context, 'ver_producto'),
        ),
      ],
    );
  }
}
