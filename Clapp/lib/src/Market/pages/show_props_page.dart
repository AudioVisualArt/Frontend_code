import 'package:Clapp/src/Props/Model/prop_model.dart';
import 'package:Clapp/src/Props/Provider/prop_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';

class ShowPropPage extends StatefulWidget {
  final UserModel userModel;
  ShowPropPage({Key key, this.userModel}) : super(key: key);

  @override
  _ShowPropPageState createState() => _ShowPropPageState();
}

class _ShowPropPageState extends State<ShowPropPage> {
  final propProvider = new PropProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Props',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostrarItems2.jpeg"),
          fit: BoxFit.cover,
        )),
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Flexible(flex: 1, child: _crearListadoProps()),
            ],
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _crearListadoProps() {
    return FutureBuilder(
      future: propProvider.cargarProps(),
      builder: (BuildContext context, AsyncSnapshot<List<PropModel>> snapshot) {
        if (snapshot.hasData) {
          final props = snapshot.data;
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 25.0,
                );
              },
              itemCount: props.length,
              itemBuilder: (context, index) {
                return _cardProp(context, props[index]);
              });
        } else {
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(0, 51, 51, 1.0),
            )),
          );
        }
      },
    );
  }

  Widget _cardProp(BuildContext context, PropModel propModel) {
    final card = Container(
      child: Column(
        children: [
          Flexible(flex: 6, child: _imagenProp(propModel)),
          Flexible(
            flex: 1,
            child: ListTile(
              title: Text(
                propModel.titulo.toString(),
                style: TextStyle(
                    fontSize: 15.0, fontFamily: "Raleway", color: Colors.white),
              ),
              subtitle: Text(
                propModel.itemDescription.toString(),
                style: TextStyle(
                    fontSize: 15.0, fontFamily: "Raleway", color: Colors.white),
              ),
              leading: Icon(Icons.menu_sharp, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Color.fromRGBO(112, 252, 118, 1.0),
                      label: Text(
                        'Más...',
                        style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
                        textAlign: TextAlign.center,
                      ),
                      autofocus: true,
                      icon: Icon(
                        Icons.description,
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) => new EquipmentCompraPage(
                        //               equipmentModel: equipmentModel,
                        //               userModel: widget.userModel,
                        //             )));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Container(
      height: 400,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color.fromRGBO(89, 122, 121, 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black45,
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: Offset(2.0, 5.0))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }

  Widget _imagenProp(PropModel propModel) {
    if (propModel.fotoUrl.isEmpty || propModel.fotoUrl == null) {
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/img/loader2.gif'),
        image: NetworkImage(propModel.fotoUrl),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}
