import 'package:flutter/material.dart';
import 'package:Clapp/src/services/pages/contratar_page.dart';

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
      body: Container(

        height: MediaQuery.of(context).size.height -30,
        width: double.infinity,

        child: ContratarPage(),
        )


      );


  }
}