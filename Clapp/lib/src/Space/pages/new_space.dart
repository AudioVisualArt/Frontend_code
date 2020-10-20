import 'dart:ffi';
import 'dart:io';
import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/services/pages/services_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:Clapp/src/services/model/worker_model.dart';

import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';

class NewSpace extends StatefulWidget {
  //final UserModel user;
  final UserModel user;

  NewSpace({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewSpace();
  }
}

class _NewSpace extends State<NewSpace> {
  final picker = ImagePicker();
  File foto;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _guardando = false;
  SpaceModel espacio = new SpaceModel();
  final spaceProvider = new SpacesProvider();
  final spaceformkey = GlobalKey<FormState>();
  ActividadProvider actividadProvider=new ActividadProvider();
  List<String> values = [];
  UserModel usuario;

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    //print("id de usuario es : ${usuario.id}");
    // TODO: implement build

    usuario = ModalRoute.of(context).settings.arguments;
    //ya esta // espacio.userOwner = usuario.id;

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          key: scaffoldKey,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 100.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Nueva Locacion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: "Raleway",
                        color: Color.fromRGBO(115, 115, 115, 1.0),
                      )),
                  //background:
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text('Complete los datos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17.5, fontFamily: "Raleway"))),
                  Container(
                    padding: EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                    child: Form(
                      key: spaceformkey,
                      child: Column(
                        children: <Widget>[
                          _nombreLocacion(),
                          SizedBox(height: 10),
                          _description(),
                          SizedBox(height: 10),
                          _ciudad(),
                          SizedBox(height: 10),
                          _capacidad(),
                          SizedBox(height: 10),
                          /* Padding(
                            padding: EdgeInsets.only(top: 1.0, left: 0.5, right: 59.0),
                            child: SizedBox(
                              height: 52,
                              width: MediaQuery.of(context).size.width - 40,
                              child: RaisedButton(
                                //splashColor: Colors.green,
                                padding: EdgeInsets.only(
                                    top: 13, bottom: 13, left: 10, right: 10),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      width: 1.2),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Text('Sube una imagen',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: "Raleway",
                                        color: Color.fromRGBO(0, 51, 51, 0.8),
                                        fontWeight: FontWeight.bold)),
                                textColor: Color.fromRGBO(0, 51, 51, 0.8),
                                color: Colors.white,
                                onPressed: _seleccionarFoto,
                              ),
                            ),
                          ),

                          */
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding:
                          EdgeInsets.only(right: 10.0, left: 210, bottom: 30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 25, right: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('Siguiente',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                          //(_guardando) ? null : _submit(espacio, usuario);
                          if (!spaceformkey.currentState.validate()) return;
                          Navigator.pushNamed(context, 'nuevoespacio2',
                              arguments: SegPagina(usuario, espacio));
                        },
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }

  onDelete(index) {
    setState(() {
      values.removeAt(index);
    });
  }

  Widget _description() {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: Center(
            child: TextFormField(
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 125,
          maxLines: 3,
          initialValue: espacio.description,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Descripción de la locación',
              labelStyle: TextStyle(
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: "Breve descripcion del espacio",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          onChanged: (value) => espacio.description = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese minimo 10 palabras';
            } else {
              return null;
            }
          },
        )));
  }

  Widget _nombreLocacion() {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: Center(
            child: TextFormField(
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 29,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Nombre del lugar',
              labelStyle: TextStyle(
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: "Ejemplo: Desierto con poca vegetacion",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          onChanged: (value) => espacio.name = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese minimo 5 palabras';
            } else {
              return null;
            }
          },
        )));
  }

  Widget _ciudad() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 17,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Ciudad',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "Ejemplo: Bogotá",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => espacio.location = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre de la ciudad correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _capacidad() {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: Center(
            child: TextFormField(
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 4,

          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Capacidad maxima',
              labelStyle: TextStyle(
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: "Ejemplo: 50 personas maximo",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
           /*onChanged: (value) => espacio.capacity = value,
              validator: (value) {
                if (utils.isNumeric(value)) {
                  return 'Ingrese solo numeros';
                } else {
                  return null;
                }
              },

            */
        )));
  }

  _seleccionarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //limpiar
    setState(() {
      foto = File(pickedFile.path);
    });
  }

  void _submit(SpaceModel espacio, UserModel user) {
    if (!spaceformkey.currentState.validate()) return;
    spaceformkey.currentState.save();
    print('Todo Ok');
    setState(() {
      _guardando = true;
    });

    if (espacio.id == null) {
      espacio.userOwner = user.id;
      spaceProvider.crearEspacio(espacio, foto);
    } else {
      spaceProvider.editarEspacio(espacio, foto);
    }
    ActividadModel act=new ActividadModel(
      descripcion: "Has publicado un nuevo espacio",
      fecha: DateTime.now().toString(),
      tipo: "Espacio"

    );
    actividadProvider.crearActividad(act, usuario.id);

  }
}

class SegPagina {
  final UserModel usuario2;
  final SpaceModel space2;

  SegPagina(this.usuario2, this.space2);
}
