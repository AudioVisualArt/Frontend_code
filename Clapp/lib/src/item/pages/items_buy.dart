import 'package:flutter/material.dart';

import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/item/widgets/EquipmentsHorizontal.dart';

class ItemsComprarPage extends StatelessWidget {
  EquipmentProvider equipmentProvider = new EquipmentProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Items Compra',
          style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _footerEquipment(context),
          ],
        ),
      ),
    );
  }

  Widget _footerEquipment(BuildContext context) {
    UserModel user = ModalRoute.of(context).settings.arguments;
    return Center(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Equipos',
                style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
                future: equipmentProvider.cargarEquipments(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return EquipmentHorizontal(
                        equipos: snapshot.data, userModel: user);
                  } else {
                    return Container(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
