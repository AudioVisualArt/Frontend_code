

import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/Space/pages/new_space.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class SpacesPage extends StatefulWidget {
  final UserModel user;
  SpacesPage({Key key, this.user}) : super(key: key);



  @override
  _SpacesPage createState() => _SpacesPage();
}

class _SpacesPage extends State<SpacesPage> {
  final spacesProvider = new SpacesProvider ();
  UserModel user;
  List<dynamic> arguments=new List();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    user=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostraritems.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 30.0,
            padding: EdgeInsets.only(
              right: 1.0,
              left: 1.0,
            ),

            //key: formKey,
            child: Column(
              children: <Widget>[
                newappbar(usuario),
                Expanded(
                    child: Container(
                  child: _crearListado(),
                  //padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 210,
                )),
              ],
            )),
      ),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: spacesProvider.cargarEspacios(),
    builder:
    (BuildContext context, AsyncSnapshot<List<SpaceModel>> snapshot) {
      if (snapshot.hasData) {
        final espacios = snapshot.data;
        return ListView.builder(
          itemCount: espacios.length,
          itemBuilder: (context, index) =>
          locaciones(context, espacios[index]),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    );
  }

  Widget locaciones(BuildContext context, SpaceModel espacio) {
    return Padding(
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 6, bottom: 5),
        child: InkWell(
          onTap: () {
            //this.arguments.add(user);
            //this.arguments.add(espacio);
            Navigator.pushNamed(context, 'space_details',
              arguments: SegPagina(user, espacio));},
            child: Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                //margin: EdgeInsets.only(top: 10, left: 15,right: 15),

                child: Column(
                  children: [
                    Container(
                      child: Hero(
                        tag: espacio.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                          child: FadeInImage(
                            placeholder: AssetImage('assets/img/loader3.gif'),
                            image: NetworkImage(espacio.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ) ,
                      height: 235, //MediaQuery.of(context).size.height - 495,
                      width: MediaQuery.of(context).size.width - 25,
                    ),
                    Stack(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Color.fromRGBO(237, 237, 237, 1.0)),
                              height: 83,
                              width: MediaQuery.of(context).size.width - 25,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                                padding: EdgeInsets.only(top: 7, left: 2, right: 2),
                                child: Container(
                                    child: Text(
                                      espacio.name,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Padding(
                                padding: EdgeInsets.only(
                                  top: 2,
                                  left: 12,
                                ),
                                child: Container(
                                  //width:                              MediaQuery.of(context).size.width - 240,
                                  child: Text(
                                    "${espacio.priceHour.toString()} COP/hora",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 2, left: 15, right: 12),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 200,
                                        maxHeight: 23
                                      ),
                                      //width:                                  MediaQuery.of(context).size.width - 255,
                                      child: Text(
                                        espacio.location,
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(115, 115, 115, 1.0),
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding:
                                    EdgeInsets.only(top: 2, left: 8, right: 12),
                                    child: SmoothStarRating(
                                      rating: 0,
                                      isReadOnly: false,
                                      size: 18,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      defaultIconData: Icons.star_border,
                                      starCount: 5,
                                      allowHalfRating: true,
                                      spacing: 2.0,
                                      onRated: (value) {
                                        print("rating value -> $value");
                                      },
                                    )),


                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ))
        )
        );
  }
  Widget newappbar(
      UserModel usuario
      ) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(252, 252, 252, 1),
                  Color.fromRGBO(252, 252, 252, 1),
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 7.0, right: 20, top: 37),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 37),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width-80,


                      child: Align(
                        alignment: Alignment(-0.45, 0.0),
                        child: Text('Espacios',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0))),
                      ),

                    ),
                  ),
                ),

              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Actualizar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(115, 115, 115, 1.0),
                            fontSize: 17.5,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      iconSize: 22,
                      icon: Icon(Icons.autorenew),
                      onPressed: () {
                        setState(() {
                          //_crearListado(userModel.id);
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
  Widget _botonEspacioNuevo(
     UserModel userModel
      ) {
    return RaisedButton(
      splashColor: Colors.grey,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromRGBO(0, 51, 51, 1), width: 1.2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),

      child: Text(' Nuevo  ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 21.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(0, 51, 51, 1),
              fontWeight: FontWeight.bold)),
      //textColor: Colors.white,
      color: Colors.white,

      onPressed: () {
        Navigator.pushNamed(context,'nuevoespacio', arguments: userModel);

       //ver routes
      },
    );
  }


}
