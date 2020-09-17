import 'package:flutter/material.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';

class PerfilPersonal extends StatelessWidget {
  String tag, rol;
  String name, description, ciudad, profesion, photoUrl;

  //final description;
  PerfilPersonal(this.tag,
      this.rol,
      this.name, this.description, this.profesion, this.ciudad, this.photoUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var assetpath = "assets/img/perfiltest.PNG";
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil',
              style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          //backgroundColor: Colors.white70,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/perfil.jpg"),
            fit: BoxFit.cover,
          )),
          child: ListView(
            children: [


              SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Color.fromRGBO(227, 227, 227, 1),),
                      margin: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0
                      ),
                      padding: EdgeInsets.only(
                        left: 7.0,
                        right: 10.0,

                      ),

                      height: 190,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 30.0,


                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7.0),
                            child:
                            Hero(
                              //tag: worker.userId,
                              tag: tag,
                              child: _constructorImagen(),
                            ),),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: EdgeInsets.only(top: 30.0, left: 35.0),
                                child: Text(name,
                                  style: TextStyle(fontSize: 18.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 7.0,),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 35.0
                                ),
                                child: Text(rol,
                                  style: TextStyle(fontSize: 18.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),

                                ),

                              ),
                              SizedBox(height: 20.0,),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 35.0
                                ),
                                child: Text(profesion,
                                  style: TextStyle(fontSize: 18.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),

                                ),

                              ),
                              SizedBox(height: 7.0,),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 35.0
                                ),
                                child: Text(ciudad,
                                  style: TextStyle(fontSize: 18.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),

                                ),

                              ),


                            ],
                          )
                        ],
                      )),
                  SizedBox(height: 20.0),
                  SizedBox(child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromRGBO(227, 227, 227, 1),),
                    height: 85,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 30.0,

                    margin: EdgeInsets.only(
                        left: 15.0,
                        right: 15.0
                    ),
                    padding: EdgeInsets.only(
                      top: 10.0,
                      left: 10.0,
                      right: 10.0,

                    ),
                    child: Text(description,
                      style: TextStyle(fontSize: 17.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(115, 115, 115, 1.0),
                          fontWeight: FontWeight.bold),

                    ),


                  ),
                  ),

                  SizedBox(height: 20.0),
                  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 70.0,
                                    right: 7.0,
                                    left: 7.0),
                                child: RaisedButton(
                                  padding:
                                  EdgeInsets.only(
                                      top: 13, bottom: 13, left: 52, right: 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Text('Estudio',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(
                                              115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold)),
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(227, 227, 227, 1),
                                  onPressed: () {

                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0,
                                    right: 7.0,
                                    left: 7.0),
                                child: RaisedButton(
                                  padding:
                                  EdgeInsets.only(
                                      top: 13, bottom: 13, left: 10, right: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Text('Mandar Contrato',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(
                                              115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold)),
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(227, 227, 227, 1),
                                  onPressed: () {

                                  },
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 70.0,
                                    right: 7.0,
                                    left: 7.0),
                                child: RaisedButton(
                                  padding:
                                  EdgeInsets.only(
                                      top: 13, bottom: 13, left: 40, right: 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Text('Contactar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(
                                              115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold)),
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(227, 227, 227, 1),
                                  onPressed: () {

                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0,
                                    right: 7.0,
                                    left: 7.0),
                                child: RaisedButton(
                                  padding:
                                  EdgeInsets.only(
                                      top: 13, bottom: 13, left: 40, right: 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Text('Compartir',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(
                                              115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold)),
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(227, 227, 227, 1),
                                  onPressed: () {

                                  },
                                ),
                              )
                            ],
                          ),

                        ],
                      )
                  )


                ],
              )
            ],
          ),
        ));
  }

  Widget _constructorImagen() {
    if (photoUrl == null) {
      return Container(
          height: 150.0,
          width: 150.0,
          child: CircleAvatar(
          radius: 100,
          backgroundColor: Color(0xffFDCF09),
    child: CircleAvatar(

    radius: 100,
        child: Image(
        image: AssetImage('assets/img/no-image.png'),
            fit: BoxFit.cover
      ),
    )
          )
    );
    } else {
      if (photoUrl == null) {
        return Container(
            height: 150.0,
            width: 150.0,
            child: CircleAvatar(
            radius: 100,
            backgroundColor: Color(0xffFDCF09),
    child: CircleAvatar(

    radius: 100,
          child: Image(
          image: AssetImage('assets/img/no-image.png'),

          fit: BoxFit.cover,
        )
    )
            )
        );
      } else if (photoUrl != null || photoUrl.isNotEmpty) {
        return Container(
            height: 150.0,
            width: 150.0,
            child: CircleAvatar(
                radius: 100,
                backgroundColor: Color(0xffFDCF09),
                child: CircleAvatar(

                  radius: 100,
                  backgroundImage: NetworkImage(
                    photoUrl,

                  ),


                )
            )
        );
      }
    }
  }
}