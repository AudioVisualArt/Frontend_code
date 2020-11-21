import 'package:Clapp/src/Contract/model/contract_models.dart';
import 'package:Clapp/src/Contract/providers/contratos_providers.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/Space/pages/mostrar_dialog.dart' as mostrar_dialog;

class Applicants extends StatefulWidget {
  final ContractModel contrato;
  final UserModel usuario;

  const Applicants({Key key, this.contrato, this.usuario}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Applicants();
  }
}

class _Applicants extends State<Applicants> {
  ContratosProvider contratosProvider = new ContratosProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _crearListadoSolicitantes(widget.contrato),
      ),
    );
  }

  Widget _crearListadoSolicitantes(ContractModel contrato) {
    return FutureBuilder(
      future: contratosProvider.cargarUsuariosAplicando(contrato.id),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          final solicitantes = snapshot.data;
          return SingleChildScrollView(
              child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17.0, left: 30, bottom: 12, right: 15),
                child: Text(haysolicitantes(solicitantes, contrato),
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
                child: Text(solicitantes.length.toString() + " usuarios han aplicado",
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  itemCount: solicitantes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 15),
                      child: _cardSolicitante(context, solicitantes[index]),
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
  String haysolicitantes(List<UserModel> solicitantes, ContractModel contrato){
    if(solicitantes.length == 0){
      return 'Aun no tienes solicitudes para este contrato';
    }else
      return 'Contrato como ' + contrato.jobPosition;
  }

  Widget _cardSolicitante(BuildContext context, UserModel usuario) {
    final card = Container(
      child: Column(
        children: [
          Flexible(flex: 8, child:
          Stack(
            children: [
              _imagenUser(usuario),
             Positioned(
               bottom: 20,
               left: 10,
               child: Container(
                 constraints: BoxConstraints(
                   maxHeight: 22
                 ),
                 child: Text(
                  usuario.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Raleway",
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
              ),
               ),),
              Positioned(
                bottom: 5,
                left: 10,
                child: Text(
                  usuario.age.toString()+' años',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: "Raleway",
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),),
            ],
          )

              ),
          Padding(
            padding:
            EdgeInsets.only(bottom: 0.5, left: 2.0, right: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: Padding(
                    padding: EdgeInsets.only(right: 0.2, bottom: 2),
                    child: SizedBox(
                      height: 37,
                      width: 85,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(5),
                            )),
                        child: Center(
                          child: Text('Aceptar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "Raleway",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                        textColor: Colors.white,
                      color: Color.fromRGBO(112, 252, 118, 0.8),
                        onPressed: () {
                          _confirmarContrato(widget.contrato, usuario);},
                      ),
                    ))),

                Flexible(child: Padding(
                    padding: EdgeInsets.only(right: 0.2, bottom: 2),
                    child: SizedBox(
                      height: 37,
                      width: 85,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(20),
                            )),
                        child: Center(
                          child: Text('Negar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "Raleway",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        onPressed: () {},
                      ),
                    )))
              ],
            ),
          )

         /* Flexible(
            flex:2,
            fit: FlexFit.tight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround ,
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.highlight_remove_rounded,
                        size: 40,
                        color: Colors.redAccent,
                      ),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.check_circle_rounded,
                        size: 40,
                        color: Colors.blueAccent,
                      ),
                    )
                ),
              ],
            )


          ),

          */


          /*
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0, left: 15),
                child: Text(
                  usuario.cityResidence,
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

           */


        ],
      ),
    );

    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'perfil_solicitante', arguments: usuario);
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

  void _confirmarContrato(ContractModel contrato, UserModel usuario) {
    contrato.userApplicantId = usuario.id;
    contrato.acceptedApplicant = true;
    contratosProvider.editarContrato(contrato);
    Navigator.pop(context);
    Navigator.pop(context);
    mostrar_dialog.MostrarDialog(context, 'El contrato fue asignado!',
        'Ahora ${usuario.name} aparecerá en la sección de colaboradores de tu proyecto');
  }

  Widget _imagenUser(UserModel usuario) {
    if (usuario.photoUrl == null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: AssetImage('assets/img/no-image.png'),
            fit: BoxFit.cover,
            height: double.infinity,
          ));
    } else if (usuario.photoUrl != null || usuario.photoUrl.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/img/loader3.gif'),
            image: NetworkImage(usuario.photoUrl),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ));
    }
  }
}
