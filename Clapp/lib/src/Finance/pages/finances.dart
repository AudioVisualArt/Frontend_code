import 'package:Clapp/src/Finance/Model/Finance.dart';
import 'package:Clapp/src/Finance/provider/finances_provider.dart';
import 'package:Clapp/src/projectos/model/project_model.dart';
import 'package:Clapp/src/projectos/widgets/concave_decoration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Finances extends StatefulWidget {
  final ProjectModel project;
  Finances({Key key, this.project}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Finances();
  }
}

class _Finances extends State<Finances> {
  String state = 'Animation start';
  FinancesProvider financesProvider = new FinancesProvider();
  @override
  Widget build(BuildContext context) {
    ProjectModel project = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/img/home.jpg"),
        fit: BoxFit.cover,
      )),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            appbar(project),
            crearlistado(project.id)


            /*Padding(
              padding: EdgeInsets.all(15),
              child: LinearPercentIndicator(
                lineHeight: 20,
                center: Text('50%'),
                progressColor: Colors.blueAccent,
                percent: .5,
                animation: true,
                animationDuration: 5000,
                onAnimationEnd: () =>
                    setState(() => state = 'End Animation at 50%'),
              ),
            ),
            Text(state),

             */
          ],
        ),
      ),
    ));
  }

  Widget crearlistado(String id){
    return FutureBuilder(
      future: financesProvider.cargarFinanzas(id),

      builder: (BuildContext context, AsyncSnapshot<List<FinanceModel>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }else{
          final finanzas = snapshot.data;
          return ListView.builder(
              shrinkWrap: true,
              itemCount: finanzas.length,
              itemBuilder: (context, index){
                if(finanzas[index].title != "Total"){
                  return crowdfunding(
                    finanzas[index].title,
                    "${finanzas[index].quantity} COP",
                    "${finanzas[index].quantity} COP",
                    finanzas[index].percentage,
                    "${num.parse((finanzas[index].percentage*100).toStringAsFixed(3))}%",
                    Color.fromRGBO(112, 252, 118, 1),
                  );
                }else{
                  return crowdfunding(
                      finanzas[index].title,
                      "${finanzas[index].quantity} COP",
                      "${finanzas[index].quantity} COP",
                      finanzas[index].percentage,
                      "${num.parse((finanzas[index].percentage*100).toStringAsFixed(3))}%",
                      Colors.blueAccent);
                }
              }
          );
        }
      },
    );
  }

  Widget crowdfunding(String nombre, String cantidad, String objetivo,
      double porcenbarra, String textbarra, final colorBarra) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                //color: Color.fromRGBO(112,252,118, 1),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0, bottom: 15),
                    child: Text(
                      nombre,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(0, 51, 51, 0.8),
                          fontWeight: FontWeight.bold),
                    )))),
        Container(
            decoration: ConcaveDecoration(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                colors: [
                  Color.fromRGBO(217, 217, 217, 0.8),
                  Color.fromRGBO(230, 255, 231, 1),
                ],
                depression: 15),
            child: Column(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                    child: Text("Cantidad recaudada",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Raleway",
                          color: Color.fromRGBO(115, 115, 115, 1.0),
                        ))),
                Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Text(cantidad,
                        style: TextStyle(
                            fontSize: 18.0,
                            // fontFamily: "Raleway",
                            color: Color.fromRGBO(0, 51, 51, 0.8),
                            fontWeight: FontWeight.bold))),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 45,
                    animation: true,
                    // restartAnimation: true,
                    lineHeight: 22.0,
                    animationDuration: 1200,
                    percent: porcenbarra,
                    animateFromLastPercent: true,
                    center: Text(textbarra),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: colorBarra,
                    backgroundColor: Color.fromRGBO(227, 227, 227, 1),
                    maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Text(textbarra,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                              ))),
                      Container(
                          child: Text(objetivo,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Raleway",
                                color: Color.fromRGBO(115, 115, 115, 1.0),
                              ))),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget appbar(ProjectModel proyecto) {
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 37.0,
                    right: 5,
                  ),
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 37),
                      child: Text('Finanzas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Raleway",
                              color: Color.fromRGBO(115, 115, 115, 1.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 7, top: 37),
                  child: _botonNuevo(proyecto),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0),

              //mainAxisAlignment: MainAxisAlignment.center,

              child: Text('${proyecto.proyectName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(115, 115, 115, 1.0),
                      fontSize: 30,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }

  Widget _botonNuevo(ProjectModel project) {
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
        Navigator.pushNamed(context, 'newgoal', arguments: project
            ); //ver routes
      },
    );
  }
}
