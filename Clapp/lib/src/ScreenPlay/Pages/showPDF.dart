import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class ShowPDF extends StatefulWidget {
  ScreenPlayModel screenPlayModel;
  ShowPDF({Key key, this.screenPlayModel}) : super(key: key);

  @override
  _ShowPDFState createState() => _ShowPDFState();
}

class _ShowPDFState extends State<ShowPDF> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screenPlayModel.titulo),
      ),
      body: Container(
        child: PDF.network(
          widget.screenPlayModel.fotoUrl,
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
