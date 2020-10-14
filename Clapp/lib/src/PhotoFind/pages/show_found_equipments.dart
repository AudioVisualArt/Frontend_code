import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/pages/equipment_buy_page.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';

class ShowFoundImagePage extends StatefulWidget {
  final List<EquipmentModel> equipos;
  final UserModel userModel;
  final String etiqueta;
  ShowFoundImagePage(
      {List<EquipmentModel> this.equipos,
      UserModel this.userModel,
      String this.etiqueta,
      Key key})
      : super(key: key);

  @override
  _ShowFoundImagePageState createState() => _ShowFoundImagePageState();
}

class _ShowFoundImagePageState extends State<ShowFoundImagePage> {
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
          image: AssetImage("assets/img/mostraritems2.jpg"),
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
      future: equipmentProvider.cargarEquipmentsNotSessionUserByTag(
          widget.userModel.id, widget.etiqueta),
      builder:
          (BuildContext context, AsyncSnapshot<List<EquipmentModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return ListView.builder(
              itemCount: equipos.length,
              itemBuilder: (context, index) {
                return _tarjetaEquipo(context, equipos[index]);
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

  Widget _tarjetaEquipo(BuildContext context, EquipmentModel equipmentModel) {
    final imagen = _imagenEquipo(equipmentModel);
    final _containerFoto = Container(
        height: 200.0,
        width: 165,
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
            Flexible(flex: 3, child: _containerInfoUser),
            SizedBox(
              width: 15.0,
            ),
            Flexible(flex: 4, child: _containerFoto),
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
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/img/loader2.gif'),
        image: NetworkImage(equipment.fotoUrl),
        fit: BoxFit.cover,
      );
    }
  }
}
