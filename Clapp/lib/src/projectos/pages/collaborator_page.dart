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
            height: MediaQuery.of(context).size.height - 30.0,
            padding: EdgeInsets.only(
              right: 1.0,
              left: 1.0,
            ),
            child: Column(
              children: [
                newappbar(),
                Expanded(
                    child: SingleChildScrollView(
                        child: Container(
                  padding: EdgeInsets.only(
                    right: 5.0,
                    left: 5.0,
                    //top: 15.0,
                  ),
                  width: MediaQuery.of(context).size.width - 10.0,
                  height: MediaQuery.of(context).size.height - 150,

                  //TitleBar('Colaboradores'),

                  child: _crearListado(projectModel.id),
                )))
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
                childAspectRatio: 0.75,
                crossAxisSpacing: 13,
                mainAxisSpacing: 16),
            itemCount: projectos.length,
            itemBuilder: (context, index) =>
                _crearProyecto(context, projectos[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearProyecto(BuildContext context, UserModel user) {
    return Padding(
        padding: EdgeInsets.only(left: 7, right: 7),
        child: Container(

            /*decoration: ConcaveDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            colors: [
              Color.fromRGBO(230, 230, 230, 0.6),
              Color.fromRGBO(247, 245, 245, 0.6),
            ],
            depression: 15),

         */
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  topLeft: Radius.circular(100),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
             boxShadow: [
               BoxShadow(
                   color: Colors.black12,

                 spreadRadius: 6.0,
                 blurRadius: 4.0)

             ]
            ),

            //color: Colors.white.withOpacity(0.95),),

            //color: Colors.amber,
            //elevation: 20.0,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: _crearPhoto(user.photoUrl),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                    child: Center(
                        child: ClayContainer(
                      borderRadius: 10,
                      curveType: CurveType.none,
                      color: Color.fromRGBO(227, 227, 227, 1),
                      depth: 35,
                      spread: 3,
                      height: 80,
                      width: 160,
                      //borderRadius: 10,
                      //curveType: CurveType.none,
                      //color: Color.fromRGBO(227, 227, 227, 1),
                      //depth: 35,
                      //spread: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5, left: 2, right: 2),
                            child: Text('${user.name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Raleway",
                                    color: Color.fromRGBO(115, 115, 115, 1.0),
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2, left: 2, right: 2),
                            child: Text(user.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(115, 115, 115, 1.0),
                                )),
                          ),
                          // _crearDatosWork(user.id)
                        ],
                      ),
                    ))),
                /*ListTile(
              title: Text('${user.name}',
                  style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
              subtitle: Text(user.description,
                  style: TextStyle(fontSize: 15.0, fontFamily: "Raleway")),
            ),


            _crearDatosWork(user.id)

             */

                /*Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                        child: Text('Details ->',
                            style:
                            TextStyle(fontSize: 15.0, fontFamily: "Raleway")),
                        onPressed: () => Navigator.pushNamed(context, 'details_project',
                            arguments: proyecto)

                    ),
                  ],
                )*/
              ],
            )));
  }

  Widget _crearDatosWork(String userId) {
    return FutureBuilder(
      future: proyectosProvider.cargarWorkerInfo(userId),
      builder: (BuildContext context, AsyncSnapshot<WorkerModel> snapshot) {
        if (snapshot.hasData) {
          final worker = snapshot.data;
          return Text(worker.mainRol);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearPhoto(String photoUrl) {
    if (photoUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          width: 155.0,
          height: 155.0,
        ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                photoUrl,
              ),
              width: 145.0,
              height: 145.0,
              fit: BoxFit.cover));
    }
  }

  Widget newappbar() {
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
                      icon: Icon(Icons.arrow_back),
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 37),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text('Colaboraciones',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0))),
                      ),
                    ),
                  ),
                )
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
                          //_crearListado(usuario.id, usuario);
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }
}
