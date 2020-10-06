import 'dart:ffi';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/services/pages/services_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
//import 'package:Clapp/src/User/models/user_model.dart';

import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';

class NewService extends StatefulWidget {
  //final UserModel user;
  final UserModel user;
  NewService({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewService();
  }
}

class _NewService extends State<NewService> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _guardando = false;
  bool _saved = false;
  bool _savedFile = false;
  WorkerModel trabajador = new WorkerModel();
  final workerProvider = new WorkersProvider();
  final workerformkey = GlobalKey<FormState>();
  PlatformFile guion;
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  @override
  Widget build(BuildContext context) {
    // UserModel usuario = ModalRoute.of(context).settings.arguments;
    //print("id de usuario en new project: ${usuario.id}");
    // TODO: implement build

    UserModel usuario = ModalRoute.of(context).settings.arguments;
    trabajador.userId = usuario.id;
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
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.file_upload,
                      color: Colors.black,
                    ),
                    onPressed: openFileExplorer,
                  ),
                ],
                expandedHeight: 100.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Nuevo Servicio',
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
                      child: Text('Complete sus datos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17.5, fontFamily: "Raleway"))),
                  Container(
                    padding: EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                    child: Form(
                      key: workerformkey,
                      child: Column(
                        children: <Widget>[
                          _description(),
                          SizedBox(height: 10),
                          _studies(),
                          SizedBox(height: 10),
                          _mainRol(),
                          SizedBox(height: 10),
                          _profesion(),
                          SizedBox(height: 10),
                          _laboral(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                  child: Container(
                    padding:
                        EdgeInsets.only(right: 10.0, left: 210,  bottom: 30.0),
                    child: RaisedButton(
                      padding: EdgeInsets.only(
                          top: 13, bottom: 13, left: 10, right: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text('Nuevo servicio',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0),
                              fontWeight: FontWeight.bold)),
                      textColor: Colors.white,
                      color: Color.fromRGBO(112, 252, 118, 0.8),
                      onPressed: (_guardando) ? null : _submit,
                    ),
                  ),),
                ]),
              )
            ],
          ),
        ));
  }

  Widget _profesion() {
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
          maxLength: 20,
          maxLines: 1,
          textAlign: TextAlign.left,
          //initialValue: trabajador.profesion,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Categoria',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "Ejemplo: Arte audiovisual",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => trabajador.profession = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre de la profesion correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _mainRol() {
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
          maxLength: 20,
          initialValue: trabajador.mainRol,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Rol Principal',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              helperText: "Ejemplo: DP",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          onChanged: (value) => trabajador.mainRol = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre correctamente';
            } else {
              return null;
            }
          },
        )));
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
          maxLength: 200,
          maxLines: 3,
          initialValue: trabajador.description,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Perfil profesional',
              labelStyle: TextStyle(
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: "Breve descripcion de su perfil",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          onChanged: (value) => trabajador.description = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese minimo 10 palabras';
            } else {
              return null;
            }
          },
        )));
  }

  Widget _studies() {
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
          maxLength: 50,
          //initialValue: trabajador.description,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Estudios',
              labelStyle: TextStyle(
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: "Cursos, talleres ",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          onChanged: (value) => trabajador.studies = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese minimo 5 palabras';
            } else {
              return null;
            }
          },
        )));
  }

  Widget _laboral() {
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
          maxLength: 50,
          //initialValue: trabajador.description,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
              labelText: 'Experiencia laboral',
              labelStyle: TextStyle(
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              //helperText: "Ejemplo: ",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          //onChanged: (value) => trabajador.description = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese minimo 5 palabras';
            } else {
              return null;
            }
          },
        )));
  }

  Future<Void> _submit() async {
    //trabajador.userId= workerProvider.crearWorker(trabajador).toString();
    //print("el id del servicio es: ${trabajador.userId}");
    if (!workerformkey.currentState.validate())
      workerformkey.currentState.save();

    print('Todo Ok');

    setState(() {
      _guardando = true;
    });
    if (guion != null) {
      print(guion.path.toString());

      StorageUploadTask t;
      //t = await screenPlayProvider.crearScreenPlay(screenPlayModel, guion);
      t = await workerProvider.crearWorker(trabajador, guion);
      if (t.isComplete) {
        setState(() {
          _tasks.add(t);
          _saved = true;
          _savedFile = true;
        });
      }
      // Navigator.pop(context);
      utils.mostrarAlerta(context, 'HV en  Clapp !!!');
    } else {
      setState(() {
        _saved = false;
      });
      utils.mostrarAlerta(context, 'No Has Subido Ningún hoja de vida');
    }


    // setState(() {
    //   _guardando = false;
    // });

    Duration(milliseconds: 1500);
    Navigator.pop(context,
        new MaterialPageRoute(builder: (context) => new ServicesPages()));
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
