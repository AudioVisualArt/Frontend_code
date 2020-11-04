import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Clapp/src/ScreenPlay/widgets/uploadtasklisttitle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/ScreenPlay/Pages/showPDF.dart';
import 'package:Clapp/src/ScreenPlay/Provider/screenplay_provider.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart';
import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';

import 'package:Clapp/src/utils/utils.dart' as utils;

// ignore: must_be_immutable
class ScreenPlayPage extends StatefulWidget {
  UserModel userModel;
  ScreenPlayPage({this.userModel});

  @override
  _ScreenPlayPageState createState() => _ScreenPlayPageState();
}

class _ScreenPlayPageState extends State<ScreenPlayPage> {
  ScreenPlayModel screenPlayModel = ScreenPlayModel();
  bool _saved = false;
  bool _savedFile = false;
  bool _loading = false;
  PlatformFile guion;
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();
  ActividadProvider actividadProvider = new ActividadProvider();
  final formKey = GlobalKey<FormState>();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  final screenPlayProvider = ScreenPlayProvider();

  @override
  Widget build(BuildContext context) {
    widget.userModel = ModalRoute.of(context).settings.arguments;
    print('ScreenPlay User ID: ${widget.userModel.id}');
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scafoldKey,
        appBar: AppBar(
          title: Text(
            'Guion',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.file_upload,
                color: Colors.black,
              ),
              onPressed: openFileExplorer,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearTopic(),
                  Divider(),
                  _crearPages(),
                  Divider(),
                  _crearSinopsis(),
                  Divider(),
                  _crearPrecio(),
                  Divider(),
                  _crearDisponible(),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _crearBoton(),
                      SizedBox(
                        width: 5.0,
                      ),
                      _mostrarPDF(),
                    ],
                  ),
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
      initialValue: screenPlayModel.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre de tu Guion',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => screenPlayModel.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de tu Guion con mas 3 letras';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: screenPlayModel.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción Simple',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => screenPlayModel.itemDescription = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa un pequeña descripción';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearTopic() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: screenPlayModel.topic,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Temática',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => screenPlayModel.topic = value,
      validator: (value) {
        if (value.length < 2) {
          return '¿Cual es el Tema?';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPages() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: screenPlayModel.pages.toString() ?? 0,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Páginas de tu Guion?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => screenPlayModel.pages = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearSinopsis() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: screenPlayModel.sinopsis,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Sinopsis',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => screenPlayModel.sinopsis = value,
      validator: (value) {
        if (value.length < 3) {
          return '¿Cual es la Sinopsis?';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: screenPlayModel.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => screenPlayModel.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: screenPlayModel.disponible,
      title: Text(
        'Disponible',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      activeColor: Color.fromRGBO(153, 255, 204, 1.0),
      onChanged: (value) => setState(() {
        screenPlayModel.disponible = value;
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
      onPressed: (_saved) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print('Guión Listo para guardar');

    setState(() {
      _saved = true;
    });

    if (guion != null) {
      setState(() {
        _saved = true;
        _savedFile = true;
        _loading = true;
      });

      print(guion.path.toString());
      screenPlayModel.idOwner = widget.userModel.id;
      await screenPlayProvider.crearScreenPlay(screenPlayModel, guion);

      setState(() {
        _loading = false;
      });
      MostrarDialog(context, 'Guion en Clapp !!!',
          'Has Subido el Guion ${screenPlayModel.titulo}');
    } else {
      setState(() {
        _saved = false;
      });
      MostrarDialog(
          context, 'Alerta Clapper', 'No Has Seleccionado Ningún Documento');
    }
  }

  Widget _mostrarPDF() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),
      textColor: Colors.white,
      label: Text(
        'Ver Documento',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      icon: Icon(Icons.dehaze),
      onPressed: (!_savedFile) ? null : _showPDF,
    );
  }

  _showPDF() async {
    //File file = await screenPlayProvider.createFileOfPdfUrl(screenPlayModel);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShowPDF(
                screenPlayModel: screenPlayModel,
              )),
    );
  }

  openFileExplorer() async {
    try {
      FilePickerResult picker = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);

      if (picker != null) {
        PlatformFile file = picker.files.first;
        print('File Name ${file.path}');

        setState(() {
          guion = file;
        });
      }
    } on PlatformException catch (e) {
      print('Operación no Permitida ' + e.toString());
    }
  }
}
