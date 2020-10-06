import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class HVPage extends StatefulWidget {
  String workerHv;
  HVPage({Key key, this.workerHv}) : super(key: key);

  @override
  _HVPage createState() => _HVPage();
}

class _HVPage extends State<HVPage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.workerModel.),
      ),
      body: Container(
        child: PDF.network(
          widget.workerHv,
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