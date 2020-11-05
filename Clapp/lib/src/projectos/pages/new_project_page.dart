import 'package:Clapp/src/Finance/Model/Finance.dart';
import 'package:Clapp/src/Finance/provider/finances_provider.dart';
import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:Clapp/src/projectos/bloc/project_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart' as mostrar_dialog;
import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';
import '../../MyStudio/pages/manage_page.dart';

class NewProjectPage extends StatefulWidget {
  final UserModel user;
  NewProjectPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewProjectPage();
  }
}

class _NewProjectPage extends State<NewProjectPage> {
  ActividadProvider actividadProvider = new ActividadProvider();
  ProjectModel proyecto = new ProjectModel();
  bool _guardando = false;
  final proyectoProvider = new ProyectosProvider();


  PlatformFile resumen_ejecutivo;
  PlatformFile carpeta_madre;
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];
  bool _saved = false;
  bool _savedFile = false;
  final projectformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    proyecto.ownerId = usuario.id;
    print("id de usuario en new project: ${usuario.id}");
    //final bloc = ProyectosProvider.of(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Nuevo Proyecto',
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
                    child: Text('Complete los Datos',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 17.5, fontFamily: "Raleway"))),
                Container(
                  padding: EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                  child: Form(
                    key: projectformkey,
                    child: Column(
                      children: <Widget>[
                        _projectname(),
                        SizedBox(height: 10),
                        _contacto(),
                        SizedBox(height: 10),
                        _projectTipo(),
                        SizedBox(height: 10),
                        _description(),
                        SizedBox(height: 10),
                        _subirResumenEjecutivo(),
                        SizedBox(height: 10),
                        _subirCarpetaMadre()
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
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('Empezar Proyecto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                          (_guardando) ? null : _submit(usuario);
                        },
                      ),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _subirCarpetaMadre() {
    return Padding(
      padding: EdgeInsets.only(top: 1.0, left: 0.5, right: 59.0),
      child: SizedBox(
        height: 52,
        width: MediaQuery.of(context).size.width - 40,
        child: RaisedButton(
          //splashColor: Colors.green,
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text('Sube Carpeta Madre',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Raleway",
                  color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold)),
          textColor: Color.fromRGBO(0, 51, 51, 0.8),
          color: Colors.white,
          onPressed: openFileExplorer2,
        ),
      ),
    );
  }

  Widget _subirResumenEjecutivo() {
    return Padding(
      padding: EdgeInsets.only(top: 1.0, left: 0.5, right: 59.0),
      child: SizedBox(
        height: 52,
        width: MediaQuery.of(context).size.width - 40,
        child: RaisedButton(
          //splashColor: Colors.green,
          padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromRGBO(0, 51, 51, 0.8), width: 1.2),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text('Sube Resumen Ejecutivo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Raleway",
                  color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold)),
          textColor: Color.fromRGBO(0, 51, 51, 0.8),
          color: Colors.white,
          onPressed: openFileExplorer,
        ),
      ),
    );
  }

  void _submit(
    UserModel usuario,
  ) async {
    //proyecto.idUser= usuario.id;
    if (resumen_ejecutivo != null && carpeta_madre != null) {
      if (!projectformkey.currentState.validate()) return;
      projectformkey.currentState.save();
      print('Todo Ok');
      setState(() {
        _guardando = true;
      });
      if (proyecto.id == null) {
        if (proyecto.description.isNotEmpty &&
            proyecto.contacto.isNotEmpty &&
            proyecto.projectType.isNotEmpty &&
            proyecto.proyectName.isNotEmpty) {
          //_submit(usuario);
          Navigator.popAndPushNamed(
            context,
            'details_project',
            arguments: proyecto,
          );
        }
        mostrar_dialog.MostrarDialog(context, 'Tu proyecto ha sido creado!',
            'Desde esta sección puedes crear contratos y gestionar el personal y las finanzas de tu proyecto.');
        proyecto.id =
            await Future.value(proyectoProvider.crearProyecto(proyecto));

        print("el id del proyecto es: ${proyecto.id}");
        ActividadModel activity = new ActividadModel(
            descripcion: "Has creado un nuevo proyecto",
            fecha: DateTime.now().toString(),
            tipo: "Proyecto",
            contenido:
                "${proyecto.proyectName},${proyecto.projectType},${proyecto.description}",
            photoUrl: usuario.photoUrl);
        actividadProvider.crearActividad(activity, usuario.id);


        StorageUploadTask t;
        t = await proyectoProvider.editarProyecto(
            proyecto, resumen_ejecutivo, carpeta_madre);

        if (t.isComplete) {
          setState(() {
            _tasks.add(t);
            _saved = true;
            _savedFile = true;
          });

        }

        // Navigator.pop(context);
        //utils.mostrarAlerta(context, 'resumen ejecutivo en  Clapp !!!');
      } else {
        proyectoProvider.editarProyecto(
            proyecto, resumen_ejecutivo, carpeta_madre);
      }
    } else {
      setState(() {
        _saved = false;
      });
      if (resumen_ejecutivo == null && carpeta_madre == null) {
        mostrar_dialog.MostrarDialog(context, 'Error!',
            'Debes subir el resumen ejecutivo y la carpeta madre para crear un proyecto.');
      } else if (resumen_ejecutivo == null) {
        mostrar_dialog.MostrarDialog(context, 'Error!',
            'Debes subir el resumen ejecutivo para crear un proyecto.');
      } else {
        mostrar_dialog.MostrarDialog(context, 'Error!',
            'Debes subir la carpeta madre para crear un proyecto.');
      }
    }
  }

  Widget _projectname() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          initialValue: proyecto.proyectName,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 20,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Nombre del Proyecto',
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
          onChanged: (value) => proyecto.proyectName = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre del proyecto correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _projectTipo() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          initialValue: proyecto.projectType,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 50,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Tipo de Proyecto',
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
          onChanged: (value) => proyecto.projectType = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el tipo del proyecto correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          initialValue: proyecto.description,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 80,
          maxLines: 3,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Descripción',
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
          onChanged: (value) => proyecto.description = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese la descripcion del proyecto correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _locations() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Locaciones',
      ),
    );
  }

  Widget _contacto() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          initialValue: proyecto.contacto,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 50,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Contacto',
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
          onChanged: (value) => proyecto.contacto = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
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
          resumen_ejecutivo = file;
        });
      }
    } on PlatformException catch (e) {
      print('Operación no Permitida ' + e.toString());
    }
  }

  openFileExplorer2() async {
    try {
      FilePickerResult picker = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);

      if (picker != null) {
        PlatformFile file2 = picker.files.first;
        print('File Name ${file2.path}');

        setState(() {
          carpeta_madre = file2;
        });
      }
    } on PlatformException catch (e) {
      print('Operación no Permitida ' + e.toString());
    }
  }
}
