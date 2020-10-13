import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final UserModel usuario;
  ProfilePage({Key key, this.usuario}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List tags = ['Informacion', 'Eventos', 'Eliminar cuenta'];
  bool _hasBeenPressed = false;
  final userProvider = new UsuarioProvider();
  final workerProvider = new WorkersProvider();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Color.fromRGBO(89, 122, 121, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color.fromRGBO(246, 246, 246, 1.0),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(89, 122, 121, 1),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.more_vert,
                color: Color.fromRGBO(246, 246, 246, 1.0),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 7.0, left: 28, right: 10),
                  child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: _constructorImagen(usuario)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 18.0),
                      child: Text(
                        "Hola,",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(227, 227, 227, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0, left: 18.0),
                      child: Text(
                        usuario.name,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(246, 246, 246, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "${usuario.cityResidence}-Colombia",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(227, 227, 227, 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    /*Padding(
                      padding: EdgeInsets.only(left: 35.0),
                      child: Text(
                        "Productor",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35.0),
                      child: Text(
                        "cualquiera",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                     */
                  ],
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 35,
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: OutlineButton(
                      child: Center(
                        child: Text(
                          "Editar perfil",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Raleway",
                              //color: Color.fromRGBO(112, 252, 118, 0.8),
                              color: Color.fromRGBO(227, 227, 227, 1.0),
                              /*color: _hasBeenPressed
                                          ? Color.fromRGBO(112, 252, 118, 0.8)
                                          : Color.fromRGBO(227, 227, 227, 1.0),

                                       */
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'editar_perfil',
                        ); //ver routes
                        setState(() {
                          _hasBeenPressed = !_hasBeenPressed;
                        });
                      },
                      //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                      highlightedBorderColor:
                          Color.fromRGBO(112, 252, 118, 0.8),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 1.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ))),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //color: Color.fromRGBO(227, 227, 227, 1.0),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 25.0, left: 25, right: 25),
                      child: Text("Perfil",
                          style: TextStyle(
                              fontSize: 27.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0),
                              fontWeight: FontWeight.bold)),
                    ),
                    /* Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: OutlineButton(
                                            child: Center(
                                              child: Text(
                                                "Editar perfil",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "Raleway",
                                                    //color: Color.fromRGBO(112, 252, 118, 0.8),
                                                    //color: Color.fromRGBO(227,227,227, 1.0),
                                                    color: _hasBeenPressed
                                                        ? Color.fromRGBO(112, 252, 118, 0.8)
                                                        : Color.fromRGBO(227, 227, 227, 1.0),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _hasBeenPressed = !_hasBeenPressed;
                                              });
                                            },
                                            //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                                            highlightedBorderColor:
                                            Color.fromRGBO(112, 252, 118, 0.8),
                                            borderSide: BorderSide(color: Color.fromRGBO(227, 227, 227, 1.0),),
                                            shape: RoundedRectangleBorder(

                                              borderRadius: BorderRadius.circular(30.0),))),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: OutlineButton(
                                            child: Center(
                                              child: Text(
                                                "Editar perfil",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "Raleway",
                                                    //color: Color.fromRGBO(112, 252, 118, 0.8),
                                                    //color: Color.fromRGBO(227,227,227, 1.0),
                                                    color: _hasBeenPressed
                                                        ? Color.fromRGBO(112, 252, 118, 0.8)
                                                        : Color.fromRGBO(227, 227, 227, 1.0),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _hasBeenPressed = !_hasBeenPressed;
                                              });
                                            },
                                            //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                                            highlightedBorderColor:
                                            Color.fromRGBO(112, 252, 118, 0.8),
                                            borderSide: BorderSide(color: Color.fromRGBO(227, 227, 227, 1.0),),
                                            shape: RoundedRectangleBorder(

                                              borderRadius: BorderRadius.circular(30.0),))),
                                  ),
                                ],
                              ),
                            ),

                            */

                    Container(
                      padding: EdgeInsets.only(right: 25.0, left: 25, top: 5),
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(right: 17.0, top: 3),
                                child: index == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            tags[index],
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                fontFamily: "Raleway",
                                                color: Color.fromRGBO(
                                                    115, 115, 115, 1.0),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          CircleAvatar(
                                            radius: 2,
                                            backgroundColor: Colors.black12,
                                          )
                                        ],
                                      )
                                    : Text(tags[index],
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: "Raleway",
                                            color: Color.fromRGBO(
                                                115, 115, 115, 1.0),
                                            fontWeight: FontWeight.bold)));
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color.fromRGBO(227, 227, 227, 1),
                          ),
                          height: 150,
                          width: MediaQuery.of(context).size.width - 30.0,
                          margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          padding: EdgeInsets.only(
                            top: 10.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "Descripcion",
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        fontFamily: "Raleway",
                                        color:
                                            Color.fromRGBO(115, 115, 115, 1.0),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Text(
                                usuario.description,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(115, 115, 115, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    //_serviciosperfil(usuario),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _constructorImagen(UserModel user) {
    if (user.photoUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          width: 100.0,
          height: 100.0,
        ),
      );
    } else if (user.photoUrl != null || user.photoUrl.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                user.photoUrl,
              ),
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover));
    }
  }
}
