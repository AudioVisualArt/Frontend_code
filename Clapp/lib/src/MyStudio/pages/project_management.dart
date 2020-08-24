import 'package:flutter/material.dart';
import 'package:Clapp/src/MyStudio/pages/new_contract.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';

class ProjectManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectManagement();
  }
}

class _ProjectManagement extends State<ProjectManagement> {
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
            appBar: AppBar(
              title: Text('Project Management',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
            ),
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                      right: 15.0,
                      left: 15.0,
                      top: 15.0,
                    ),
                    child: Form(
                        //key: formKey,
                        child: Column(
                      children: <Widget>[
                        TitleBar('Actors'),
// ACA VAN ACTORES
                        SizedBox(height: 400),
                        RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          label: Text('Create New Contract',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0, fontFamily: "Raleway")),
                          textColor: Colors.white,
                          icon: Icon(
                            Icons.work,
                            color: Colors.white,
                          ),
                          color: Color.fromRGBO(89, 122, 121, 1.0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new NewContract()));
                          },
                        ),
                      ],
                    ))))));
  }


}
