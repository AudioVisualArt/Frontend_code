import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/Space/pages/new_space.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/User/providers/usuario_provider.dart';
import 'package:Clapp/src/User/widgets/menu_widget.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/pages/perfil_personal_disponible.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProfilePage extends StatefulWidget {
  final UserModel usuario;
  ProfilePage({Key key, this.usuario}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List tags = ['Informacion', 'Eventos', 'Eliminar cuenta'];
  bool _hasBeenPressed = false;
  final userProvider = new UsuarioProvider();
  final workerProvider = new WorkersProvider();
  final spaceProvider = new SpacesProvider();
  @override
  Widget build(BuildContext context) {
    UserModel usuario = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        //backgroundColor: Color.fromRGBO(89, 122, 121, 1),

        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color.fromRGBO(89, 122, 121, 1),
            ),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                newappbar(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7.0, left: 28, right: 10),
                        child: Container(
                            height: 100.0,
                            width: 100.0,
                            child:
                                _constructorImagen(usuario, 100.0, 100, 100)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, left: 18.0),
                            child: Text(
                              "Hola,",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(227, 227, 227, 1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0, left: 18.0),
                            child: Text(
                              usuario.name,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "Raleway",
                                  color: Color.fromRGBO(246, 246, 246, 1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 17,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "${usuario.cityResidence}-Colombia",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(227, 227, 227, 1.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 35,
                  child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: OutlineButton(
                          child: Center(
                            child: Text(
                              "Editar perfil",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Raleway",
                                  //color: Color.fromRGBO(112, 252, 118, 0.8),
                                  color: Color.fromRGBO(227, 227, 227, 1.0),
                                  /*color: _hasBeenPressed
                                          ? Color.fromRGBO(112, 252, 118, 0.8)
                                          : Color.fromRGBO(227, 227, 227, 1.0),

                                       */
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'editar_perfil',
                                arguments: usuario); //ver routes
                            setState(() {
                              _hasBeenPressed = !_hasBeenPressed;
                            });
                          },
                          //splashColor:  Color.fromRGBO(112, 252, 118, 0.8),
                          highlightedBorderColor:
                              Color.fromRGBO(112, 252, 118, 0.8),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 1.0),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                ),
                Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //color: Color.fromRGBO(227, 227, 227, 1.0),
                    borderRadius:
                        BorderRadius.only(
                            topLeft: Radius.circular(34),
                            topRight: Radius.circular(34),
                      bottomLeft: Radius.circular(29),
                    bottomRight: Radius.circular(29),
            ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 25, right: 25),
                        child: Text("Perfil",
                            style: TextStyle(
                                fontSize: 27.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        child: Container(
                           /* decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              color: Color.fromRGBO(227, 227, 227, 1),
                            ),

                            */
                            height: 150,
                            width: MediaQuery.of(context).size.width - 20.0,
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            padding: EdgeInsets.only(
                              top: 10.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Descripcion",
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(
                                              115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Text(
                                  usuario.description,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Container(
                          height: 1.2,
                          width: MediaQuery.of(context).size.width - 30,
                          color: Color.fromRGBO(227, 227, 227, 1.0),
                        ),
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          //color: Colors.white,
                        ),
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                  child: Text('Sus servicios publicados',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                            fontSize: 21.0,
                            fontFamily: "Raleway",
                            color: Color.fromRGBO(227, 227, 227, 1.0),
                            fontWeight: FontWeight.bold),)),
                            ),
                            Container(

                              height: 282,
                              child: _servicios(usuario),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                                child: Container(
                                  height: 1.2,
                                  width: MediaQuery.of(context).size.width - 30,
                                  color: Color.fromRGBO(227, 227, 227, 1.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Center(
                                child: Container(
                                    child: Text('Sus locaciones publicadas',
                                        textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 21.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(227, 227, 227, 1.0),
                                          fontWeight: FontWeight.bold),)),
                              ),
                            ),

                              _buildservicios(usuario),


                          ],
                        )),
                  ],
                ))
              ],
            ))));
  }
  Widget _buildservicios(UserModel usuario) {
    return FutureBuilder(
        future: spaceProvider.cargarEspaciosUsuario(usuario.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<SpaceModel>> snapshot) {
          if (snapshot.hasData) {
            final espacios = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: espacios.length,
              itemBuilder: (context, index) =>
                  locaciones(context, espacios[index], usuario),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
  Widget locaciones(BuildContext context, SpaceModel espacio, UserModel user) {
    return Padding(
        padding: EdgeInsets.only(left: 6.0, right: 6.0, top: 6, bottom: 5),
        child: InkWell(
            onTap: () {
              //this.arguments.add(user);
              //this.arguments.add(espacio);
              Navigator.pushNamed(context, 'space_details',
                  arguments: SegPagina(user, espacio));},
            child: Container(
                margin: EdgeInsets.only(left: 6, right: 6),
                //margin: EdgeInsets.only(top: 10, left: 15,right: 15),

                child: Column(
                  children: [
                    Container(
                      child: Hero(
                        tag: espacio.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0)),
                          child: FadeInImage(
                            placeholder: AssetImage('assets/img/loader3.gif'),
                            image: NetworkImage(espacio.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ) ,
                      height: 235, //MediaQuery.of(context).size.height - 495,
                      width: MediaQuery.of(context).size.width - 25,
                    ),
                    Stack(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Color.fromRGBO(237, 237, 237, 1.0)),
                              height: 83,
                              width: MediaQuery.of(context).size.width - 25,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                                padding: EdgeInsets.only(top: 7, left: 2, right: 2),
                                child: Container(
                                    child: Text(
                                      espacio.name,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(115, 115, 115, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Padding(
                                padding: EdgeInsets.only(
                                  top: 2,
                                  left: 12,
                                ),
                                child: Container(
                                  //width:                              MediaQuery.of(context).size.width - 240,
                                  child: Text(
                                    "${espacio.priceHour.toString()} COP/hora",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontFamily: "Raleway",
                                      color: Color.fromRGBO(115, 115, 115, 1.0),
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 2, left: 15, right: 12),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 200,
                                          maxHeight: 23
                                      ),
                                      //width:                                  MediaQuery.of(context).size.width - 255,
                                      child: Text(
                                        espacio.location,
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "Raleway",
                                          color: Color.fromRGBO(115, 115, 115, 1.0),
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding:
                                    EdgeInsets.only(top: 2, left: 8, right: 12),
                                    child: SmoothStarRating(
                                      rating: 0,
                                      isReadOnly: false,
                                      size: 18,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      defaultIconData: Icons.star_border,
                                      starCount: 5,
                                      allowHalfRating: true,
                                      spacing: 2.0,
                                      onRated: (value) {
                                        print("rating value -> $value");
                                      },
                                    )),


                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ))
        )
    );
  }

  Widget _servicios(UserModel usuario) {
    return FutureBuilder(
      future: workerProvider.cargarTrabajadoresUsuario(usuario.id),
      builder:
          (BuildContext context, AsyncSnapshot<List<WorkerModel>> snapshot) {
        if (snapshot.hasData) {
          final workers = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(

              itemCount: workers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  _buildServicio(context, workers[index], usuario),
            ),
          );
        } else {

           return Center(child: CircularProgressIndicator());
        }
        /*else if (snapshot.data == null){

          return Text("¿No tienes servicios?\nDirigete a Servicios y crea un perfil!",style: TextStyle(
              fontSize: 27.0,
              fontFamily: "Raleway",
              color: Color.fromRGBO(115, 115, 115, 1.0),
              fontWeight: FontWeight.bold));


          //return Center(child: CircularProgressIndicator());
        }

         */
      },
    );
  }

  Widget _buildServicio(context, WorkerModel workers, UserModel usuario) {

    return Padding(
      padding: EdgeInsets.only(top: 1.5, bottom: 3.2, left: 15, right: 15),
      child: InkWell(
        onTap: () {
          var ciudad = usuario.cityResidence;
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => PerfilPersonal(
                    workers.userId,
                    workers.mainRol,
                    usuario.name,
                    workers.description,
                    workers.profession,
                    ciudad,
                    usuario.photoUrl,
                    usuario,
                    workers.hvUrl)),
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
                tag: workers.userId,
                child: _constructorImagen(usuario, 50.0, 162, 160),
              ),
              SizedBox(height: 7.0),
              Text(
                usuario.name,
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Raleway",
                    color: Color.fromRGBO(115, 115, 115, 1.0),
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  workers.mainRol,
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: "Raleway",
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 4.0),
              Padding(
                padding: EdgeInsets.only(bottom: 0.5, left: 2.0, right: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 0.2, bottom: 2),
                        child: Container(
                            height: 37,
                            width: 85,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(112, 252, 118, 0.8),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(5),
                                )),
                            child: Center(
                              child: Text('Perfil',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: "Raleway",
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ))),
                    Padding(
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
                              child: Text('Estudio',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: "Raleway",
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ),
                            textColor: Colors.white,
                            color: Color.fromRGBO(0, 51, 51, 0.8),
                            onPressed: () {},
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      )

    );

  }

  Widget newappbar() {
    return Container(
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromRGBO(89, 122, 121, 1),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
          //borderRadius: BorderRadius.circular(20.0),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 7.0, right: 20, top: 37),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Color.fromRGBO(227, 227, 227, 1.0),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
          ),
        ));
  }

  Widget _constructorImagen(
      UserModel user, double borde, double wid, double hei) {
    if (user.photoUrl == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borde),
        child: Image(
          image: AssetImage('assets/img/no-image.png'),
          fit: BoxFit.cover,
          width: wid,
          height: hei,
        ),
      );
    } else if (user.photoUrl != null || user.photoUrl.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(borde),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/loader3.gif'),
              image: NetworkImage(
                user.photoUrl,
              ),
              width: wid,
              height: hei,
              fit: BoxFit.cover));
    }
  }
}
