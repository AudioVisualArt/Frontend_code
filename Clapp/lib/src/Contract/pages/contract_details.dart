import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/pages/project_details_outsider.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart' as mostrar_dialog;
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class ContractDetails extends StatefulWidget {
  final ContractModel contrato;
   final UserModel user;


  const ContractDetails({Key key, this.contrato, this.user}) : super(key: key);
  //UserModel usuario;


  //ContractDetails(this.contrato, this.usuario, {Key key, this.user})
    //  : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContractDetails();
  }
}

class _ContractDetails extends State<ContractDetails> {

  UserModel usuario = new UserModel();
  ProyectosProvider proyectosProvider = new ProyectosProvider();
  ContratosProvider contratosProvider = new ContratosProvider();

  ProjectModel project;
  @override
  Widget build(BuildContext context) {
    widget.contrato.useraplicando =new List<UserModel>();
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 160, bottom: 15),
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
                          decoration: TextDecoration.none,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  _crearNombreProjecto(widget.contrato),
                                  row_info_contrato(
                                      "Cargo :", widget.contrato.jobPosition, 44),
                                  row_info_contrato("Horas:",
                                      widget.contrato.workHours.toString(), 22),
                                  _crearCiudad(widget.contrato),
                                  row_info_contrato("Pago:",
                                      widget.contrato.payment.toString(), 22),
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
                                    decoration: TextDecoration.none,
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
                                      decoration: TextDecoration.none,
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      //fontWeight: FontWeight.bold
                                    )),
                                textColor: Colors.black87,
                                color: Color.fromRGBO(112, 252, 118, 1),
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                onPressed: () {
                                  _aplicar(widget.user, widget.contrato);


                                  //_confirmarContrato(
                                    //  widget.contrato, widget.usuario.id);
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
  void _aplicar(UserModel usuario, ContractModel contrato)async{

    await contratosProvider.crearUsuarioAplicando(usuario, contrato.id);

    //widget.contrato.useraplicando.add(widget.user);
    //print(widget.contrato.useraplicando);
    Navigator.pop(context);
    mostrar_dialog.MostrarDialog(context, contrato.jobPosition,
        'Tu solicitud ha sido enviada al líder del proyecto, en caso de ser escogido para el puesto serás notificado!');
   // await contratosProvider.editarContrato(widget.contrato);


  }

  void _confirmarContrato(ContractModel contrato, String idUsuario) {
    contrato.userApplicantId = idUsuario;
    contrato.acceptedApplicant = true;
    contratosProvider.editarContrato(contrato);
    Navigator.pop(context);
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
                    decoration: TextDecoration.none,
                    fontSize: 18.0,
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

              //width: MediaQuery.of(context).size.width - 170,
              child: Text(
                info,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 16.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}
