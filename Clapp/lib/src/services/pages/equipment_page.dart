import 'package:flutter/material.dart';

class EquipmentPage extends StatefulWidget {
  EquipmentPage({Key key}) : super(key: key);

  @override
  _EquipmentPage createState() => _EquipmentPage();
}

class _EquipmentPage extends State<EquipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}