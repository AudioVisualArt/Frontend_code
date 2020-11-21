import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/pages/project_details_outsider.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class MyContractRequest extends StatefulWidget {
  final UserModel user;
  MyContractRequest({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyContractRequest();
  }
}

class _MyContractRequest extends State<MyContractRequest> {
  ContratosProvider contratosProvider = new ContratosProvider();
  ProyectosProvider proyectosProvider = new ProyectosProvider();
  ProjectModel project;
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostraritems.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 30.0,
            padding: EdgeInsets.only(
              right: 1.0,
              left: 1.0,
            ),

            //key: formKey,
            child: Column(
              children: <Widget>[
                newappbar(usuario.id),
                Expanded(
                    child: Container(
                  child: _crearListado(usuario.id),
                  //padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width - 0.0,
                  height: MediaQuery.of(context).size.height - 210,
                )),
              ],
            )),
      ),
    );
  }

  Widget _crearListado(String idUsuario) {
    return FutureBuilder(
      future: contratosProvider.cargarContratosOfrecidos(idUsuario),
      builder:
          (BuildContext context, AsyncSnapshot<List<ContractModel>> snapshot) {
        if (snapshot.hasData) {
          final contratos = snapshot.data;
          return ListView.builder(
            // padding: const EdgeInsets.all(8.0),
            itemCount: contratos.length,
            itemBuilder: (context, index) =>
                solicitud_Contrato(context, contratos[index], idUsuario),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget solicitud_Contrato(
      BuildContext context, ContractModel contrato, String idUduario) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
        child: Container(
          margin: EdgeInsets.only(left: 17, right: 16),
          child: Column(
            children: [
              Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      'Contrato como ${contrato.jobPosition}',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                      color: Color.fromRGBO(89, 122, 121, 1.0)),
                  width: MediaQuery.of(context).size.width - 55,
                  height: 55),
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Color.fromRGBO(237, 237, 237, 1.0)),
                      width: MediaQuery.of(context).size.width - 55,
                      height: 307),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 12.0, right: 10, top: 12),
                        child: Container(
                          child: Center(
                            child: ClayContainer(
                              borderRadius: 10,
                              curveType: CurveType.none,
                              color: Color.fromRGBO(227, 227, 227, 1),
                              depth: 35,
                              spread: 5,
                              /*decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Color.fromRGBO(246, 246, 246, 1.0)),

                             */
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  _crearNombreProjecto(contrato),
                                  row_info_contrato(
                                      "Cargo :", contrato.jobPosition,44),
                                  row_info_contrato(
                                      "Horas:", contrato.workHours.toString(),22),
                                  _crearCiudad(contrato),
                                  row_info_contrato(
                                      "Pago:", contrato.payment.toString(),22),
                                ],
                              ),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 80,
                          height: 175,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 10, top: 9),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 90,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Text('Ver Proyecto',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold)),
                            textColor: Colors.white70,
                            color: Color.fromRGBO(89, 122, 121, 1.0),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=> ProjectDetailsOutsider(project)));
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 12.0, right: 4, top: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 260,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text('Ignorar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      //fontWeight: FontWeight.bold
                                    )),
                                textColor: Colors.black87,
                                color: Colors.redAccent,
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                onPressed: () {
                                  _borrarContrato(contrato);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 4.0, right: 12, top: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 260,
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text('Aplicar',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      //fontWeight: FontWeight.bold
                                    )),
                                textColor: Colors.black87,
                                color: Color.fromRGBO(112, 252, 118, 1),
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                onPressed: () {
                                  _confirmarContrato(contrato, idUduario);
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget row_info_contrato(String name, String info, double mxh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: 12,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 300,
              height: 22,
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
        Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: 12,
                right: 5
            ),
            child: Container(
              constraints: BoxConstraints(maxHeight: mxh,
                maxWidth: MediaQuery.of(context).size.width - 220,),

              child: Text(
                info,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }

  Widget newappbar(String idUsuario) {
    return Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(252, 252, 252, 1),
                  Color.fromRGBO(252, 252, 252, 1),
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 7.0, right: 20, top: 37),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.0, right: 16, top: 37),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Text('Contratos',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0))),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 1.0),
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
                    IconButton(
                      iconSize: 22,
                      icon: Icon(Icons.autorenew),
                      onPressed: () {
                        setState(() {
                          _crearListado(idUsuario);
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }

  Future<Address> _getAddress(LatLng myLocation) async {
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');

    return first;
  }

  Widget _crearCiudad(ContractModel contrato) {
    LatLng lt = new LatLng(contrato.latitud, contrato.longitud);
    return FutureBuilder(
      future: _getAddress(lt),
      builder: (BuildContext context, AsyncSnapshot<Address> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return row_info_contrato("Locacion:", snapshot.data.locality, 22);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _crearNombreProjecto(ContractModel contrato) {
    return FutureBuilder(
      future: proyectosProvider.cargarProyecto(contrato.projectId),
      builder: (BuildContext context, AsyncSnapshot<ProjectModel> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          project = snapshot.data;
          return row_info_contrato("Proyecto:", snapshot.data.proyectName, 44);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _confirmarContrato(ContractModel contrato, String idUsuario) {
    contrato.acceptedApplicant = true;
    contratosProvider.editarContrato(contrato);
    _crearListado(idUsuario);
  }

  void _borrarContrato(ContractModel contrato) {
    contratosProvider.borrarContrato(contrato.id);
  }
}
