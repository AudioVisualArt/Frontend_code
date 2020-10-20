import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/pages/profile_page.dart';
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
              'Menu Principal',
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
             Navigator.pushNamed(context, 'profile',
              arguments: userModel);
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
              Navigator.pushNamed(context, 'message',arguments: userModel);
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
              Navigator.pushNamed(context, 'mycontract',arguments: userModel);
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
            onTap: () {},
          )
        ],
      ),
    );
  }
}
