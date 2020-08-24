import 'package:flutter/material.dart';
import 'package:Clapp/src/MyStudio/pages/new_project_page.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: _createproject(context),
    );
  }


  Widget _createproject(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return
    SingleChildScrollView(
    child: Container(
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.only(
        right: 15.0,
        left: 15.0,
        top: 15.0,
      ),
      //padding: EdgeInsets.symmetric(vertical: 20.0),   //ASI ESTABA ANTES
      child: Form(
        child: Column(
          children: <Widget>[

            TitleBar('All Projects'),

            //button
            SizedBox(height: 60.0),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              label: Text('New Project',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
              textColor: Colors.white,
              icon: Icon(
                Icons.create_new_folder,
                color: Colors.white,
              ),
              color: Color.fromRGBO(89, 122, 121, 1.0),

              onPressed: () { Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                  new NewProjectPage())

              );},
            ),

          ],




        ),
      ),
    ),
    );




  }



}

