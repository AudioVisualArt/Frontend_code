import 'package:Clapp/src/User/models/mensaje_model.dart';
import 'package:Clapp/src/User/providers/chat_provider.dart';
import 'package:Clapp/src/services/pages/services_page.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChatProvider chatprovider=new ChatProvider();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
   
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        //shadowColor: Colors.grey,
        title: Text('CLAPP',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      drawer: MenuWidget(
        userModel: usuario,
      ),
      //Rest backend Springboot
      body: _crearBody(context, usuario)
      ,
    );
  }

  Widget _crearBody(BuildContext context, UserModel usuario) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/img/home.jpg"),
        fit: BoxFit.fill,
      )),
      child: Container(
        height: MediaQuery.of(context).size.height - 30.0,
        width: size.width,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: Form(
          child: Column(
            children: <Widget>[
              _mostrarFotoPerfil(),
              SizedBox(height: 70.0),
              SizedBox(
                width: 150,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('Estudio',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold)),
                  textColor: Color.fromRGBO(115, 115, 115, 1.0),
                  color: Color.fromRGBO(227, 227, 227, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  onPressed: () => Navigator.pushNamed(context, 'my_studio',
                      arguments: usuario),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                width: 150,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('Mercado',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold)),
                  textColor: Color.fromRGBO(115, 115, 115, 1.0),
                  color: Color.fromRGBO(227, 227, 227, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  onPressed: () => Navigator.pushNamed(context, 'items_buy',
                      arguments: usuario),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                width: 150,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('Servicios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold)),
                  textColor: Color.fromRGBO(115, 115, 115, 1.0),
                  color: Color.fromRGBO(227, 227, 227, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  onPressed: () {
                    Navigator.pushNamed(context, 'services',
                        arguments: usuario);
                  },
                ),
              ),

              /*  RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                label: Text('Foros',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                textColor: Colors.white,
                icon: Icon(Icons.forum, color: Colors.white),
                color: Color.fromRGBO(89, 122, 121, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                onPressed: () {},
              ),


             */
            ],
          ),
        ),
      ),
    );
  }

  Widget _mostrarFotoPerfil() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          image: DecorationImage(
            image: AssetImage('assets/img/APP ICON.png'),
            fit: BoxFit.cover,
          )),
      height: 220.0,
      width: 220.0,
    );
  }

  List<Widget> crear() {
    return [
      RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        label: Text('Ingresar Producto'),
        textColor: Colors.white,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        color: Color.fromRGBO(89, 122, 121, 1.0),
        onPressed: () => Navigator.pushNamed(
          context,
          'producto',
        ),
      ),
      RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        label: Text('Ver Inventario'),
        textColor: Colors.white,
        icon: Icon(Icons.art_track, color: Colors.white),
        color: Color.fromRGBO(89, 122, 121, 1.0),
        onPressed: () => Navigator.pushNamed(context, 'ver_producto'),
      ),
    ];
  }
}
