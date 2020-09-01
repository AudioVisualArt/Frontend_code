import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Ajustes:',
              style: TextStyle(
                  fontSize: 45.0,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
