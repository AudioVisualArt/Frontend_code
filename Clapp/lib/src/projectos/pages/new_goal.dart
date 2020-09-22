import 'package:flutter/material.dart';
class NewGoal extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewGoal();
  }

}

class _NewGoal extends State<NewGoal>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Nueva meta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "Raleway",
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                    )),
                //background:
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('Complete los datos',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 17.5, fontFamily: "Raleway"))),
                Container(
                  padding: EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                  child: Form(
                    //key: formKey,

                    child: Column(
                      children: <Widget>[



                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding:
                      EdgeInsets.only(right: 10.0, left: 210,  bottom: 30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('Empezar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                                                  },
                      ),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }

}