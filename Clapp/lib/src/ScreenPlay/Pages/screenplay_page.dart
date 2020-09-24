import 'dart:io';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenPlayPage extends StatefulWidget {
  UserModel userModel;
  ScreenPlayPage({this.userModel});

  @override
  _ScreenPlayPageState createState() => _ScreenPlayPageState();
}

class _ScreenPlayPageState extends State<ScreenPlayPage> {
  bool _saved = false;
  String _path;
  String _extension;
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guión'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Colors.black,
            ),
            onPressed: openFileExplorer,
          ),
        ],
      ),
    );
  }

  openFileExplorer() async {
    try {
      FilePickerResult picker = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);

      if (picker != null) {
        File file = picker.files.first as File;
        print('File Name ${file.path}');

        setState(() {
          _saved = true;
        });
      }
    } on PlatformException catch (e) {
      print('Operación no Permitida ' + e.toString());
    }
  }
}
