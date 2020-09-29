
import 'package:Clapp/src/services/pages/space_details.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class SpacesPage extends StatefulWidget {
  SpacesPage({Key key}) : super(key: key);

  @override
  _SpacesPage createState() => _SpacesPage();
}

class _SpacesPage extends State<SpacesPage> {
  @override
  Widget build(BuildContext context) {
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
                newappbar(),
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
    return ListView(
      children: [

        locaciones(),

      ],
    );
  }

  Widget locaciones() {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 5),
        child: InkWell(
          onTap: () {Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SpaceDetails(
                    )),
          );},
            child: Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                //margin: EdgeInsets.only(top: 10, left: 15,right: 15),

                child: Column(
                  children: [
                    Container(
                      child: Hero(
                        tag: 'assets/img/espacios.PNG',
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                          child: Image(
                            image: AssetImage('assets/img/space1.JPG'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ) ,
                      height: MediaQuery.of(context).size.height - 495,
                      width: MediaQuery.of(context).size.width - 35,
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
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  color: Color.fromRGBO(237, 237, 237, 1.0)),
                              height: 83,
                              width: MediaQuery.of(context).size.width - 35,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                                padding: EdgeInsets.only(top: 7, left: 2, right: 2),
                                child: Container(
                                    child: Text(
                                      "Desert Land Space ",
                                      style: TextStyle(
                                          fontSize: 20.0,
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
                                    "500.000 COP/hora",
                                    style: TextStyle(
                                      fontSize: 19.0,
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
                                      //width:                                  MediaQuery.of(context).size.width - 255,
                                      child: Text(
                                        "Bogota | Usaquen",
                                        style: TextStyle(
                                          fontSize: 19.0,
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
                                      size: 22,
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

  Widget newappbar() {
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
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 7.0, right: 20, top: 37),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.0, right: 16, top: 37),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Text('Espacios',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0))),
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
                    Text('Todo',
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
                        setState(() {});
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
