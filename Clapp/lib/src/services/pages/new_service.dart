import 'dart:ffi';
import 'dart:ui';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart' as mostrar_dialog;
import 'package:Clapp/src/NewHome/Pages/elemento_carrusel.dart';
import 'package:Clapp/src/NewHome/Pages/home_page_principal.dart';
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
import 'package:material_tag_editor/tag_editor.dart';

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
  List<String> values = [];
  String _rolSelected = 'ninguno';

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
          body: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 100.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Nuevo Clapper',
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
                              _minPayment(),
                              SizedBox(height: 10),
                              _maxPayment(),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 1.0, left: 0.5, right: 59.0),
                                child: SizedBox(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: RaisedButton(
                                    //splashColor: Colors.green,
                                    padding: EdgeInsets.only(
                                        top: 13,
                                        bottom: 13,
                                        left: 10,
                                        right: 10),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color.fromRGBO(0, 51, 51, 0.8),
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text('Sube tu portafolio',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: "Raleway",
                                            color:
                                                Color.fromRGBO(0, 51, 51, 0.8),
                                            fontWeight: FontWeight.bold)),
                                    textColor: Color.fromRGBO(0, 51, 51, 0.8),
                                    color: Colors.white,
                                    onPressed: openFileExplorer,
                                  ),
                                ),
                              ),
                              //_tags()
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 210, bottom: 30.0),
                          child: RaisedButton(
                            padding: EdgeInsets.only(
                                top: 13, bottom: 13, left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text('Publicar perfil',
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
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ]),
                  )
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height - 115,
                child: _carruselServicio(usuario),
              ),
            ],
          ),
        ));
  }

  Widget _tags() {
    return TagEditor(
      length: values.length,
      delimeters: [',', ' '],
      hasAddButton: true,
      resetTextOnSubmitted: true,
      onSubmitted: (outstandingValue) {
        setState(() {
          values.add(outstandingValue);
        });
      },
      inputDecoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Añade tags relacionados!',
      ),
      onTagChanged: (newValue) {
        setState(() {
          values.add(newValue);
          print(values);
        });
      },
      tagBuilder: (context, index) => _Chip(
        index: index,
        label: values[index],
        onDeleted: onDelete,
      ),
    );
  }

  onDelete(index) {
    setState(() {
      values.removeAt(index);
    });
  }

  Widget _minPayment() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          //initialValue: contrato.payment.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 10,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Minimo que cobra por hora',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            // helperText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => trabajador.minPayment = double.parse(value),
          validator: (value) {
            if (utils.isNumeric(value)) {
              return null;
            } else {
              return 'Solo numeros';
            }
          },
        ),
      ),
    );
  }

  Widget _maxPayment() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          //initialValue: contrato.payment.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 10,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Maximo que cobra por hora',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            // helperText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => trabajador.maxPayment = double.parse(value),
          validator: (value) {
            if (utils.isNumeric(value)) {
              return null;
            } else {
              return 'Solo numeros';
            }
          },
        ),
      ),
    );
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
            child: DropdownButtonFormField<String>(
          value: trabajador.mainRol,
          //hint: Text("Seleccione el rol principal"),
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: 'Seleccione el rol principal',
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              fontFamily: "Raleway",
            ),
            helperText: "Ejemplo: Personal artistico",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (String selected) {
            setState(
              () {
                trabajador.mainRol = selected;
              },
            );
          },
          items: <String>['ninguno', 'Personal artistico', 'Personal tecnico']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
        )
            /*TextFormField(
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
        ))*/
            ));
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
    //trabajador.briefcase= values;
    if(guion != null){
    if (!workerformkey.currentState.validate())
      workerformkey.currentState.save();

    print('Todo Ok');

    setState(() {
      _guardando = true;
    });

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
      //utils.mostrarAlerta(context, 'HV en  Clapp !!!');
      Navigator.pop(context);
    mostrar_dialog.MostrarDialog(context, 'Tu servicio ha sido creado!',
        'Tu perfil de servicio aparecera en la sección de personal de Clapp.');
    } else {
      setState(() {
        _saved = false;
      });
      mostrar_dialog.MostrarDialog(context, 'Error!',
          'Debes subir el archivo de portafolio para poder continuar.');
    }

    // setState(() {
    //   _guardando = false;
    // });

    //Duration(milliseconds: 1500);
    //Navigator.pop(context,
     //   new MaterialPageRoute(builder: (context) => new ServicesPages()));
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

  Widget _carruselServicio(UserModel usuario) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(),
            child: ClipRect(
              child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),

                    /*decoration: ConcaveDecoration(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  colors: [
                    Color.fromRGBO(230, 230, 230, 0.5),
                    Color.fromRGBO(247, 245, 245, 0.5),
                  ],
                  depression: 15),

               */
                    //color: Color.fromRGBO(227, 227, 227, 1),
                    height: 115, //MediaQuery.of(context).size.height - 570,
                    width: MediaQuery.of(context).size.width,

                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 132,
                        ),
                        ElementoMenu(
                          name: 'Ofertas',
                          onPressed: 4,
                          usuario: usuario,
                          imagenIcono: "assets/img/contractIcon.png",
                          colorfondo: Color.fromRGBO(255, 211, 78, 1.0),
                        ),

                        ElementoMenu(
                          name: 'Tus Contratos',
                          onPressed: 8,
                          usuario: usuario,
                          imagenIcono: "assets/img/iconodecontratos.png",
                          colorfondo: Color.fromRGBO(255, 105, 76, 1.0),
                        ),

                        //elementoMenu(usuario,'Catering'),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  )),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(),
              child: ClipPath(
                  clipper: ClippCarrusel(),
                  child: Container(
                      color: Color.fromRGBO(112, 252, 118, 0.8),
                      height: 115, //MediaQuery.of(context).size.height - 570,
                      width: 131, // MediaQuery.of(context).size.width - 280,
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, 'services',
                            arguments: usuario),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                right: 18,
                              ),
                              child: Container(
                                  height:
                                      73, //                                     MediaQuery.of(context).size.height - 610,
                                  width:
                                      77, //                                     MediaQuery.of(context).size.width - 335,
                                  child: Hero(
                                      tag: Icons.person,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 75,
                                      ))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                right: 18,
                              ),
                              child: Text("Clapper",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 51, 51, 0.8),
                                      fontSize: 18,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      )))),
        )
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
