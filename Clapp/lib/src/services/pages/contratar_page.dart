

import 'package:Clapp/src/User/bloc/provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audiovisual_page.dart';

class ContratarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContratarPage();
  }

}
class _ContratarPage extends State<ContratarPage>{

  final workerProvider = new WorkersProvider();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: workerProvider.cargarTrabajadores(),
        builder:
        (BuildContext context, AsyncSnapshot<List<WorkerModel>> snapshot) {
          if (snapshot.hasData) {
            final worker = snapshot.data;

            return Scaffold(

                body: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/background.jpg"),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: ListView(
                        children: <Widget>[
                          SizedBox(height: 15.0,),
                          Container(
                              padding: EdgeInsets.only(
                                  right: 10.0, left: 10.0, top: 0.5),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 30.0,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height - 50.0,
                              child: GridView.builder(
                                  primary: false,
                                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 15.0,
                                      childAspectRatio: 0.69),
                                  itemCount: worker.length,
                                  itemBuilder: (context, index) =>
                                      _buildCard(context, worker[index])
                              )
                          )
                        ]
                    )
                )
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

  Widget _buildCard(context, WorkerModel worker){
    return Padding(
      padding: EdgeInsets.only(top: 1.5, bottom: 3.2, left:  0.0, right: 0.0),
    child: InkWell(
      onTap: (){},
      child:  Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          boxShadow: [
            BoxShadow(
              color:  Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0
            )
          ],
          color: Color.fromRGBO(227, 227, 227, 1.0)
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.5),
            ) ,
            Hero(
              tag: worker.userId,
              child: Container(
                height: 170.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  image: DecorationImage(
                    image: AssetImage("assets/img/perfiltest.PNG"),
                    fit: BoxFit.contain,

                  )
                ),

              ),
            ),
            SizedBox(height: 4.0),
            _createname(worker),
           Text(worker.mainRol,
              style: TextStyle(fontSize: 17.0, fontFamily: "Raleway", color: Colors.grey, fontWeight: FontWeight.bold),),
            SizedBox(height: 4.0),
            Padding(
              padding: EdgeInsets.only(
                bottom: 0.5,
                  left: 5.0,
                  right: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                 child: Text('Perfil',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Colors.grey, fontWeight: FontWeight.bold)),
                textColor: Colors.white,

                color: Color.fromRGBO(112, 252, 118, 0.8),
                onPressed: () {
                              },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text('Estudio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Colors.grey, fontWeight: FontWeight.bold)),
                textColor: Colors.white,

                color: Color.fromRGBO(0, 51, 51, 0.8),
                onPressed: () {
                },
              ),

            ],),
            )


          ],
        ),
      ),
    ),);
  }

  Widget _createname(WorkerModel worker){
    return FutureBuilder(
        future: workerProvider.cargarUsuarioTrabajador(worker.userId),
      builder:
      (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
    if (snapshot.hasData) {
      final user = snapshot.data;
          return  Text(user.name,
          style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Colors.grey, fontWeight: FontWeight.bold ),);

    } else {
      return Center(child: CircularProgressIndicator());
    }
    },
    );
  }

}