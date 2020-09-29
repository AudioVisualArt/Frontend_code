import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:clay_containers/clay_containers.dart';

final List<String> imgList = [
  'assets/img/space1.JPG',
  'assets/img/espacios.PNG',
];

class SpaceDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SpaceDetails();
  }
}

class _SpaceDetails extends State<SpaceDetails> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height - 30,
          width: double.infinity,
          /*decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          )),

           */
          child: ListView(
            children: [
              _listimages(),
              infospace('Horario', "Lunes a sabados", '9:00 am -9:00 pm'),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only( left: 8, right: 8),
                      child: Container(
                          constraints: BoxConstraints(
                              minWidth:
                                  MediaQuery.of(context).size.width - 20.0,
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight: 220,
                              minHeight: 200),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(227, 227, 227, 1),
                          ),
                          padding: EdgeInsets.all(2),
                          child: Center(
                             child: ClayContainer(
                                 borderRadius: 10,
                                 curveType: CurveType.none,
                               color: Color.fromRGBO(227, 227, 227, 1),
                               depth: 30,
                               spread: 10,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 top: 12.0, left: 10.0, right: 5),
                                             child: Container(
                                               constraints: BoxConstraints(
                                                   minWidth: 100,
                                                   maxWidth: 200,
                                                   maxHeight: 42,
                                                   minHeight: 22),

                                               child: Text(
                                                 'Desert Land Space',
                                                 style: TextStyle(
                                                     fontSize: 20.0,
                                                     fontFamily: "Raleway",
                                                     color: Color.fromRGBO(
                                                         115, 115, 115, 1.0)
                                                         .withOpacity(1),
                                                     fontWeight: FontWeight.bold),
                                               ),
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 10.0, right: 5, top: 12),
                                             child: Container(
                                               constraints: BoxConstraints(
                                                 minWidth: 100,
                                                 maxWidth: 200,
                                                 maxHeight: 22,
                                               ),
                                               child: Text(
                                                 "Bogota | Usaquen",
                                                 style: TextStyle(
                                                   fontSize: 18.0,
                                                   fontFamily: "Raleway",

                                                   color: Color.fromRGBO(
                                                       115, 115, 115, 1.0),
                                                 ),textAlign: TextAlign.justify,
                                               ),
                                             )),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 top: 12, left: 10, right: 12),
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
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 10.0, right: 5, top: 8),
                                             child: Container(
                                               constraints: BoxConstraints(
                                                   minWidth: 100,
                                                   maxWidth: 200,
                                                   maxHeight: 82,
                                                   minHeight: 22),
                                               child: Text(
                                                   'Descripcion We wear disposable gloves and masks to clean and disinfect.',
                                                   style: TextStyle(
                                                     fontSize: 18.0,
                                                     fontFamily: "Raleway",
                                                     color: Color.fromRGBO(
                                                         115, 115, 115, 1.0),
                                                   ),textAlign: TextAlign.justify
                                               ),
                                             )),

                                       ],
                                     ),
                                     Column(
                                       children: [
                                         Align(
                                           alignment: Alignment.topRight,
                                           child: Padding(
                                             padding: EdgeInsets.only(
                                                 top: 16.0, left: 5, right: 15),
                                             child: Container(
                                                 height: 100.0,
                                                 width: 100.0,
                                                 child: ClipRRect(
                                                     borderRadius:
                                                     BorderRadius.circular(100.0),
                                                     child: CircleAvatar(
                                                         radius: 75,
                                                         child: Image(
                                                           image: AssetImage(
                                                               'assets/img/no-image.png'),
                                                           height: 100.0,
                                                           width: 100.0,
                                                           fit: BoxFit.cover,
                                                         )))),
                                           ),
                                         ),
                                         Padding(
                                             padding: EdgeInsets.only(
                                                 left: 7.0, right: 15, top: 4),
                                             child: Container(
                                               constraints: BoxConstraints(
                                                   minWidth: 100,
                                                   maxWidth: 130,
                                                   maxHeight: 42,
                                                   minHeight: 22),
                                               child: Text(
                                                 'Antonio Lemus',
                                                 style: TextStyle(
                                                   fontSize: 18.0,
                                                   fontFamily: "Raleway",
                                                   color: Color.fromRGBO(
                                                       115, 115, 115, 1.0),
                                                 ),
                                               ),
                                             )),
                                         Padding(
                                           padding:
                                           EdgeInsets.only( top: 5,
                                               right: 15.0,
                                               left: 7.0,
                                               bottom: 5),


                                           child: RaisedButton(
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(5.0),
                                             ),
                                             child: Text('Contactar',
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     fontSize: 17.0,
                                                     fontFamily: "Raleway",
                                                     color: Colors.grey,
                                                     fontWeight: FontWeight.bold)),
                                             textColor: Colors.white,
                                             color: Color.fromRGBO(0, 51, 51, 0.8),
                                             onPressed: () {},
                                           ),


                                         )

                                       ],
                                     )
                                   ],
                                 )
                             ),
                          )

                          )),


                  infospace('Tarifa', "3 horas min", '500.000 COP/hora'),


                ],
              )
            ],
          )),
    );
  }
  Widget infospace(String nombre, String der, String izq){
    return
   Padding(
        padding: EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 10),
        child: Container(

            constraints: BoxConstraints(
              minWidth:
              MediaQuery.of(context).size.width - 20.0,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: 100,
            ),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromRGBO(227, 227, 227, 1),
            ),
            padding: EdgeInsets.all(2),
            child: Center(
              child: ClayContainer(
                color: Color.fromRGBO(227, 227, 227, 1),
                  borderRadius: 10,
                  curveType: CurveType.none,
                  depth: 30,
                  spread: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 15, top: 12),
                          child: Container(
                            constraints: BoxConstraints(
                                minWidth: 100,
                                maxWidth: 130,
                                maxHeight: 42,
                                minHeight: 22),
                            child: Text(
                              nombre,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(
                                      115, 115, 115, 1.0),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 15, top: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 162,
                                    maxHeight: 42,
                                    minHeight: 22),
                                child: Text(

                                  der,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(
                                        115, 115, 115, 1.0),
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, right: 15, top: 12),
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 162,
                                    maxHeight: 42,
                                    minHeight: 22),
                                child: Text(
                                  izq,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(
                                        115, 115, 115, 1.0),
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              )),
                        ],
                      )
                    ],
                  )
              ),
            )


        )
    );
  }

  Widget _listimages() {
    return Container(
        padding: EdgeInsets.only(left: 4, right: 4, top: 5),
      child: Center(
        child: ClayContainer(
          borderRadius: 10,
          curveType: CurveType.none,
          color: Color.fromRGBO(227, 227, 227, 1),
          depth: 40,
          spread: 10,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Card(
                  child: Hero(
                    tag: 'assets/img/espacios.PNG',





                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      image: AssetImage('assets/img/space1.JPG'),
                      fit: BoxFit.cover,
                    ),

                  ),
                )
            )
        ),
      )


    );
  }
}
