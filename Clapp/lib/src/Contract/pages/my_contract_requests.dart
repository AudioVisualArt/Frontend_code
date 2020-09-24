import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:flutter/material.dart';

class MyContractRequest extends StatefulWidget {
  final UserModel user;
  MyContractRequest({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyContractRequest();
  }
}

class _MyContractRequest extends State<MyContractRequest> {
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostraritems.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 30.0,
            padding: EdgeInsets.only(
              right: 1.0,
              left: 1.0,
            ),

            //key: formKey,
            child: Column(
              children: <Widget>[
                newappbar(),
                Expanded(
                    child: Container(
                      child: _crearListado(),
                      //padding: EdgeInsets.all(4.0),
                      width: MediaQuery.of(context).size.width - 0.0,
                      height: MediaQuery.of(context).size.height - 210,
                    )),

                ],
            )),
      ),
    );
  }
  Widget _crearListado() {
    return ListView(
      children: [
        solicitud_Contrato(),
        solicitud_Contrato(),
        solicitud_Contrato()
      ],
    );
  }

  Widget solicitud_Contrato() {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
        child: Container(
          margin: EdgeInsets.only(left: 17, right: 16),
          child: Column(
            children: [
              Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      'Sonidista para el Viejo y el bar',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      color: Color.fromRGBO(89, 122, 121, 1.0)),
                  width: MediaQuery.of(context).size.width - 55,
                  height: 55),
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Color.fromRGBO(237, 237, 237, 1.0)),
                      width: MediaQuery.of(context).size.width - 55,
                      height: 307),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 12.0, right: 10, top: 12),
                        child: Container(
                          decoration: ConcaveDecoration(
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              colors: [
                                Color.fromRGBO(176, 176, 176, 0.8),
                                Color.fromRGBO(199, 199, 199, 1),
                              ],
                              depression: 15),
                          /*decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Color.fromRGBO(246, 246, 246, 1.0)),

                             */
                          child: Column(
                            children: [
                              SizedBox(height: 6,),
                              row_info_contrato("Proyecto:", "El viejo y el bar"),
                              row_info_contrato("Cargo :", "Sonidista"),
                              row_info_contrato("Dias:", "3"),
                              row_info_contrato("Horas:", "24"),
                              row_info_contrato("Locacion:", "Bogota"),
                              row_info_contrato("Pago:", "500.000-600.000"),


                            ],
                          ),
                          width: MediaQuery.of(context).size.width - 80,
                          height: 175,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 10, top: 9),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 90,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text('Ver Proyecto',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold)),
                            textColor: Colors.white70,
                            color: Color.fromRGBO(89, 122, 121, 1.0),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 12.0, right: 4, top: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 260,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text('Ignorar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      //fontWeight: FontWeight.bold
                                    )),
                                textColor: Colors.black87,
                                color: Colors.redAccent,
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 4.0, right: 12, top: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 260,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text('Aplicar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      //fontWeight: FontWeight.bold
                                    )),
                                textColor: Colors.black87,
                                color: Color.fromRGBO(112, 252, 118, 1),
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget row_info_contrato(String name, String info){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: 12,
            ),
            child: Container(
              width:
              MediaQuery.of(context).size.width -
                  310,
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(
                        115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
        Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: 12,
            ),
            child: Container(
              width:
              MediaQuery.of(context).size.width -
                  210,
              child: Text(
                info,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(
                        115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }

  Widget newappbar() {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                Padding(
                  padding: EdgeInsets.only(left: 35.0, right: 16),
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 20, top: 37),
                      child: Text('Contratos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0))),
                    ),
                  ),
                ),
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
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
