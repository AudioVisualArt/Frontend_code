import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/item/providers/productos_provider.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  ItemModel producto = new ItemModel();

  bool _guardando = false;

  File foto;

  final productoProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final ItemModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Agrega un Item',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _crearNombre(),
                  _crearDescripcion(),
                  _crearPrecio(),
                  _crearDisponible(),
                  _crearBoton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre de tu Item',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del item correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      initialValue: producto.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción Simple',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => producto.itemDescription = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa un pequeña descripción';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text(
        'Disponible',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      activeColor: Color.fromRGBO(153, 255, 204, 1.0),
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),
      textColor: Colors.white,
      label: Text(
        'Guardar',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print('Todo Ok');

    setState(() {
      _guardando = true;
    });

    if (producto.id == null) {
      productoProvider.crearProducto(producto, foto);
    } else {
      productoProvider.editarProducto(producto);
    }

    mostrarSnackbar('Registro Guardado');
    Duration(milliseconds: 40000);
    Navigator.pushReplacementNamed(context, 'producto');
  }

  void mostrarSnackbar(String mensaje) {
    final snacckbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snacckbar);
  }

  Widget _mostrarFoto() {
    print('FotoURL: ' + producto.fotoUrl);
    if (producto.fotoUrl.isEmpty || producto.fotoUrl == null) {
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        height: 300.0,
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
          image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
          height: 300.0,
          fit: BoxFit.cover,
        );
      }
    }
  }

  _seleccionarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (foto != null) {
      //limpiar

    }
    setState(() {});
  }

  _tomarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.camera);

    if (foto == null) {
      //limpiar
      setState(() {});
    }
  }
}
