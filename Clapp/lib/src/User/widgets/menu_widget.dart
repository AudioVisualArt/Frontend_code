import 'package:Clapp/src/Space/pages/mostrar_dialog.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/profile_page.dart';
import 'package:Clapp/src/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final UserModel userModel;
  const MenuWidget({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserModel usuario = ModalRoute.of(context).settings.arguments;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Color.fromRGBO(0, 51, 51, 1.0),
              Color.fromRGBO(89, 122, 121, 1.0)
            ])),
          ),
          //Menu Principal
          ListTile(
            leading: Icon(
              Icons.home,
              size: 30.0,
              color: Color.fromRGBO(0, 51, 51, 1.0),
            ),
            title: Text(
              'Menú Principal',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'home',
                  arguments: userModel);
            },
          ),
          Divider(),
          //Perfil
          ListTile(
            leading: Icon(
              Icons.person,
              size: 30.0,
              color: Color.fromRGBO(0, 51, 51, 1.0),
            ),
            title: Text(
              'Perfil',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () {
              Navigator.pop(context);
              /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(usuario: userModel,)));

              */
              Navigator.pushNamed(context, 'profile', arguments: userModel);
            },
          ),
          Divider(),
          //Favoritos
          ListTile(
            leading: Icon(
              Icons.add_to_home_screen_outlined,
              size: 30.0,
              color: Color.fromRGBO(0, 51, 51, 1.0),
            ),
            title: Text(
              'Actividad',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'actividad', arguments: userModel);
            },
          ),
          Divider(),
          //Mensajes
          ListTile(
            leading: Icon(
              Icons.message,
              size: 30.0,
              color: Color.fromRGBO(0, 51, 51, 1.0),
            ),
            title: Text(
              'Mensajes',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'message', arguments: userModel);
            },
          ),
          //Configuraciòn
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30.0,
              color: Color.fromRGBO(0, 51, 51, 1.0),
            ),
            title: Text(
              'Configuración',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'settings');
            },
          ),
          Divider(),
          //Contratos
          ListTile(
            leading: Icon(
              Icons.assignment_ind,
              size: 30.0,
              color: Color.fromRGBO(0, 51, 51, 1.0),
            ),
            title: Text(
              'Contratos',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'mycontract', arguments: userModel);
            },
          ),
          //Terminar Sesión
          ListTile(
            leading: Icon(
              Icons.remove_circle_outline,
              size: 30.0,
              color: Colors.red[900],
            ),
            title: Text(
              'Salir',
              style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
            ),
            onTap: () async {
    
              MostrarDialog2(context, "Vuelva pronto","Ha cerrado sesion correctamente");
             
            },
          )
        ],
      ),
    );
  }
  void MostrarDialog2(BuildContext context, String mensaje, String description) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                height: 260,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 8),
                      blurRadius: 25,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0),
                      child: Text(
                        mensaje,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 24.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(89, 122, 121, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                      child: Text(description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(89, 122, 121, 1),
                          )),
                    ),
                  ],
                )),
            Positioned(
                top: 0,
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(112, 252, 118, 1),
                        Color.fromRGBO(89, 122, 121, 1),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                )),
            Positioned(
                top: 200,
                child: OutlineButton(
                    child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Raleway",
                            //color: Color.fromRGBO(112, 252, 118, 0.8),
                            color: Color.fromRGBO(89, 122, 121, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, 'login');
                    },
                    //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                    highlightedBorderColor: Color.fromRGBO(112, 252, 118, 0.8),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(89, 122, 121, 1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
            Positioned(
              top: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: AssetImage("assets/img/APP ICON.png"),
                        height: 100.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
}
