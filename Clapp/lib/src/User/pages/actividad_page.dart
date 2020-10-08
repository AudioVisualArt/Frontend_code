import 'package:flutter/material.dart';

class ActividadPage extends StatefulWidget {
  ActividadPage({Key key}) : super(key: key);

  @override
  _ActividadPageState createState() => _ActividadPageState();
}

class _ActividadPageState extends State<ActividadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Actividad',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
    );
  }
}
