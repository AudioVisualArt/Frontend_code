


import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class ContractDetails extends StatefulWidget {
  final UserModel user;
  ContractModel contrato;
  UserModel usuario;

  ContractDetails(this.contrato, this.usuario, {Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContractDetails();
  }
}

  class _ContractDetails extends State<ContractDetails> {
    ProyectosProvider proyectosProvider = new ProyectosProvider();
    ContratosProvider contratosProvider = new ContratosProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      'Contrato como ${widget.contrato.jobPosition}',
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
                          decoration: ConcaveDecoration(
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              colors: [
                                Color.fromRGBO(176, 176, 176, 0.8),
                                Color.fromRGBO(199, 199, 199, 1),
                              ],
                              depression: 15),
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
                              SizedBox(height: 6,),
                              _crearNombreProjecto(widget.contrato),
                              row_info_contrato("Cargo :", widget.contrato.jobPosition),
                              row_info_contrato("Horas:", widget.contrato.workHours.toString()),
                              _crearCiudad(widget.contrato),
                              row_info_contrato("Pago:", widget.contrato.payment.toString()),


                            ],
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
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                  _confirmarContrato(widget.contrato,widget.usuario.id);
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
    void _confirmarContrato(ContractModel contrato,String idUsuario) {

      contrato.userApplicantId=idUsuario;
      contrato.acceptedApplicant= true;
      contratosProvider.editarContrato(contrato);
      Navigator.pop(context);

    }
  _crearNombreProjecto(ContractModel contrato) {

    return FutureBuilder(
      future: proyectosProvider.cargarProyecto(contrato.projectId),
      builder:
          (BuildContext context, AsyncSnapshot<ProjectModel> snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return row_info_contrato("Proyecto:", snapshot.data.proyectName);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  Future<Address> _getAddress(LatLng myLocation) async {
    final coordinates = new Coordinates(
        myLocation.latitude, myLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first
        .subAdminArea},${first.addressLine}, ${first.featureName},${first
        .thoroughfare}, ${first.subThoroughfare}');

    return first;
  }

  Widget _crearCiudad(ContractModel contrato) {
    LatLng lt = new LatLng(contrato.latitud, contrato.longitud);
    return FutureBuilder(
      future: _getAddress(lt),
      builder:
          (BuildContext context, AsyncSnapshot<Address> snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return row_info_contrato("Locacion:", snapshot.data.locality);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }
  Widget row_info_contrato(String name, String info){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: 12,
            ),
            child: Container(
              width:
              MediaQuery.of(context).size.width -
                  310,
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(
                        115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
        Padding(
            padding: EdgeInsets.only(
              top: 4,
              left: 12,
            ),
            child: Container(
              width:
              MediaQuery.of(context).size.width -
                  210,
              child: Text(
                info,
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(
                        115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}