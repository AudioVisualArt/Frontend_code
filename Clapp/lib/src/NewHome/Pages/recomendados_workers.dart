import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/pages/perfil_personal_disponible.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:flutter/material.dart';

class RecomendadosWorkers extends StatelessWidget {
  final WorkerModel workers;
  final UserModel usuario;
  final workerProvider = new WorkersProvider();

  RecomendadosWorkers({this.workers, this.usuario});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: workerProvider.cargarUsuarioTrabajador(workers.userId),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: InkWell(
              onTap: () {
                var ciudad = user.cityResidence;
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PerfilPersonal(
                          workers.userId,
                          workers.mainRol,
                          user.name,
                          workers.description,
                          workers.profession,
                          ciudad,
                          user.photoUrl,
                          usuario,
                          workers.hvUrl)),
                );
              },

            child: Container(
              height: 105,
              width: MediaQuery.of(context).size.width-40
              ,
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      padding: EdgeInsets.only(top: 8, left: 14),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(112, 252, 118, 1),
                            Color.fromRGBO(121, 181, 136, 1),
                          ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, -6),
                              blurRadius: 25,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           _imagenWorker(user),
                        Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0,left: 10),
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 24,
                                maxWidth: 270
                              ),

                              child: Text(user.name,

                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(100, 100, 110, 1),
                                      fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
                          /*Text("${guion.pages.toString()} paginas",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Raleway",
                        color: Colors.black54,
                        //fontWeight: FontWeight.bold
                      )),

                  */

                          Padding(
                            padding: const EdgeInsets.only(left : 10.0),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxHeight: 24,
                                  maxWidth: 270
                              ),
                              child: Text("Rol: "+workers.mainRol,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Raleway",
                                    color: Colors.black87,
                                    //fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left : 10.0),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxHeight: 24,
                                  maxWidth: 270
                              ),
                              child: Text(user.cityResidence,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Raleway",
                                    color: Colors.black87,
                                    //fontWeight: FontWeight.bold
                                  )),
                            ),
                          ),


                        ],
                      )],
                      )
                  ),


                ],
              ),

          )

            ,)
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _imagenWorker(UserModel usuario) {
    if (usuario.photoUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          //width: wid,
          width: 80,
          height: 80,
        ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                usuario.photoUrl,
              ),
              width: 80,
              height: 80,
              fit: BoxFit.cover));
    }
  }
}
