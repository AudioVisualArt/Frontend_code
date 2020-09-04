import 'package:Clapp/src/services/pages/services_page.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:Clapp/src/services/model/worker_model.dart';

import 'package:Clapp/src/utils/utils.dart' as utils;
class NewService extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewService();
  }

}

class _NewService extends State<NewService>{
  WorkerModel trabajador = new WorkerModel();
  final workerProvider = new WorkersProvider();
  final workerformkey = GlobalKey<FormState>();
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
            title: Text('Nuevo Servicio',
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
                key: workerformkey,
                child: Column(

                  children: <Widget>[
                    _profesion(),
                    SizedBox(height: 25),
                    _mainRol(),
                    SizedBox(height: 25),
                    _description(),



                    SizedBox(height: 25),
                    _education(),
                    SizedBox(height: 25),
                    _laboral(),
                    SizedBox(height: 45),
                    _botoncreartrabajador(),

                  ],
                ),
              ),
            ),
          ),


        ));
  }
  Widget _profesion() {
    return TextFormField(
      initialValue: trabajador.profesion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Categoria',
      ),
      onChanged: (value) => trabajador.profesion = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre de la profesion correctamente';
        } else {
          return null;
        }
      },

    );
  }

  Widget _mainRol() {
    return TextFormField(
      initialValue: trabajador.mainRol,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Rol Principal',
      ),
      onChanged: (value) => trabajador.mainRol = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre correctamente';
        } else {
          return null;
        }
      },

    );
  }


  Widget _description() {
    return TextFormField(
      initialValue: trabajador.description,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Perfil profesional',
      ),
      onChanged: (value) => trabajador.description = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese minimo 10 palabras';
        } else {
          return null;
        }
      },

    );
  }

  Widget _education() {
    return TextFormField(
      initialValue: trabajador.estudios,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Estudios',
      ),
      onChanged: (value) => trabajador.estudios = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese minimo 3 palabras';
        } else {
          return null;
        }
      },

    );
  }

  Widget _laboral() {
    return TextFormField(
      //initialValue: trabajador.description,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Experiencia laboral',
      ),
      //onChanged: (value) => trabajador.description = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese minimo 5 palabras';
        } else {
          return null;
        }
      },

    );
  }

  Widget _botoncreartrabajador(){
    return RaisedButton.icon(
      onPressed: (){ Navigator.pop(
          context,
          new MaterialPageRoute(
              builder: (context) => new ServicesPages()));},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      label: Text('Habilitar nuevo servicio',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
      textColor: Colors.white,
      icon: Icon(Icons.playlist_add_check,
        color: Colors.white,
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),


    );
  }
}