import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/item/model/item_models.dart';
import 'package:Clapp/src/item/providers/productos_provider.dart';
import 'package:flutter/material.dart';

class MostrarProductosPage extends StatefulWidget {
  final UserModel userModel;
  MostrarProductosPage({this.userModel});
  @override
  _MostrarProductosPageState createState() => _MostrarProductosPageState();
}

class _MostrarProductosPageState extends State<MostrarProductosPage> {
  final productosProvider = new ProductosProvider();
  final equipmentProvider = new EquipmentProvider();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    equipmentProvider.cargarEquipments();

    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Productos',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                _crearListado(_screenSize);
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/mostraritems.jpg"),
              fit: BoxFit.cover,
            )),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Container(

              child: _crearListado(_screenSize),
              padding: EdgeInsets.all(4.0),
              height: _screenSize.height * 0.7,
            ),
            _crearBotonAgregar(),
          ],
        ),
      )
    ));
  }

  Widget _crearListado(Size size) {
    return FutureBuilder(
      future: equipmentProvider.cargarEquipments(),
      builder: (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return ListView.builder(
            itemCount: equipos.length,
            itemBuilder: (context, index) =>
                _crearItem(context, equipos[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, EquipmentModel equipmentModel) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          productosProvider.borrarProducto(equipmentModel.id);
        },
        child: Card(
          child: InkWell(
            onTap: ()=> Navigator.pushNamed(
                context, 'equipment_edit',
                arguments: equipmentModel),
              child: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          '${equipmentModel.titulo} - ${equipmentModel.valor}',
                          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway", color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold)),
                      subtitle: Text(equipmentModel.id,
                          style: TextStyle(fontSize: 10.0, fontFamily: "Raleway", color: Color.fromRGBO(115, 115, 115, 1.0), fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.arrow_forward_ios),
                    ),

                  ],
                ),
              )
          ),


          elevation: 20.0,
         color: Color.fromRGBO(227, 227, 227, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),

        ));
  }

  Widget _crearBotonAgregar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      label: Text('Agregar Item',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
      textColor: Colors.white,
      icon: Icon(
        Icons.add_to_photos,
        color: Colors.white,
      ),
      color: Color.fromRGBO(89, 122, 121, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 42.0),
      onPressed: () {
        Navigator.pushNamed(context, 'menu_item', arguments: widget.userModel);
      },
    );
  }
}
