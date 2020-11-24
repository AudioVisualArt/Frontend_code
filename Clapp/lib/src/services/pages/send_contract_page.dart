import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/actividad_model.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/actividad_provider.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/utils/utils.dart' as utils;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart';

class SendContract extends StatefulWidget {
  String tag;
  UserModel usuarioOferta;
  String photoUrl;
  String nombre;
  SendContract(this.tag, this.usuarioOferta,this.photoUrl,this.nombre);
  //final description;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SendContract(this.usuarioOferta, this.tag,this.photoUrl,this.nombre);
  }
}

class _SendContract extends State<SendContract> {
  final contractformkey = GlobalKey<FormState>();
  ProjectModel _selectedProject;

  ContractModel contrato = new ContractModel();
  bool _guardando = false;
  var _selectedValue;
  final contratoProvider = new ContratosProvider();
  final projectProvider = new ProyectosProvider();
  List<Marker> _markers = [];
  String _currentAddress;
  ActividadProvider actividadProvider = new ActividadProvider();
  _SendContract(UserModel usuarioOferta, String tag,String photoUrl,String nombre);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Nuevo contrato',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          ),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 20.0, bottom: 30.0),
                      child: Form(
                        key: contractformkey,
                        child: Column(
                          children: <Widget>[
                            _dropProject(widget.usuarioOferta.id),
                            SizedBox(height: 10),
                            _payment(),
                            SizedBox(height: 10),
                            _jobPosition(),
                            SizedBox(height: 10),
                            _workDays(),
                            //SizedBox(height: 10),
                            //_city(),
                            SizedBox(height: 10),
                            _googleMap(),
                            //_desiredSkills(),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                padding: EdgeInsets.only(right: 10.0, left: 210, bottom: 35.0),
                child: RaisedButton(
                  padding:
                      EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text('Contrato abierto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(115, 115, 115, 1.0),
                          fontWeight: FontWeight.bold)),
                  textColor: Colors.white,
                  color: Color.fromRGBO(112, 252, 118, 0.8),
                  onPressed: (_guardando) ? null : _submit,
                ),
              )
            ],
          ),
        ));
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

  void _submit() {
    if (!contractformkey.currentState.validate()) return;

    contractformkey.currentState.save();
    contrato.userBidderId = widget.usuarioOferta.id;
    contrato.userApplicantId = widget.tag;
    contrato.projectId = _selectedProject.id;
    contrato.acceptedBidder = true;
    contrato.publico=false;
    print('Todo Ok');

    setState(() {
      _guardando = true;
    });

    if (contrato.id == null) {
      contratoProvider.crearContrato(contrato);
    } else {
      contratoProvider.editarContrato(contrato);
    }
    Duration(milliseconds: 1500);
    /*Navigator.pop(context, new MaterialPageRoute(
        builder: (context) =>
        new NewContract())*/

    ActividadModel act = new ActividadModel(
        descripcion: "Has ofrecido un contrato a ${widget.nombre}",
        fecha: DateTime.now().toString(),
        tipo: "Contrato",
        contenido: "${contrato.city},${contrato.jobPosition},${contrato.payment},${contrato.workHours}",
        photoUrl: widget.photoUrl
        );
    ActividadModel act2 = new ActividadModel(
        descripcion: "Has recibido un contrato de ${widget.usuarioOferta.name}",
        fecha: DateTime.now().toString(),
        tipo: "Contrato",
        contenido: "${contrato.city},${contrato.jobPosition},${contrato.payment},${contrato.workHours}",
        photoUrl: widget.usuarioOferta.photoUrl
        );
    actividadProvider.crearActividad(act, widget.usuarioOferta.id);
    actividadProvider.crearActividad(act2, widget.tag);
    Navigator.pop(context);
  }

  Widget _dropProject(String userid) {
    return Container(
      padding: EdgeInsets.only(left: 0.5, right: 59.0),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
            FutureBuilder<List<ProjectModel>>(
              future: projectProvider.cargarProyectos(userid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProjectModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return DropdownButton<ProjectModel>(
                    hint: Text("selecione el proyecto de este contrato"),
                    //value: _selectedProject,
                    onChanged: (ProjectModel project) {
                      setState(
                        () {
                          _selectedProject = project;
                        },
                      );
                    },
                    items: snapshot.data
                        .map((project) => DropdownMenuItem<ProjectModel>(
                              child: new Text(project.proyectName),
                              value: project,
                            ))
                        .toList(),
                  );
                }
              },
            ),
          ])),
    );
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
