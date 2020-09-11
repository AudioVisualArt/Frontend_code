import 'package:Clapp/src/Equipment/pages/equipment_buy_page.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';

class EquipmentHorizontal extends StatelessWidget {
  final List<EquipmentModel> equipos;
  final UserModel userModel;
  const EquipmentHorizontal({
    @required this.equipos,
    @required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.9,
    );
    return Container(
      height: _screenSize.height * 0.43,
      width: double.infinity,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, i) => _tarjetaEquipo(context, equipos[i]),
        itemCount: equipos.length,
      ),
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
            _containerInfoUser,
            SizedBox(
              width: 10.0,
            ),
            _containerFoto,
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            SizedBox(
              height: 35.0,
              width: 120.0,
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
                                  userModel: userModel,
                                )));
                  }),
            ),
          ],
        ),
      ],
    );

    return Container(
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color.fromRGBO(227, 227, 227, 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: _containerInfo,
      ),
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
        placeholder: AssetImage('assets/img/jar-loading.gif'),
        image: NetworkImage(equipment.fotoUrl),
        fit: BoxFit.cover,
      );
    }
  }
}
