import 'package:flutter/material.dart';

class PersonelPage extends StatefulWidget {
  PersonelPage({Key key}) : super(key: key);

  @override
  _PersonelPage createState() => _PersonelPage();
}

class _PersonelPage extends State<PersonelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}