import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/MyStudio/pages/project_management.dart';

import 'manage_page.dart';

class NewProjectPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewProjectPage();
  }

}

class _NewProjectPage extends State<NewProjectPage>{

  // tipo de projecto
  var _selectedValue;

  var _categoriesProjectType = List<DropdownMenuItem>();
  // job positions
  var _categoriesJobPosition = List<DropdownMenuItem>();

  //publico
  var _categoriesPublico = List<DropdownMenuItem>();

  @override
  Widget build(BuildContext context) {
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
                _projectTipo(),
                SizedBox(height: 25),
                _jobPosition(),
                SizedBox(height: 25),
                _locations(),
                SizedBox(height: 25),
                _projectpublico(),
                SizedBox(height: 45),

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
                      new ProjectManagement())

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

      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Project Name',
      ),

    );
  }
  Widget _projectTipo(){
    return DropdownButtonFormField(
        value: _selectedValue,
        items:  _categoriesProjectType,
        hint: Text('Project Type'),
        onChanged: (value){
          setState(() {
            _selectedValue = value;
    });
    },
        );
  }

  Widget _jobPosition(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _categoriesJobPosition,
      hint: Text('Job Positions'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
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

  Widget _projectpublico(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items:_categoriesPublico,
      hint: Text('Job Positions'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }


  }


