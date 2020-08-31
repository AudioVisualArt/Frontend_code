import 'package:flutter/material.dart';

class ServicesPages extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ServicesPages();
  }

}

class _ServicesPages extends State<ServicesPages>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Services',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),

      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(crossAxisCount: 2,
          children: <Widget>[
            opcionesMenu1(),
            opcionesMenu2(),
            opcionesMenu3(),
            opcionesMenu4(),


          ],),
      ),
    );
  }





  Widget opcionesMenu1(){
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Color.fromRGBO(0, 51, 51, 1.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ImageIcon(
                AssetImage("assets/img/visual-production_vintage-film-camera-512.png"),
                color: Color(0xFF3A5A98),

                size: 70.0,
              ),
              Text("Audiovisual Arts",
                  style: TextStyle(fontSize: 17.0, fontFamily: "Raleway"))

            ],
          ),
        ),
      ),
    );
  }
  Widget opcionesMenu2(){
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Color.fromRGBO(209, 209, 209, 1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ImageIcon(
                AssetImage("assets/img/headphone-clipart-student-centers-9.png"),
                color: Color.fromRGBO(0, 51, 51, 1.0),

                size: 70.0,
              ),
              Text("Music Production",
                  style: TextStyle(fontSize: 17.0, fontFamily: "Raleway"))

            ],
          ),
        ),
      ),
    );
  }
  Widget opcionesMenu3(){
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Color.fromRGBO(209, 209, 209, 1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ImageIcon(
                AssetImage("assets/img/Performing-Arts-512.png"),
                color: Color.fromRGBO(0, 51, 51, 1.0),

                size: 70.0,
              ),
              Text("Performative arts",
                  style: TextStyle(fontSize: 17.0, fontFamily: "Raleway"))

            ],
          ),
        ),
      ),
    );
  }
  Widget opcionesMenu4(){
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Color.fromRGBO(209, 209, 209, 1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ImageIcon(
                AssetImage("assets/img/modelinggicon.png"),
                color: Color.fromRGBO(0, 51, 51, 1.0),

                size: 70.0,
              ),

              Text("Modeling",
                  style: TextStyle(fontSize: 17.0, fontFamily: "Raleway"))

            ],
          ),
        ),
      ),
    );
  }

  Widget _mostrarFoto() {
    return Image(
      image: AssetImage('assets/img/no-image.png'),
      height: 200.0,
      width: 200.0,
      fit: BoxFit.cover,
    );
  }

}