import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:flutter/material.dart';

class RecomendadosMarket extends StatelessWidget{
  final EquipmentModel equipos;
  RecomendadosMarket({this.equipos});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.7),
      child: Container(
        width: 190,
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
                              child: Text(equipos.titulo,
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
            Positioned(top: 70, left: 5, right: 5, child: _imagenEquipo(equipos))
          ],
        ),
      ),
    );



  }
  Widget _imagenEquipo(EquipmentModel equipment) {
    if (equipment.fotoUrl.isEmpty || equipment.fotoUrl == null) {
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
                equipment.fotoUrl,
              ),
              width: 178,
              height: 219.5,
              fit: BoxFit.cover));
    }
  }

}