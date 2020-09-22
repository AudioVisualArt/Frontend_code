import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/projectos/bloc/project_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
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
  var _categoryNameProject = TextEditingController();
  // tipo de projecto
  var _selectedValue;
  ProjectModel proyecto = new ProjectModel();
  bool _guardando = false;
  final proyectoProvider = new ProyectosProvider();

  var _categoriesProjectType = List<DropdownMenuItem>();
  // job positions
  var _categoriesJobPosition = List<DropdownMenuItem>();

  //publico
  var _categoriesPublico = List<DropdownMenuItem>();

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
                    child: Text('Complete los datos',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 17.5, fontFamily: "Raleway"))),
                Container(
                  padding: EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                  child: Form(
                    //key: formKey,

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
                      if (proyecto.description.isNotEmpty &&
                          proyecto.contacto.isNotEmpty &&
                          proyecto.projectType.isNotEmpty &&
                          proyecto.proyectName.isNotEmpty) {
                        _submit(usuario);
                        Navigator.pushNamed(
                          context,
                          'details_project',
                          arguments: proyecto,
                        );
                      }
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

  void _submit(
    UserModel usuario,
  ) {
    //proyecto.idUser= usuario.id;
    proyecto.id = proyectoProvider.crearProyecto(proyecto).toString();
    print("el id del proyecto es: ${proyecto.id}");
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
            labelText: 'Nombre del proyecto',
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
            labelText: 'Tipo de proyecto',
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
          maxLength: 100,
          maxLines: 3,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Descripcion',
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
}
