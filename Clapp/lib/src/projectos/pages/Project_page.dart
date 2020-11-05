import 'package:flutter/material.dart';

import 'package:Clapp/src/projectos/pages/new_project_page.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/providers/proyectos_providers.dart';
import 'package:Clapp/src/MyStudio/widgets/title_bar.dart';
import 'package:Clapp/src/User/models/user_model.dart';

class ProjectPage extends StatefulWidget {
  final UserModel user;
  ProjectPage({Key key, this.user}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final proyectosProvider = new ProyectosProvider();
  List<dynamic> args=new List();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    //final idUsuario = ModalRoute.of(context).settings.arguments;
    args.add(usuario);
    //print('id User ' + widget.user.id);

    return Scaffold(
      body: _createproject(context, usuario),
    );
  }

  Widget _createproject(BuildContext context, UserModel userModel) {
    print('Id del usuario: ${userModel.id}');

    final size = MediaQuery.of(context).size;
    final idUsuario = ModalRoute.of(context).settings.arguments;
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

            //key: formKey,
            child: Column(
              children: <Widget>[
                newappbar(userModel),

                //SizedBox(height: 9),

                Expanded(
                    child: Container(
                  child: _crearListado(userModel.id),
                  //padding: EdgeInsets.all(4.0),
                  width: MediaQuery.of(context).size.width - 10.0,
                  height: MediaQuery.of(context).size.height - 210,
                )),
                //SizedBox(height: 5),
                /*  RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      label: Text('Proyecto nuevo',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.create_new_folder,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(89, 122, 121, 1.0),
                      onPressed: () {
                        Navigator.pushNamed(context, 'new_project',
                            arguments: userModel); //ver routes
                      },
                    ),

                   */
              ],
            )));
  }

  Widget newappbar(UserModel userModel) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 20, top: 37),
                    child: Text('Proyectos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 7, top: 37),
                  child: _botonProyectoNuevo(userModel),
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
                         _crearListado(userModel.id);
                        });
                      },
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _botonProyectoNuevo(UserModel userModel) {
    return RaisedButton(
      splashColor: Colors.grey,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromRGBO(0, 51, 51, 1), width: 1.2),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),

      child: Text(' Nuevo  ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 21.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(0, 51, 51, 1),
              fontWeight: FontWeight.bold)),
      //textColor: Colors.white,
      color: Colors.white,

      onPressed: () {
        Navigator.pushNamed(context, 'new_project',
            arguments: userModel); //ver routes
      },
    );
  }

  Widget _crearListado(idUsuario) {
    return FutureBuilder(
      future: proyectosProvider.cargarProyectos(idUsuario),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        if (snapshot.hasData) {
          final projectos = snapshot.data;
          return ListView.builder(
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

  Widget _crearProyecto(BuildContext context, ProjectModel proyecto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          proyectosProvider.borrarProyectos(proyecto.id);
        },
        child: Card(
            elevation: 0.0,
            color: Color.fromRGBO(227, 227, 227, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            child: InkWell(
              onTap: () {
                args.add(proyecto);
                Navigator.pushNamed(context, 'details_project',
                  arguments: args);
                  },
              child: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('${proyecto.proyectName}',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0),
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(proyecto.projectType,
                          style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0),
                              fontWeight: FontWeight.bold)),
                      leading: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            )));
  }
}
