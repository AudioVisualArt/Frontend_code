import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';

class VerColaboradores extends StatefulWidget {
  final ProjectModel project;
  VerColaboradores({Key key, this.project}) : super(key: key);
  @override
  _VerColaboradores createState() => _VerColaboradores();
}

class _VerColaboradores extends State<VerColaboradores> {
  final proyectosProvider = new ProyectosProvider();

  @override
  Widget build(BuildContext context) {
    ProjectModel projectModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: _crearColaboradores(context, projectModel),
    );
  }

  Widget _crearColaboradores(BuildContext context, ProjectModel projectModel) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostraritems.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 10.0,

            child: Column(
              children: [
                newappbar(projectModel),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 150,

                      //TitleBar('Colaboradores'),

                      child: _crearListado(projectModel.id),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ))),
              ],
            )));
  }

  Widget _crearListado(projectId) {
    return FutureBuilder(
      future: proyectosProvider.cargarColaboradores(projectId),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          final projectos = snapshot.data;
          return GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.0,
                mainAxisSpacing: 6.0,
                childAspectRatio: 0.66),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            itemCount: projectos.length,
            itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 15),
                child: _cardColaborador(context, projectos[index])),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _cardColaborador(BuildContext context, UserModel usuario) {
    final card = Container(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Stack(
                children: [
                  _imagenUser(usuario),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 22),
                      child: Text(
                        usuario.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Raleway",
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 10,
                    child: Text(
                      usuario.age.toString() + ' años',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: "Raleway",
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),





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


        ],
      ),
    );

    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'perfil_solicitante',
              arguments: usuario);
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

  Widget _crearDatosWork(String userId) {
    return FutureBuilder(
      future: proyectosProvider.cargarWorkerInfo(userId),
      builder: (BuildContext context, AsyncSnapshot<WorkerModel> snapshot) {
        if (snapshot.hasData) {
          final worker = snapshot.data;
          return Text(worker.mainRol,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: "Raleway",
                color: Color.fromRGBO(89, 89, 89, 1.0),
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget newappbar(ProjectModel projectModel) {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 7.0, right: 20, top: 37),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
               Padding(
                    padding: EdgeInsets.only(top: 37),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width-80,


                          child: Align(
                            alignment: Alignment(-0.55, 0.0),
                            child: Text('Colaboraciones',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(115, 115, 115, 1.0))),
                          ),

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
                    Text('Actualizar',
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
                          _crearListado(projectModel.id);
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
