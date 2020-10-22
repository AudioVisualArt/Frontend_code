import 'dart:math';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/Space/pages/new_space.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';

class TopLocaciones extends StatelessWidget {
  final SpaceModel espacio;
  final UserModel user;

  TopLocaciones({this.espacio, this.user});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(bottom: 9.7),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'space_details',
                  arguments: SegPagina(user, espacio));
            },
            child: Container(
              width: 190,
              child: Hero(
                tag: espacio.id,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Container(
                            width: 180,
                            height: 260,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(112, 252, 118, 1),
                                  Color.fromRGBO(89, 122, 121, 1),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 8),
                                  blurRadius: 25,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                    left: 10,
                                    right: 10,
                                    top: 14,
                                    child: Container(
                                      width: 170,
                                      height: 22,
                                      /*  constraints: BoxConstraints(
                              maxWidth: 170,
                              maxHeight: 24
                            ),

                           */
                                      child: Text(espacio.name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: "Raleway",
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ))
                              ],
                            )),
                      ),
                    ),
                    Positioned(
                        top: 70,
                        left: 5,
                        right: 5,
                        child: _imagenEquipo(espacio))
                  ],
                ),
              ),
            )));
  }

  Widget _imagenEquipo(SpaceModel espacio) {
    if (espacio.imageUrl.isEmpty || espacio.imageUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          //width: wid,
          width: 178,
          height: 219.5,
        ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                espacio.imageUrl,
              ),
              width: 178,
              height: 219.5,
              fit: BoxFit.cover));
    }
  }
}
