import 'package:Clapp/src/Props/Model/prop_model.dart';
import 'package:Clapp/src/Props/Provider/prop_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';

class MostrarPropPage extends StatefulWidget {
  UserModel userModel;
  MostrarPropPage({this.userModel});

  @override
  _MostrarPropPageState createState() => _MostrarPropPageState();
}

class _MostrarPropPageState extends State<MostrarPropPage> {
  final propProvider = new PropProvider();

  @override
  Widget build(BuildContext context) {
    propProvider.cargarPropsUser(widget.userModel.id);

    return Container(
        child: Scaffold(
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
          child: Column(
            children: <Widget>[
              newappbar(),
              Expanded(
                child: Container(
                  child: _crearListado(),
                  width: MediaQuery.of(context).size.width - 10.0,
                  height: MediaQuery.of(context).size.height - 210,
                ),
              )
            ],
          ),
        ),
      ),
    ));
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
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
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 20, top: 37),
                    child: Text('Tus Props',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 7, top: 37),
                  child: _botonAgregar(),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Actualizar',
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
                        setState(() {
                          _crearListado();
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: propProvider.cargarPropsUser(widget.userModel.id),
      builder: (BuildContext context, AsyncSnapshot<List<PropModel>> snapshot) {
        if (snapshot.hasData) {
          final props = snapshot.data;
          return ListView.builder(
            itemCount: props.length,
            itemBuilder: (context, index) => _crearProp(context, props[index]),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(0, 51, 51, 1.0),
          )));
        }
      },
    );
  }

  Widget _crearProp(BuildContext context, PropModel propModel) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
            child: Text('Eliminar'),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20.0),
            )),
        onDismissed: (direction) {
          propProvider.borrarProp(propModel);
        },
        child: Card(
          child: InkWell(
              onTap: () => Navigator.pushNamed(context, 'prop_edit',
                  arguments: propModel),
              child: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('${propModel.titulo} - ${propModel.valor}',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(propModel.itemDescription,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0),
                              fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              )),
          elevation: 0.0,
          color: Color.fromRGBO(227, 227, 227, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ));
  }

  Widget _botonAgregar() {
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

      child: Text(' Nuevo  ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 21.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(0, 51, 51, 1),
              fontWeight: FontWeight.bold)),
      //textColor: Colors.white,
      color: Colors.white,

      onPressed: () {
        Navigator.pushNamed(context, 'props', arguments: widget.userModel);
      },
    );
  }
}
