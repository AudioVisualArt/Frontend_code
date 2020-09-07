import 'package:Clapp/src/services/pages/audiovisual_page.dart';
import 'package:Clapp/src/services/pages/new_service.dart';
import 'package:flutter/cupertino.dart';
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
        title: Text('Servicios',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),

      body: Column(
        children: <Widget> [
         Expanded(
            child: _MenuServicios(),

         ),
         SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(bottom: 20.0),

          child: RaisedButton.icon(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            label: Text('Nuevo Servicio',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
            textColor: Colors.white,
            icon: Icon(
              Icons.create_new_folder,
              color: Colors.white,
            ),
            color: Color.fromRGBO(89, 122, 121, 1.0),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new NewService()));
            },
          ),),
        ],
      ),
    );
  }



  Widget _MenuServicios(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GridView.count(crossAxisCount: 2,
        children: <Widget>[
          opcionesMenu1(),
          opcionesMenu2(),
          opcionesMenu3(),
          opcionesMenu4(),

        ],)
      ,
    );
  }


  Widget opcionesMenu1(){
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new AudiovisualPage()));},
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
              Text("Arte Audiovisual",
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
              Text("Producción musical",
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
              Text("Artes Escénicas",
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

              Text("Modelaje",
                  style: TextStyle(fontSize: 17.0, fontFamily: "Raleway"))

            ],
          ),
        ),
      ),
    );
  }



}