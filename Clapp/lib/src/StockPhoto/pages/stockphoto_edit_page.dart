import 'dart:io';

import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/StockPhoto/provider/stockphoto_provider.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class StockPhotoEditPage extends StatefulWidget {
  StockPhotoEditPage({Key key}) : super(key: key);

  @override
  _StockPhotoEditPageState createState() => _StockPhotoEditPageState();
}

class _StockPhotoEditPageState extends State<StockPhotoEditPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  StockPhotoModel stockPhoto = new StockPhotoModel();
  final stockPhotoProvider = new StockPhotoProvider();

  bool _guardando = false;

  bool _equipo = false;

  File foto;
  @override
  Widget build(BuildContext context) {
    StockPhotoModel stockPhotoData = ModalRoute.of(context).settings.arguments;
    stockPhoto = stockPhotoData;

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
            'Equipo',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
            textAlign: TextAlign.center,
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
                  Divider(),
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearTypePhoto(),
                  Divider(),
                  _crearWidth(),
                  Divider(),
                  _crearHeigth(),
                  Divider(),
                  _crearPrecio(),
                  Divider(),
                  _crearDisponible(),
                  Divider(),
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
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: stockPhoto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre de tu Foto',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => stockPhoto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de tu Foto correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: stockPhoto.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción Simple',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => stockPhoto.itemDescription = value,
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
      initialValue: stockPhoto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => stockPhoto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearTypePhoto() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: stockPhoto.photoType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Tipo de Foto?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => stockPhoto.photoType = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa un tipo de Foto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearWidth() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: stockPhoto.width.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Ancho de tu Foto?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => stockPhoto.width = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearHeigth() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: stockPhoto.height.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Modelo de tu Equipo?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => stockPhoto.height = double.parse(value),
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
      value: stockPhoto.disponible,
      title: Text(
        'Disponible',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      activeColor: Color.fromRGBO(153, 255, 204, 1.0),
      onChanged: (value) => setState(() {
        stockPhoto.disponible = value;
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

    stockPhotoProvider.editarPhoto(stockPhoto, foto);

    mostrarSnackbar('Registro Guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snacckbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 3),
    );

    scaffoldKey.currentState.showSnackBar(snacckbar);
  }

  Widget _mostrarFoto() {
    print('FotoURL: ' + stockPhoto.fotoUrl);
    if (stockPhoto.fotoUrl.isEmpty || stockPhoto.fotoUrl == null) {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else if (stockPhoto.fotoUrl != null || stockPhoto.fotoUrl.isNotEmpty) {
      if (foto != null) {
        return Image(
          image: AssetImage(foto.path),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          image: NetworkImage(stockPhoto.fotoUrl),
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
