import 'package:flutter/material.dart';

class InicioClapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(112, 252, 118, 1),
              Color.fromRGBO(112, 252, 118, 1),

              Color.fromRGBO(59, 138, 63, 1),
              // Color.fromRGBO(89, 122, 121, 1),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Clapp",
                style: TextStyle(
                    fontSize: 41,
                    fontFamily: "Raleway",
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(left: 43.0, right: 43, top: 18),
              child: Text.rich(
                TextSpan(
                  text:
                      'Al iniciar sesión o crear una nueva cuenta, aceptas nuestros ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Raleway",
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Términos',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),

                    TextSpan(
                        text: '. Conoce nuestra ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        )),
                    TextSpan(
                        text: 'Política de privacidad',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    TextSpan(
                        text: ' y ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        )),
                    TextSpan(
                        text: 'Política de cookies',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Raleway",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    // can add more TextSpans here...
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text("Crear una nueva cuenta",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Raleway",
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, bottom: 18),
              child: SizedBox(
                height: 42,
                child: OutlineButton(
                    child: Center(
                      child: Text(
                        "INICIA SESIÓN",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Raleway",
                            //color: Color.fromRGBO(112, 252, 118, 0.8),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {},
                    //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                    highlightedBorderColor: Color.fromRGBO(112, 252, 118, 0.8),
                    borderSide: BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
              ),
            ),
            _loginGmail(context),
          ],
        ),
      ),
    );
  }

  Widget _loginGmail(context) {
    return SizedBox(
        width: 300,
        child: RaisedButton(
          child: Row(
            children: [
              Container(
                child: Image(
                  image: AssetImage(
                    'assets/img/google.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
                height: 36,
                width: 36,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
                child: Center(
                  child: Text(
                    "Ingresa con Gmail",
                    style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: "Raleway",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Color.fromRGBO(65, 133, 244, 1.0),
          onPressed: () {
            //onGoogleSignIn(context);
          },
        ));
  }
}
