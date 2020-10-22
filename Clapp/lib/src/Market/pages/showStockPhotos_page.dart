import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/StockPhoto/pages/stockphoto_buy_page.dart';
import 'package:Clapp/src/StockPhoto/provider/stockphoto_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';

class ShowPhotosPage extends StatefulWidget {
  final UserModel userModel;
  // ignore: type_init_formals
  ShowPhotosPage({UserModel this.userModel});

  @override
  _ShowPhotosPageState createState() => _ShowPhotosPageState();
}

class _ShowPhotosPageState extends State<ShowPhotosPage> {
  final stockPhotoProvider = StockPhotoProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos',
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
              Flexible(flex: 1, child: _crearListadoStockPhotos()),
            ],
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _crearListadoStockPhotos() {
    return FutureBuilder(
      future: stockPhotoProvider.cargarPhotos(),
      builder: (BuildContext context,
          AsyncSnapshot<List<StockPhotoModel>> snapshot) {
        if (snapshot.hasData) {
          final photos = snapshot.data;
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 25.0,
                );
              },
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return _cardEquipment(context, photos[index]);
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

  Widget _cardEquipment(BuildContext context, StockPhotoModel stockPhotoModel) {
    final card = Container(
      child: Column(
        children: [
          Flexible(flex: 6, child: _imagenStock(stockPhotoModel)),
          Flexible(
            flex: 1,
            child: ListTile(
              title: Text(
                stockPhotoModel.titulo.toString(),
                style: TextStyle(
                    fontSize: 15.0, fontFamily: "Raleway", color: Colors.white),
              ),
              subtitle: Text(
                stockPhotoModel.itemDescription.toString(),
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
                                builder: (context) => new StockPhotoComprarPage(
                                      stockPhotoModel: stockPhotoModel,
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

  Widget _imagenStock(StockPhotoModel stockPhotoModel) {
    if (stockPhotoModel.fotoUrl.isEmpty || stockPhotoModel.fotoUrl == null) {
      return Image(
        image: AssetImage('assets/img/no-image.png'),
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/img/loader2.gif'),
        image: NetworkImage(stockPhotoModel.fotoUrl),
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      );
    }
  }
}
