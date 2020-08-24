import 'package:flutter/material.dart';

class ManagePage extends StatefulWidget {
  ManagePage({Key key}) : super(key: key);

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}
