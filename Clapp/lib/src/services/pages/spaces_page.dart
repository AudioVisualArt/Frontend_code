import 'package:flutter/material.dart';

class SpacesPage extends StatefulWidget {
  SpacesPage({Key key}) : super(key: key);

  @override
  _SpacesPage createState() => _SpacesPage();
}

class _SpacesPage extends State<SpacesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espacios',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}