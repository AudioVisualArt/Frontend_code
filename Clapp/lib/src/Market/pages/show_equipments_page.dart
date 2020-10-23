import 'package:flutter/material.dart';

import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/pages/equipment_buy_page.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';

class ShowEquipmentPage extends StatefulWidget {
  final List<EquipmentModel> equipos;
  final UserModel userModel;
  ShowEquipmentPage(
      // ignore: type_init_formals
      {List<EquipmentModel> this.equipos,
      // ignore: type_init_formals
      UserModel this.userModel,
      Key key})
      : super(key: key);

  @override
  _ShowEquipmentPageState createState() => _ShowEquipmentPageState();
}

class _ShowEquipmentPageState extends State<ShowEquipmentPage> {
  final equipmentProvider = new EquipmentProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos',
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
              Flexible(flex: 1, child: _crearListadoEquipments()),
            ],
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _crearListadoEquipments() {
    return FutureBuilder(
      future: equipmentProvider.cargarEquipments(),
      builder:
          (BuildContext context, AsyncSnapshot<List<EquipmentModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 25.0,
                );
              },
              itemCount: equipos.length,
              itemBuilder: (context, index) {
                return _cardEquipment(context, equipos[index]);
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

  Widget _cardEquipment(BuildContext context, EquipmentModel equipmentModel) {
    final card = Container(
      child: Column(
        children: [
          Flexible(flex: 6, child: _imagenEquipo(equipmentModel)),
          Flexible(
            flex: 1,
            child: ListTile(
              title: Text(
                equipmentModel.titulo.toString(),
                style: TextStyle(
                    fontSize: 15.0, fontFamily: "Raleway", color: Colors.white),
              ),
              subtitle: Text(
                equipmentModel.itemDescription.toString(),
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
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new EquipmentCompraPage(
                                      equipmentModel: equipmentModel,
                                      userModel: widget.userModel,
                                    )));
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

  Widget _tarjetaEquipo(BuildContext context, EquipmentModel equipmentModel) {
    final imagen = _imagenEquipo(equipmentModel);
    final _containerFoto = Container(
        height: 200.0,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white70,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0), child: imagen));

    final _containerInfoUser = Container(
      height: 200.0,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white70,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Marca: ' + equipmentModel.marca,
                style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Precio: ' + equipmentModel.valor.toString(),
                style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
              )
            ],
          ),
        ),
      ),
    );

    final _containerInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 8.0,
        ),
        Text(
          equipmentModel.titulo,
          style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          equipmentModel.itemDescription ?? " ",
          style: TextStyle(fontSize: 10.0, fontFamily: "Raleway"),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            Flexible(flex: 2, child: _containerInfoUser),
            SizedBox(
              width: 15.0,
            ),
            Flexible(flex: 3, child: _containerFoto),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            SizedBox(
              child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color.fromRGBO(112, 252, 118, 1.0),
                  label: Text(
                    'Ver ',
                    style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
                    textAlign: TextAlign.center,
                  ),
                  autofocus: true,
                  icon: Icon(
                    Icons.description,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new EquipmentCompraPage(
                                  equipmentModel: equipmentModel,
                                  userModel: widget.userModel,
                                )));
                  }),
            ),
          ],
        ),
      ],
    );

    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromRGBO(227, 227, 227, 1.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black45,
                spreadRadius: 2.0,
                blurRadius: 10.0,
                offset: Offset(2.0, 5.0))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: _containerInfo,
        ),
      ),
      elevation: 4.0,
      color: Color.fromRGBO(227, 227, 227, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }

  Widget _imagenEquipo(EquipmentModel equipment) {
    if (equipment.fotoUrl.isEmpty || equipment.fotoUrl == null) {
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/img/loader2.gif'),
        image: NetworkImage(equipment.fotoUrl),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}
