import 'dart:ffi';
import 'dart:io';
import 'package:Clapp/src/Space/model/SpaceModel.dart';

import 'package:Clapp/src/Space/pages/new_space.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/User/models/user_model.dart';

import 'package:Clapp/src/services/pages/services_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewSpace2 extends StatefulWidget {
  final SegPagina arg;
  NewSpace2({Key key, this.arg}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewSpace2();
  }
}

class _NewSpace2 extends State<NewSpace2> {
  final picker = ImagePicker();
  File foto;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _guardando = false;
  DateTime date1, date2;

  final spaceProvider = new SpacesProvider();
  final spaceformkey2 = GlobalKey<FormState>();
  List<String> values = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SegPagina usrSpace = ModalRoute.of(context).settings.arguments;

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
                  title: Text('Tarifa de renta',
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
                      key: spaceformkey2,
                      child: Column(
                        children: <Widget>[
                          _pago(usrSpace.space2),
                          SizedBox(height: 10),
                          _horasMin(usrSpace.space2),
                          SizedBox(height: 10),
                          _precioDia(usrSpace.space2),
                          Container(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text('Calendario',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17.5, fontFamily: "Raleway"))),
                          SizedBox(height: 30),
                          _horaInicio(usrSpace.space2),
                          SizedBox(height: 10),
                          _horafinal(usrSpace.space2),
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

                          SizedBox(height: 10),
                          //_tags()
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
                        child: Text('Publicar Locación',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                          (_guardando)
                              ? null
                              : _submit(usrSpace.space2, usrSpace.usuario2);
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

  Widget _horaInicio(SpaceModel espacio) {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: DateTimeField(
          decoration: InputDecoration(
              labelText: 'Hora de inicio',
              labelStyle: TextStyle(
                  fontFamily: "Raleway",
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: " ",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          format: DateFormat("HH:mm"),
          onShowPicker: (context, currentValue) async {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.convert(time);
          },
          onChanged: (dt) {
            setState(() => date1 = dt);
            espacio.scheduleHours =
            "${DateFormat.jm().format(date1)} a ${DateFormat.jm().format(date2)}";
            print("El horario es: ${espacio.scheduleHours}");
            print("el nombre es: ${espacio.name}");
          },
        ));
  }

  Widget _horafinal(SpaceModel espacio) {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: DateTimeField(
          decoration: InputDecoration(
              labelText: 'Hora final',
              labelStyle: TextStyle(
                  fontFamily: "Raleway",
                  //color: Color.fromRGBO(0, 51, 51, 0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              helperText: " ",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                  borderRadius: BorderRadius.circular(16.0))),
          format: DateFormat("HH:mm"),
          onShowPicker: (context, currentValue) async {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.convert(time);
          },
          onChanged: (dt) {
            setState(() => date2 = dt);
            espacio.scheduleHours =
            "${DateFormat.jm().format(date1)} a ${DateFormat.jm().format(date2)}";
            print("El horario es: ${espacio.scheduleHours}");
            print("el nombre es: ${espacio.name}");
          },

        ));
  }

  Widget _pago(SpaceModel espacio) {
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
            labelText: 'Precio por hora',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "200.000 COP/hr",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => espacio.priceHour = double.parse(value),
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

  Widget _precioDia(SpaceModel espacio) {
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
            labelText: 'Precio diario',
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
          onChanged: (value) => espacio.priceDay = double.parse(value),
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

  Widget _horasMin(SpaceModel espacio) {
    return Container(
        padding: EdgeInsets.only(left: 0.5, right: 59.0),
        child: Center(
            child: DropdownButtonFormField<String>(
          value: espacio.minimumHours,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: 'Numero minimo de horas',
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              fontFamily: "Raleway",
            ),
            helperText: "Ejemplo: 3 horas minimo",
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
                espacio.minimumHours = selected;
              },
            );
          },
          items: <String>[
            '1 hora',
            '2 horas',
            '3 horas',
            '4 o mas',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          /*validator: (value) {
            if (value.isEmpty) {
              return null;
            } else {
              return 'Seleccione una opcion';
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
    if (!spaceformkey2.currentState.validate()) return;
    spaceformkey2.currentState.save();
    print('Todo Ok');
    setState(() {
      _guardando = true;
    });

    if (espacio.id == null) {
      espacio.userOwner = user.id;
      spaceProvider.crearEspacio(espacio, foto);
      /*showDialog(context: context,builder: (BuildContext context) {
        return Container(
          height: 300,
          width: 300,
          child: Text(
            "Su locacion ha sido publicada con exito"
          )
        );
      });

       */
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      spaceProvider.editarEspacio(espacio, foto);
    }
  }
}
