import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/User/models/user_model.dart';

class StockPhotoHorizontal extends StatelessWidget {
  final List<StockPhotoModel> stockphotos;
  final UserModel userModel;
  const StockPhotoHorizontal(
      {@required this.stockphotos, @required this.userModel});

  @override
  Widget build(BuildContext context) {
    UsuarioProvider usuarioProvider = new UsuarioProvider();
    final _screenSize = MediaQuery.of(context).size;
    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.9,
    );
    return Container(
      height: _screenSize.height * 0.45,
      width: double.infinity,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemBuilder: (context, i) => _tarjetaPhoto(context, stockphotos[i]),
        itemCount: stockphotos.length,
      ),
    );
  }

  Widget _tarjetaPhoto(BuildContext context, StockPhotoModel stockPhotoModel) {
    final imagen = _imagenEquipo(stockPhotoModel);
    final _containerFoto = Container(
        height: 150.0,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white70,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0), child: imagen));
    final _containerInfoUser = Container(
      height: 50.0,
      width: 150,
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
                'Tipo de Foto:  ' + stockPhotoModel.photoType,
                style: TextStyle(fontSize: 15.0, fontFamily: "Raleway"),
              ),
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
          stockPhotoModel.titulo,
          style: TextStyle(fontSize: 25.0, fontFamily: "Raleway"),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          stockPhotoModel.itemDescription ?? " ",
          style: TextStyle(fontSize: 10.0, fontFamily: "Raleway"),
        ),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            _containerFoto,
            SizedBox(
              height: 20.0,
            ),
            _containerInfoUser,
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => new EquipmentCompraPage(
                    //               equipmentModel: equipmentModel,
                    //               userModel: userModel,
                    //             )));
                  }),
            ),
          ],
        ),
      ],
    );
    final container = Container(
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

    return container;
  }

  Widget _imagenEquipo(StockPhotoModel stockPhotoModel) {
    if (stockPhotoModel.fotoUrl.isEmpty || stockPhotoModel.fotoUrl == null) {
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/img/jar-loading.gif'),
        image: NetworkImage(stockPhotoModel.fotoUrl),
        fit: BoxFit.cover,
      );
    }
  }
}
