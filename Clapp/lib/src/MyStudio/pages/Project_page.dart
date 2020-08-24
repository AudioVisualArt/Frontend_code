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
      body: Container(),
    );
  }
}
