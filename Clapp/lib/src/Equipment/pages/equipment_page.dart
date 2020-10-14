import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class EquipmentPage extends StatefulWidget {
  UserModel userModel;
  EquipmentPage({Key key, this.userModel}) : super(key: key);

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  EquipmentModel equipment = new EquipmentModel();
  final equipmentProvider = new EquipmentProvider();

  bool _guardando = false;
  bool _rentSell = true;

  List<String> _tags = [
    'Seleccionar',
    'CAMARAS',
    'MICROFONOS',
    'LUCES',
    'ACCESORIO',
  ];

  String _opcionSeleccionada = 'Seleccionar';

  File foto;

  @override
  Widget build(BuildContext context) {
    widget.userModel = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Equipo',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _mostrarFoto(),
                  Divider(),
                  _crearNombre(),
                  Divider(),
                  _crearDescripcion(),
                  Divider(),
                  _crearSpecs(),
                  Divider(),
                  _crearMarca(),
                  Divider(),
                  _crearModelo(),
                  Divider(),
                  _crearTag(),
                  Divider(),
                  _crearPrecio(),
                  Divider(),
                  _crearDisponible(),
                  Divider(),
                  _crearRent(),
                  Divider(),
                  _crearSell(),
                  Divider(),
                  _crearBoton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      autofocus: false,
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: equipment.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre de tu Equipo',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => equipment.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del Equipo correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: equipment.itemDescription,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción Simple',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => equipment.itemDescription = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa un pequeña descripción';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: equipment.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => equipment.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearSpecs() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: equipment.specs,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Especificaciones de tu Equipo',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => equipment.specs = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa una especificación';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearMarca() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: equipment.marca,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Marca de tu Equipo?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => equipment.marca = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingresa una marca';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearModelo() {
    return TextFormField(
      style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      initialValue: equipment.modelo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '¿Modelo de tu Equipo?',
        labelStyle: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      onSaved: (value) => equipment.modelo = value,
      validator: (value) {
        if (value.length < 2) {
          return 'Ingresa un modelo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: equipment.disponible,
      title: Text(
        'Disponible',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      activeColor: Color.fromRGBO(153, 255, 204, 1.0),
      onChanged: (value) => setState(() {
        equipment.disponible = value;
      }),
    );
  }

  Widget _crearRent() {
    return RadioListTile(
        value: equipment.rent ?? false,
        title: Text(
          'Renta',
          style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
        ),
        activeColor: Color.fromRGBO(0, 51, 51, 1.0),
        groupValue: _rentSell,
        onChanged: (value) {
          setState(() {
            _rentSell = value;
            equipment.rent = true;
            equipment.sell = false;
          });
        });
  }

  Widget _crearSell() {
    return RadioListTile(
        value: equipment.sell ?? true,
        title: Text(
          'Venta',
          style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
        ),
        activeColor: Color.fromRGBO(0, 51, 51, 1.0),
        groupValue: _rentSell,
        onChanged: (value) {
          setState(() {
            _rentSell = value;
            equipment.sell = true;
            equipment.rent = false;
          });
        });
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();

    _tags.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    return lista;
  }

  Widget _crearTag() {
    return Flexible(
      flex: 1,
      child: DropdownButton(
          style: TextStyle(
              fontSize: 15.0, fontFamily: "Raleway", color: Colors.black),
          isExpanded: true,
          value: _opcionSeleccionada,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionada = opt;
              equipment.tag = opt;
            });
          }),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),
      textColor: Colors.white,
      label: Text(
        'Guardar',
        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
      ),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print('Todo Ok');

    setState(() {
      _guardando = true;
    });

    if (equipment.id == null) {
      equipment.idOwner = widget.userModel.id;
      equipmentProvider.crearEquipmente(equipment, foto);
    } else {
      equipmentProvider.editarEquipment(equipment, foto);
    }

    mostrarSnackbar('Registro Guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snacckbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(seconds: 3),
    );

    scaffoldKey.currentState.showSnackBar(snacckbar);
  }

  Widget _mostrarFoto() {
    //print('FotoURL: ' + equipment.fotoUrl);
    if (equipment.fotoUrl.isEmpty || equipment.fotoUrl == null) {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else if (equipment.fotoUrl != null || equipment.fotoUrl.isNotEmpty) {
      if (foto != null) {
        return Image(
          image: AssetImage(foto.path),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          image: NetworkImage(equipment.fotoUrl),
        );
      }
    }
  }

  _seleccionarFoto() async {
    final _picker = ImagePicker();
    FocusScope.of(context).requestFocus(new FocusNode());
    if (Platform.isAndroid) {
      try {
        FilePickerResult picker =
            await FilePicker.platform.pickFiles(type: FileType.image);

        if (picker != null) {
          PlatformFile file = picker.files.first;
          print('File Name ${file.path}');

          setState(() {
            //guion = file;
            foto = File(file.path);
          });
        }
      } on PlatformException catch (e) {
        print('Operación no Permitida ' + e.toString());
      }
    } else {
      PickedFile pick;

      pick = await _picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pick != null) {
          foto = File(pick.path);
        } else {
          pick = null;
        }
      });
    }
  }

  _tomarFoto() async {
    final _picker = ImagePicker();
    FocusScope.of(context).requestFocus(new FocusNode());
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    foto = File(image.path);

    if (foto == null) {}
    setState(() {});
  }
}
