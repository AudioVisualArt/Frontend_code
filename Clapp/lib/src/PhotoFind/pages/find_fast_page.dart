import 'dart:io';
import 'package:tflite/tflite.dart';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;

class FindByPhotoPage extends StatefulWidget {
  FindByPhotoPage({Key key}) : super(key: key);

  @override
  _FindByPhotoPageState createState() => _FindByPhotoPageState();
}

class _FindByPhotoPageState extends State<FindByPhotoPage> {
  File foto;

  List _salida;
  bool _estado = false;

  @override
  void initState() {
    _cargarModelo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Encuentra Por Foto',
            style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
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
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _mostrarFoto(),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clasificarImagen(foto);
        },
        child: Icon(Icons.grain_sharp),
      ),
    );
  }

  Widget _mostrarFoto() {
    //print('FotoURL: ' + equipment.fotoUrl);
    if (foto == null) {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(foto.path),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);

    //foto = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        foto = File(image.path);
      });
    }
  }

  _tomarFoto() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    foto = File(image.path);

    if (foto == null) {
      //limpiar
    }
    setState(() {});
  }

  _clasificarImagen(File image) async {
    if (image != null) {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _salida = output;
        _estado = true;
        print(_salida.toString());
      });
      //await Tflite.close();
    } else {
      utils.mostrarAlerta(context, 'Debes seleccionar o tomar un foto');
    }
  }

  _cargarModelo() async {
    await Tflite.loadModel(
      model: 'assets/model_img/model_unquant.tflite',
      labels: 'assets/model_img/labels.txt',
    );
  }
}
