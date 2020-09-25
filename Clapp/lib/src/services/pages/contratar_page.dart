import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Clapp/src/services/pages/perfil_personal_disponible.dart';

import 'audiovisual_page.dart';

class ContratarPage extends StatefulWidget {
  final UserModel user;
  ContratarPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContratarPage();
  }
}

class _ContratarPage extends State<ContratarPage> {
  final workerProvider = new WorkersProvider();

  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return FutureBuilder(
        future: workerProvider.cargarTrabajadores(),
        builder:
            (BuildContext context, AsyncSnapshot<List<WorkerModel>> snapshot) {
          if (snapshot.hasData) {
            final worker = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text('Personal',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height - 30,
                width: double.infinity,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/img/background.jpg"),
                      fit: BoxFit.cover,
                    )),
                    child: ListView(children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 0.5),
                          width: MediaQuery.of(context).size.width - 30.0,
                          height: MediaQuery.of(context).size.height - 50.0,
                          child: GridView.builder(
                              primary: false,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 11.0,
                                      mainAxisSpacing: 15.0,
                                      childAspectRatio: 0.69),
                              itemCount: worker.length,
                              itemBuilder: (context, index) =>
                                  _buildCard(context, worker[index], usuario)))
                    ])),
              ),
              floatingActionButton: _BotonCrear2(usuario),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
          /*children: <Widget>[
              _buildCard('James Franco', 'DP', "assets/img/perfiltest.PNG", context),
              _buildCard('James Franco', '1st AC', "assets/img/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png", context),



            ]*/
        });
  }

  Widget _BotonCrear2(UserModel usuario) {
    return RaisedButton(
      splashColor: Colors.green,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text('Nuevo servicio',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(115, 115, 115, 1.0),
              fontWeight: FontWeight.bold)),
      textColor: Colors.white,
      color: Color.fromRGBO(112, 252, 118, 0.8),
      onPressed: () {
        Navigator.pushNamed(context, 'new_service', arguments: usuario);
      },
    );
  }

  Widget _buildCard(context, WorkerModel worker, UserModel usuario) {
    return FutureBuilder(
      future: workerProvider.cargarUsuarioTrabajador(worker.userId),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          return Padding(
            padding:
                EdgeInsets.only(top: 1.5, bottom: 3.2, left: 0.0, right: 0.0),
            child: InkWell(
              onTap: () {
                var ciudad = user.cityResidence;
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PerfilPersonal(
                          worker.userId,
                          worker.mainRol,
                          user.name,
                          worker.description,
                          worker.profession,
                          ciudad,
                          user.photoUrl,
                          usuario)),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Color.fromRGBO(227, 227, 227, 1.0)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.5),
                    ),
                    Hero(
                      tag: worker.userId,
                      child: _crearImage(worker),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      user.name,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(115, 115, 115, 1.0),
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        worker.mainRol,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(115, 115, 115, 1.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 0.5, left: 5.0, right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text('Perfil',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "Raleway",
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            textColor: Colors.white,
                            color: Color.fromRGBO(112, 252, 118, 0.8),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text('Estudio',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "Raleway",
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            textColor: Colors.white,
                            color: Color.fromRGBO(0, 51, 51, 0.8),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearImage(WorkerModel worker) {
    return FutureBuilder(
        future: workerProvider.cargarUsuarioTrabajador(worker.userId),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return _constructorImagen(user);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _constructorImagen(UserModel user) {
    if (user.photoUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          width: 160.0,
          height: 160.0,
        ),
      );
    } else if (user.photoUrl != null || user.photoUrl.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                user.photoUrl,
              ),
              width: 160.0,
              height: 160.0,
              fit: BoxFit.cover));
    }
  }
}
