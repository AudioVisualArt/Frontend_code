import 'package:Clapp/src/Market/pages/show_equipments_page.dart';
import 'package:Clapp/src/Market/pages/show_screenplays_page.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'package:flutter/material.dart';
class ElementoMenu extends StatelessWidget{
  final String name;
  final int onPressed;
  final UserModel usuario;
  final String imagenIcono;
  final colorfondo;
  ElementoMenu({this.name, this.onPressed, this.usuario, this.imagenIcono, this.colorfondo});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.only(left: 5),
        child: InkWell(
          onTap: () {
            switch (onPressed) {
              case 0:
                Navigator.pushNamed(context, 'proyectos', arguments: usuario);

                break;
              case 1:
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new MostrarProductosPage(
                        userModel: usuario,
                      ),
                    ));
                break;
              case 2:
                Navigator.pushNamed(context, 'open_contracts',
                    arguments: usuario);
                break;
              case 3:
                Navigator.pushNamed(context, 'contratos', arguments: usuario);
                break;
              case 4:
                Navigator.pushNamed(context, 'open_contracts',
                    arguments: usuario);
                break;
              case 5:
                Navigator.pushNamed(context, 'space', arguments: usuario);
                break;
              case 6:
                Navigator.pushNamed(context, 'find_photo', arguments: usuario);
                break;
              case 7:
                Navigator.pushNamed(context, 'items_buy', arguments: usuario);
                break;
              case 8:
                Navigator.pushNamed(context, 'mycontract', arguments: usuario);
                break;
              case 9:
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ShowEquipmentPage(
                          userModel: usuario,
                        )));
                break;

              case 10:
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ShowScreenPlayPage(
                          userModel: usuario,
                        )));
                break;
              case 11:
                print("Falta la ruta");
                break;
            }
            ;
          },
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 115, //MediaQuery.of(context).size.height - 570,
              maxWidth: 115, //MediaQuery.of(context).size.width - 250,
              minWidth: 101, //MediaQuery.of(context).size.width - 310
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image(
                        image: AssetImage(imagenIcono),
                        fit: BoxFit.cover,
                      ),
                    ),

                    height: 68, //MediaQuery.of(context).size.height - 615,
                    width: 68, // MediaQuery.of(context).size.width - 340,
                    decoration: BoxDecoration(
                      color: colorfondo,
                      borderRadius: BorderRadius.circular(12.0),
                      /* border: Border.all(
                        width: 1.3,
                        color: Color.fromRGBO(0, 51, 51, 0.8),
                      ),
                      */
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(name,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 51, 51, 0.9),
                          fontSize: 18,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ));
  }


}