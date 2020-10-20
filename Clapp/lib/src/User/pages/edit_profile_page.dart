import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditProfile();
  }
}

class _EditProfile extends State<EditProfile> {
  final picker = ImagePicker();
  final editkey = GlobalKey<FormState>();
  File foto;
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
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
                  Expanded(child: SingleChildScrollView(
                    child: Form(
                      key: editkey,
                        child: Column(
                          children: [
                        Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          child: _cambiarimagen(),)),
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
                                      onPressed: () {_seleccionarFoto();},
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
                            _nombre(usuario),
                            _description(usuario),
                            _ciudad(usuario),


                          ],
                        )
                    )

                  ))


                ])))));
  }
  _seleccionarFoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //limpiar
    setState(() {
      foto = File(pickedFile.path);
    });
  }

  Widget _cambiarimagen(){
  if(foto != null){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Image.file(
        File(foto.path),
        fit: BoxFit.cover,
        width: 100.0,
        height: 100.0,
      ),
    );

  }else if (foto == null){
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Image(
        image: AssetImage('assets/img/no-image.png'),
        fit: BoxFit.cover,
        width: 100.0,
        height: 100.0,
      ),
    );
  }

  }
  Widget _nombre(UserModel usuario) {
    return Container(
        padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 30),
        child: Center(
            child: TextFormField(
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Raleway",
                  color: Color.fromRGBO(246, 246, 246, 1.0),
                  fontWeight: FontWeight.bold),
              cursorColor: Color.fromRGBO(246, 246, 246, 1.0),
              maxLength: 29,
              initialValue: usuario.name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(
                   color: Color.fromRGBO(246, 246, 246, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(246, 246, 246, 1.0), width: 0.7),
                      borderRadius: BorderRadius.circular(16.0))),
             // onChanged: (value) => espacio.name = value,
              validator: (value) {
                if (value.length < 3) {
                  return 'Ingrese minimo 5 palabras';
                } else {
                  return null;
                }
              },
            )));
  }
  Widget _ciudad(UserModel usuario) {
    return Container(
        padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 6),
        child: Center(
            child: TextFormField(
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Raleway",
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              cursorColor: Color.fromRGBO(246, 246, 246, 1.0),
              maxLength: 29,
              initialValue: usuario.cityResidence,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  labelText: 'Ciudad',
                  labelStyle: TextStyle(
                    color:Color.fromRGBO(246, 246, 246, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(246, 246, 246, 1.0), width: 0.7),
                      borderRadius: BorderRadius.circular(16.0))),
              //onChanged: (value) => espacio.name = value,
              validator: (value) {
                if (value.length < 3) {
                  return 'Ingrese minimo 5 palabras';
                } else {
                  return null;
                }
              },
            )));
  }
  Widget _description(UserModel usuario) {
    return
       Padding(
         padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 6),
         child: Center(
              child: TextFormField(
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Raleway",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                cursorColor: Color.fromRGBO(246, 246, 246, 1.0),
                maxLength: 125,
                maxLines: 2,
                initialValue: usuario.description,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(246, 246, 246, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),

                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(246, 246, 246, 1.0), width: 0.7),
                        borderRadius: BorderRadius.circular(16.0))),
               // onChanged: (value) => espacio.description = value,
                validator: (value) {
                  if (value.length < 3) {
                    return 'Ingrese minimo 10 palabras';
                  } else {
                    return null;
                  }
                },
              )),
       );
  }

  Widget newappbar() {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
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
