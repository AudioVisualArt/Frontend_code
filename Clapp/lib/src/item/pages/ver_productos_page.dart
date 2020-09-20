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
        elevation: 10,
        title: Text('Productos',
            style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
        actions: <Widget>[
          _botonAgregar(),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/mostraritems.jpg"),
              fit: BoxFit.cover,
            )),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 30.0,
            child: Column(

              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 15.0),
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
                        IconButton(iconSize: 22,
                          icon: Icon(Icons.autorenew),
                          onPressed: () {
                            setState(() {
                              _crearListado(_screenSize);
                            });
                          },
                        ),
                      ],
                    )),
                //SizedBox(height: 20.0,),
                //SizedBox(height: 9),
                SizedBox(child: Container(


                  child: _crearListado(_screenSize),
                  padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width - 5.0,
                  height: MediaQuery.of(context).size.height - 180.0,
                ),)

              ],
            ),
          ),
          ),

      ),

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


          elevation: 0.0,
         color: Color.fromRGBO(227, 227, 227, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),

        ));
  }

  Widget _botonAgregar(){
    return RaisedButton(
      splashColor: Colors.grey,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.grey, width: 1.2),

        borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0)
        ),),

      child: Text(' Nuevo  ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 21.0,
            fontFamily: "Raleway",
            color: Color.fromRGBO(115, 115, 115, 1.0),
          )),
      //textColor: Colors.white,
      color: Colors.white,

      onPressed: () {
        Navigator.pushNamed(context, 'menu_item', arguments: widget.userModel);
      },
    );

  }


}
