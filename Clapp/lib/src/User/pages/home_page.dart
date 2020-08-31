import 'package:flutter/material.dart';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      drawer: MenuWidget(
        userModel: usuario,
      ),
      //Rest backend Springboot
      body: _crearBody(context, usuario),
    );
  }

  Widget _crearBody(BuildContext context, UserModel usuario) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              _mostrarFotoPerfil(),
              SizedBox(height: 50.0),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                label: Text('My Studio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                textColor: Colors.white,
                icon: Icon(
                  Icons.streetview,
                  color: Colors.white,
                ),
                color: Color.fromRGBO(89, 122, 121, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                onPressed: () => Navigator.pushNamed(context, 'my_studio',
                    arguments: usuario),
              ),
              SizedBox(height: 30.0),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                label: Text('Market',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                textColor: Colors.white,
                icon: Icon(Icons.store, color: Colors.white),
                color: Color.fromRGBO(89, 122, 121, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                onPressed: () => Navigator.pushNamed(context, 'producto'),
              ),
              SizedBox(height: 30.0),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                label: Text('Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                textColor: Colors.white,
                icon: Icon(Icons.storage, color: Colors.white),
                color: Color.fromRGBO(89, 122, 121, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                onPressed: () {},
              ),
              SizedBox(height: 30.0),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                label: Text('Forums',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                textColor: Colors.white,
                icon: Icon(Icons.forum, color: Colors.white),
                color: Color.fromRGBO(89, 122, 121, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mostrarFotoPerfil() {
    return Image(
      image: AssetImage('assets/img/no-image.png'),
      height: 200.0,
      width: 200.0,
      fit: BoxFit.cover,
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
