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
          appBar: AppBar(
            title: Text('Nuevo proyecto',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 50.0,
              ),
              child: Form(
                //key: formKey,
                child: Column(
                  children: <Widget>[
                    _projectname(),
                    SizedBox(height: 25),
                    _contacto(),
                    SizedBox(height: 25),

                    _projectTipo(),
                    SizedBox(height: 25),
                    _description(),
                    // SizedBox(height: 25),
                    //_locations(),
                    SizedBox(height: 25),

                    RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      label: Text('Empezar proyecto',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(89, 122, 121, 1.0),
                      onPressed: () {
                        _submit(usuario);
                        Navigator.pushNamed(context, 'see_contracts',
                            arguments: usuario);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  void _submit(UserModel usuario, ){

    proyecto.idUser= usuario.id;
    proyectoProvider.crearProyecto(proyecto);


  }

  Widget _projectname() {

      return TextFormField(
      initialValue: proyecto.proyectName,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'nombre del proyecto',
      ),

      onChanged: (value) => proyecto.proyectName = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del proyecto correctamente';
        } else {
          return null;
        }

        }
     );

  }

  Widget _projectTipo() {

    return TextFormField(
      initialValue: proyecto.projectType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Tipo de proyecto',
      ),
        onChanged: (value) => proyecto.projectType = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el tipo del proyecto correctamente';
        } else {
          return null;
        }
      }
    );
  }

  Widget _description() {

    return TextFormField(

      initialValue: proyecto.description,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripcion',
      ),
        onChanged: (value) => proyecto.description = value,
      validator: (value) {
          if (value.length < 3) {
          return 'Ingrese la descripcion del proyecto correctamente';
          } else {
          return null;
          }
          }
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

    return TextFormField(
      initialValue: proyecto.contacto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Contacto',
      ),
        onChanged: (value) => proyecto.contacto = value,
      validator: (value) {
          if (value.length < 3) {
          return 'Ingrese el nombre correctamente';
          } else {
          return null;
          }
          }
        );

  }
}
