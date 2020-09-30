import 'dart:io';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FindPhotoPage extends StatefulWidget {
  FindPhotoPage({Key key}) : super(key: key);

  @override
  _FindPhotoPageState createState() => _FindPhotoPageState();
}

class _FindPhotoPageState extends State<FindPhotoPage> {
  var imageFile;
  File foto;
  final equipmentProvider = EquipmentProvider();
  String imagePath;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escanea o Sube tu Foto'),
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
          children: [
            Flexible(
              flex: 2,
              child: _mostrarFoto(),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanner,
        child: Icon(Icons.check),
      ),
    );
  }

  _seleccionarFoto() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    imageFile = await tempStore.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);

    setState(() {
      foto = File(tempStore.path);

      imageFile = imageFile;
    });
  }

  _tomarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.camera);

    if (foto == null) {
      //limpiar
      setState(() {});
    }
  }

  Widget _mostrarFoto() {
    if (foto != null) {
      return Image(
        image: AssetImage(foto.path),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return Image(
        image: AssetImage(foto?.path ?? 'assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  scanner() {
    detectImage();
  }

  Future detectImage() async {
    String result = '';
    if (foto != null) {
      FirebaseVisionImage image = FirebaseVisionImage.fromFile(foto);
      ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
      List labels = await labeler.processImage(image);

      for (ImageLabel label in labels) {
        final String text = label.text;
        final double confidence = label.confidence;
        setState(() {
          result = result + ' ' + '$text     $confidence' + '\n';
        });
      }
      print('${labels.length} : $result');
    } else {
      return '';
    }
  }
}
