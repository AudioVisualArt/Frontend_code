import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  OtherPage({Key key}) : super(key: key);

  @override
  _OtherPage createState() => _OtherPage();
}

class _OtherPage extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}