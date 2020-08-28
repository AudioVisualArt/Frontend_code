import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';

import 'package:Clapp/src/Contract/pages/ver_contratos.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import '../../MyStudio/pages/manage_page.dart';

class NewProjectPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewProjectPage();
  }

}

class _NewProjectPage extends State<NewProjectPage>{

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
    final idUsuario = ModalRoute.of(context).settings.arguments;
    print("id de usuario en new project: $idUsuario");
    // TODO: implement build
    return GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('New Project',
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
                  label: Text('Start Project',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                  textColor: Colors.white,
                  icon: Icon(
                    Icons.playlist_add_check,
                    color: Colors.white,
                  ),
                  color: Color.fromRGBO(89, 122, 121, 1.0),

                  onPressed: () { Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new VerContratos())

                  );},
                ),

              ],
            ),
          ),
        ),
      ),
    ));
  }


  Widget _projectname() {
    return TextFormField(
      initialValue: proyecto.proyectName,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Project Name',
      ),
      onSaved: (value) => proyecto.proyectName = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del proyecto correctamente';
        } else {
          return null;
        }
      },

    );
  }
  Widget _projectTipo(){
    return TextFormField(
      initialValue: proyecto.projectType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Project Type',
      ),
      onSaved: (value) => proyecto.projectType = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el tipo del proyecto correctamente';
        } else {
          return null;
        }
      },

    );
  }

  Widget _description(){
    return TextFormField(
      initialValue: proyecto.description,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      onSaved: (value) => proyecto.description = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la descripcion del proyecto correctamente';
        } else {
          return null;
        }
      },

    );
  }


  Widget _locations() {
    return TextFormField(

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Locations',
      ),

    );
  }

  Widget _contacto(){
    return TextFormField(
      initialValue: proyecto.contacto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Contacto',
      ),
      onSaved: (value) => proyecto.contacto = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre correctamente';
        } else {
          return null;
        }
      },

    );
  }


  }


