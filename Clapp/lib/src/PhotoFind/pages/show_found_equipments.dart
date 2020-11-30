import 'dart:io';

import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/pages/equipment_buy_page.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tflite/tflite.dart';

class ShowFoundImagePage extends StatefulWidget {
  final UserModel userModel;
  final String etiqueta;
  final File file;

  ShowFoundImagePage(
      {UserModel this.userModel, String this.etiqueta, File this.file, Key key})
      : super(key: key);

  @override
  _ShowFoundImagePageState createState() => _ShowFoundImagePageState();
}

class _ShowFoundImagePageState extends State<ShowFoundImagePage> {
  final equipmentProvider = new EquipmentProvider();
  List _salida;
  String marcaEquipment;

  @override
  void initState() {
    _cargarModeloEquipment();
    _clasificarEquipment(widget.file);
    MostrarDialog(context, 'Encontramos...',
        'Hemos Encontrado la marca ${widget.etiqueta}');
    print('Marca:' + marcaEquipment.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Equipos',
          //   style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          ),
      body: Container(
        /*decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostrarItems2.jpeg"),
          fit: BoxFit.cover,
        )),

         */
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Container(
          //padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: _crearListadoEquipments(widget.file),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _crearListadoEquipments(File image) {
    return FutureBuilder(
      future: equipmentProvider.cargarEquipmentsNotSessionUserByTag(
          widget.userModel.id,
          widget.etiqueta,
          marcaEquipment?.substring(marcaEquipment?.lastIndexOf(" ")).trim() ??
              'NOTHING'),
      builder:
          (BuildContext context, AsyncSnapshot<List<EquipmentModel>> snapshot) {
        if (snapshot.hasData) {
          final equipos = snapshot.data;
          return SingleChildScrollView(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 30, bottom: 12),
                child: Text('Equipos',
                    style: TextStyle(
                        fontSize: 31.0,
                        fontFamily: "Raleway",
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Text(equipos.length.toString() + " resultados",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Raleway",
                      color: Colors.black,
                      //fontWeight: FontWeight.bold
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14.0,
                      mainAxisSpacing: 6.0,
                      childAspectRatio: 0.66),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: equipos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: _cardEquipment(context, equipos[index]),
                    );
                  }),
              SizedBox(
                height: 25,
              )
            ],
          ));
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

  String currency() {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return format.currencySymbol.toString() + ' ';
  }

  Widget _cardEquipment(BuildContext context, EquipmentModel equipmentModel) {
    final card = Container(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Hero(
                  tag: equipmentModel.id,
                  child: _imagenEquipo(equipmentModel))),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 15),
                child: Text(
                  equipmentModel.titulo.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Raleway",
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 15),
                child: Text(
                  currency() + equipmentModel.valor.toString(),
                  textAlign: TextAlign.center,
                  //equipmentModel.titulo.toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Raleway",
                    color: Colors.black,
                    //fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),

          /* Flexible(
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

          */
        ],
      ),
    );

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new EquipmentCompraPage(
                        equipmentModel: equipmentModel,
                        userModel: widget.userModel,
                      )));
        },
        child: Container(
          height: 400,
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(112, 252, 118, 1),
                Color.fromRGBO(89, 122, 121, 1),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 8),
                blurRadius: 25,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: card,
          ),
        ));
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
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: AssetImage('assets/img/no-image.png'),
            height: double.infinity,
            fit: BoxFit.cover,
          ));
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/img/loader3.gif'),
            image: NetworkImage(equipment.fotoUrl),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ));
    }
  }

  _cargarModeloEquipment() async {
    await Tflite.loadModel(
      model: 'assets/model_img/model_unquant_marca.tflite',
      labels: 'assets/model_img/labelsMarca.txt',
    );
  }

  _clasificarEquipment(File image) async {
    double confianza;
    if (image != null) {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 3,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      setState(() {
        _salida = output;
        confianza = _salida[0]["confidence"] * 100;
        marcaEquipment = _salida[0]["label"];
        print(
            '${marcaEquipment.substring(marcaEquipment.lastIndexOf(" ")).trim()} & $confianza');
      });
    }
  }
}
