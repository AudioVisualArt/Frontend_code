import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditProfile();
  }
}

class _EditProfile extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child: Scaffold(

        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Color.fromRGBO(89, 122, 121, 1),
            //Color.fromRGBO(214, 214, 214, 1.0)

                /*   image: DecorationImage(
              image: AssetImage("assets/img/mostraritems.jpg"),
              fit: BoxFit.cover,
            )

              */
                ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 30.0,
                padding: EdgeInsets.only(
                  right: 1.0,
                  left: 1.0,
                ),

                //key: formKey,
                child: Column(children: <Widget>[
                  newappbar(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image(
                        image: AssetImage('assets/img/no-image.png'),
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    )),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: OutlineButton(
                            child: Center(
                              child: Text(
                                "Cambiar foto del perfil",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Raleway",
                                    //color: Color.fromRGBO(112, 252, 118, 0.8),
                                    color: Color.fromRGBO(246, 246, 246, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {},
                            //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                            highlightedBorderColor:
                                Color.fromRGBO(112, 252, 118, 0.8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(246, 246, 246, 1.0),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      height: 1.2,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(246, 246, 246, 1.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20, right: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(

                          hintText: 'Pepito Perez',
                          labelText: 'Nombre completo',
                          labelStyle: TextStyle(fontSize: 17.0, color: Color.fromRGBO(246, 246, 246, 1.0),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(246, 246, 246, 1.0), width: 1.2),
                              borderRadius: BorderRadius.circular(25.0)),

                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15, right: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(

                          hintText: 'Pepito Perez',
                          labelText: 'Edad',
                          labelStyle: TextStyle(fontSize: 17.0, color: Color.fromRGBO(246, 246, 246, 1.0),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(246, 246, 246, 1.0), width: 1.2),
                              borderRadius: BorderRadius.circular(25.0)),

                        ),

                      ),
                    ),
                  )
                ])))));
  }

  Widget newappbar() {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
            //borderRadius: BorderRadius.circular(20.0),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 20, top: 37),
                    child: Text('Editar Perfil',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 7, top: 37),
                  child: _volverPerfil(),
                )
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
                      onPressed: () {},
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _volverPerfil() {
    return RaisedButton(
      splashColor: Colors.grey,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromRGBO(0, 51, 51, 1), width: 1.2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),

      child: Text(' Listo  ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 21.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(0, 51, 51, 1),
              fontWeight: FontWeight.bold)),
      //textColor: Colors.white,
      color: Colors.white,

      onPressed: () {},
    );
  }
}
