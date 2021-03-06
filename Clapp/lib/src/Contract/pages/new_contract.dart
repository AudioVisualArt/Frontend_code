import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart' as mostrar_dialog;
import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class NewContract extends StatefulWidget {
  final UserModel user;
  NewContract({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewContract();
  }
}

class _NewContract extends State<NewContract> {
  final contractformkey = GlobalKey<FormState>();
  List<Marker> _markers = [];

  ContractModel contrato = new ContractModel();
  bool _guardando = false;
  var _selectedValue;

  final contratoProvider = new ContratosProvider();
  @override
  Widget build(BuildContext context) {
    ProjectModel project = ModalRoute.of(context).settings.arguments;
    print("id de proyecto en new contract: ${project.id}");

    contrato.projectId = project.id;
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Nuevo Contrato',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Raleway",
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                    )),
                //background:
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('Complete los datos',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 17.5, fontFamily: "Raleway"))),
                Container(
                  padding: EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                  child: Form(
                    key: contractformkey,
                    child: Column(
                      children: <Widget>[
                        //_city(),
                        SizedBox(height: 10),
                        _jobPosition(),
                        SizedBox(height: 10),
                        _workDays(),
                        SizedBox(height: 10),
                        _payment(),
                        SizedBox(height: 10),
                        Container(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Text('Ubicación (opcional)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Raleway"))),
                        _googleMap(),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding:
                          EdgeInsets.only(right: 10.0, left: 210, bottom: 30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 13, bottom: 13, left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('Abrir Contrato',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                        textColor: Colors.white,
                        color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                          (_guardando) ? null : _submit(context, project);
                        },
                      ),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _city() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          initialValue: contrato.city,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 15,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Ciudad',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "Ejemplo: Bogotá",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => contrato.city = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre de la ciudad correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _jobPosition() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          initialValue: contrato.jobPosition,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 50,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Posicion de trabajo',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "Ejemplo: DP",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => contrato.jobPosition = value,
          validator: (value) {
            if (value.length < 3) {
              return 'Ingrese el nombre correctamente';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget _workDays() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          // initialValue: contrato.workHours.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 3,
          maxLines: 1,
          textAlign: TextAlign.left,

          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Horas de trabajo',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            helperText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => contrato.workHours = int.parse(value),
          validator: (value) {
            if (utils.isNumeric(value)) {
              return null;
            } else {
              return 'Solo numeros';
            }
          },
        ),
      ),
    );
  }

  Widget _payment() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: TextFormField(
          //initialValue: contrato.payment.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          cursorColor: Color.fromRGBO(0, 51, 51, 0.8),
          maxLength: 10,
          maxLines: 1,
          textAlign: TextAlign.left,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: 'Pago',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            // helperText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) => contrato.payment = double.parse(value),
          validator: (value) {
            if (utils.isNumeric(value)) {
              return null;
            } else {
              return 'Solo numeros';
            }
          },
        ),
      ),
    );
  }

  Widget _desiredSkills() {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
        child: DropdownButtonFormField(
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: "Raleway",
              color: Colors.grey,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: 'Hablidades requeridas',
            labelStyle: TextStyle(
                //color: Color.fromRGBO(0, 51, 51, 0.8),
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            // helperText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromRGBO(0, 51, 51, 0.8), width: 0.7),
                borderRadius: BorderRadius.circular(16.0)),
          ),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
          validator: (value) {
            if (utils.isNumeric(value)) {
              return null;
            } else {
              return 'Solo numeros';
            }
          },
          items: [],
        ),
      ),
    );
  }

  void _submit(BuildContext context, ProjectModel project) {
    if (!contractformkey.currentState.validate()) return;
    contrato.userBidderId = project.ownerId;
    contractformkey.currentState.save();
    contrato.acceptedBidder = true;
    contrato.publico=true;
    print('Todo Ok');
    setState(() {
      _guardando = true;
    });
    if (contrato.id == null) {
      Navigator.pop(context);

      mostrar_dialog.MostrarDialog(context, 'Tu contrato ha sido creado!',
          'Otros Clappers podrán ver tu contrato y contactarte.');
      contratoProvider.crearContrato(contrato);
    }
    //else {
    //contratoProvider.editarContrato(contrato);
    //}

    // setState(() {
    //   _guardando = false;
    // });

    //Duration(milliseconds: 1500);
    //Navigator.pop(context,
    //  new MaterialPageRoute(builder: (context) => new NewContract()));
    //Navigator.pushReplacementNamed(context, 'contrato');
  }

  Widget _googleMap() {
    return SizedBox(
        height: 300,
        width: 400,
        child: FutureBuilder<Position>(
            future: getLocation(),
            builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Color.fromRGBO(0, 51, 51, 1.0),
                        ),
                        strokeWidth: 5.0));
              } else {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            snapshot.data.latitude, snapshot.data.longitude),
                        zoom: 16,
                      ),
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                      onTap: _handleTap,
                      markers: Set.from(_markers),
                    ));
              }
            }));
  }

  Future<Position> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  _handleTap(LatLng point) {
    setState(() {
      _markers = [];
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
      ));
      contrato.longitud = point.longitude;
      contrato.latitud = point.latitude;
    });
    _getAddress(_markers.first.position);
  }

  Future<Address> _getAddress(LatLng myLocation) async {
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    contrato.city = first.locality;
    return first;
  }
}
