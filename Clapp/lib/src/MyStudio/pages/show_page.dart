import 'package:flutter/material.dart';

class ShowPage extends StatefulWidget {
  ShowPage({Key key}) : super(key: key);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}
