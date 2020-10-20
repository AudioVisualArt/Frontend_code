import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class MainFilePage extends StatefulWidget {
  ProjectModel projectModel;
  MainFilePage({Key key, this.projectModel}) : super(key: key);

  @override
  _MainFilePage createState() => _MainFilePage();
}

class _MainFilePage extends State<MainFilePage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectModel.proyectName),
      ),
      body: Container(
        child: PDF.network(
          widget.projectModel.main_file,
          height: _size.height,
          width: _size.width,
          placeHolder: Image.asset(
            "assets/img/loader2.gif",
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}