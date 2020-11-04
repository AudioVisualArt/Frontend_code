import 'dart:io';

import 'package:Clapp/src/Space/pages/mostrar_dialog.dart';
import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/StockPhoto/provider/stockphoto_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';
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
  bool _loading = false;
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
                  Divider(),
                  _loading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(0, 51, 51, 1.0),
                        ))
                      : Container(
                          height: 0.0,
                          width: 0.0,
                        ),
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

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print('Todo Ok');

    setState(() {
      _guardando = true;
      _loading = true;
    });

    await stockPhotoProvider.editarPhoto(stockPhoto, foto);
    setState(() {
      _loading = false;
    });

    MostrarDialog(context, 'Foto Actualizada en Clapp !!!',
        'Has Actualizado la foto ${stockPhoto.titulo}');
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
    final _picker = ImagePicker();
    FocusScope.of(context).requestFocus(new FocusNode());
    if (Platform.isAndroid) {
      try {
        FilePickerResult picker =
            await FilePicker.platform.pickFiles(type: FileType.image);

        if (picker != null) {
          PlatformFile file = picker.files.first;
          print('File Name ${file.path}');

          setState(() {
            //guion = file;
            foto = File(file.path);
          });
        }
      } on PlatformException catch (e) {
        print('Operación no Permitida ' + e.toString());
      }
    } else {
      PickedFile pick;

      pick = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pick != null) {
          foto = File(pick.path);
        } else {
          pick = null;
        }
      });
    }
  }

  _tomarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.camera);

    if (foto == null) {
      //limpiar
      setState(() {});
    }
  }
}
