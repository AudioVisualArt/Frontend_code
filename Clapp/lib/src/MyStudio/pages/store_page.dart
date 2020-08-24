import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
    );
  }
}
