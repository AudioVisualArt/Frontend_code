import 'package:flutter/material.dart';

import 'package:Clapp/src/ScreenPlay/Model/screenplay_models.dart';
import 'package:Clapp/src/User/models/user_model.dart';

class ShowScreenPlayPage extends StatefulWidget {
  final List<ScreenPlayModel> screenPlays;
  final UserModel userModel;
  ShowScreenPlayPage(
      {List<ScreenPlayModel> this.screenPlays,
      UserModel this.userModel,
      Key key})
      : super(key: key);

  @override
  _ShowScreenPlayPageState createState() => _ShowScreenPlayPageState();
}

class _ShowScreenPlayPageState extends State<ShowScreenPlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guiones',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostraritems.jpg"),
          fit: BoxFit.cover,
        )),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Container(), //_crearListadoEquipments(),
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
