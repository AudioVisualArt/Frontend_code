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

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          )
        ),
    child: Column(
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
      ),)
    );
  }



  Widget _MenuServicios(){
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 30),
      child: ListView(
        children: [
          opcionesMenu1(),
          //opcionesMenu2(),
          //opcionesMenu3(),
          //opcionesMenu4(),
        ],
      )
      /*child: GridView.count(crossAxisCount: 1,
        children: <Widget>[
          opcionesMenu1(),
          opcionesMenu2(),
          opcionesMenu3(),
          opcionesMenu4(),

        ],)

       */


      ,
    );
  }


  Widget opcionesMenu2(){
    return Card(


      margin: EdgeInsets.only(right: 1.0, left: 1, top: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),


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
  Widget opcionesMenu1(){
    return Card(

        margin: EdgeInsets.only(top: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        child: InkWell(
            onTap: (){Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new AudiovisualPage()));},

            child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0.0),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                          blurRadius: 0.3,
                          //offset: Offset(0,6),
                        )
                      ]
                  ),
                  child: Stack(
                    children: [
                      Row(

                        children: [
                          Container(
                            height: 200.0,
                            width: 195.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                image: DecorationImage(
                                  image: AssetImage("assets/img/audiovisual1.PNG"),
                                  fit: BoxFit.cover,

                                )
                            ),

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [


                              Padding(
                                padding: EdgeInsets.only(top: 60,  left: 180),
                              ) ,


                              Container(
                                child: Text("Artes",
                                  style: TextStyle(fontSize: 23.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),),

                              ),
                              Container(
                                child: Text("Audiovisuales",
                                  style: TextStyle(fontSize: 23.0, fontFamily: "Raleway",color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold ),),

                              )
                            ],
                          )


                        ],
                      ),

                    ],
                  ),
                )
            )
        )

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