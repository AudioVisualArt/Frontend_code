import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void MostrarDialog(BuildContext context, String mensaje, String description) {
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
