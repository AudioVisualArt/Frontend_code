import 'dart:io';
import 'package:Clapp/src/PhotoFind/pages/show_found_equipments.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
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
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostrarItems2.jpeg"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.0,
            ),
            Center(child: _mostrarFoto()),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8.0,
        splashColor: Color.fromRGBO(112, 252, 118, 1.0),
        backgroundColor: Color.fromRGBO(0, 51, 51, 1.0),
        onPressed: () {
          _clasificarImagen(foto, userModel);
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
      try {
        pick = await _picker.getImage(source: ImageSource.gallery);
        foto = File(pick.path);

        setState(() {});
      } catch (e) {
        print('$e');
      }
    }
  }

  _tomarFoto() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    foto = File(image.path);

    if (image != null) {
      setState(() {
        foto = File(image.path);
      });
    }
  }

  _clasificarImagen(File image, UserModel userModel) async {
    String etiqueta;
    double confianza;
    if (image != null) {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _salida = output;
        _estado = true;
        confianza = _salida[0]["confidence"] * 100;
        etiqueta = _salida[0]["label"];
        print(
            '${etiqueta.substring(etiqueta.lastIndexOf(" ")).trim()} & $confianza');

        if (confianza > 90) {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ShowFoundImagePage(
                        etiqueta: etiqueta
                            .substring(etiqueta.lastIndexOf(" "))
                            .trim(),
                        userModel: userModel,
                        file: image,
                      )));
        } else {
          utils.mostrarAlerta(context,
              'Actualmente no tenemos equipmentes de este tipo en el mercado');
        }
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
