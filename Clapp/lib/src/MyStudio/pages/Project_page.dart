import 'package:Clapp/src/MyStudio/widgets/navigationBar_widget.dart';
import 'package:flutter/material.dart';

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
      body: _crearBody(context),
      bottomNavigationBar: BarraNavegacion(),
    );
  }

  Widget _crearBody(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Text('All projects',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")
              ),
              //Projects

              //button
              SizedBox(height: 50.0),
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
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                onPressed: () {},
              ),
              SizedBox(height: 30.0),

            ],
          ),
        ),
      ),
    );
  }
}
