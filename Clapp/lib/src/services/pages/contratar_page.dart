import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContratarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContratarPage();
  }

}
class _ContratarPage extends State<ContratarPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(89, 122, 121, 1.0),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0,),
          Container(
            padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 0.5),
            width: MediaQuery.of(context).size.width - 30.0,
            height: MediaQuery.of(context).size.height - 50.0,
            child:  GridView.count(
              crossAxisCount: 2,
              primary: false,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 15.0,
            childAspectRatio: 0.69,
            children: <Widget>[
              _buildCard('James Franco', 'DP', "assets/img/perfiltest.PNG", true, context),
              _buildCard('James Franco', '1st AC', "assets/img/b4a49d4b864c74bb73de63f080ad7930-bot--n-de-perfil-de-instagram.png", true, context),



            ],),
          )
        ],
      ),
    );
  }

  Widget _buildCard(String name, String rol, String imgPath, bool added, context){
    return Padding(
      padding: EdgeInsets.only(top: 1.5, bottom: 1.5, left:  0.0, right: 0.0),
    child: InkWell(
      onTap: (){},
      child:  Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(15.0),
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
              tag: imgPath,
              child: Container(
                height: 170.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                  image: DecorationImage(
                    image: AssetImage(imgPath),
                    fit: BoxFit.contain,

                  )
                ),

              ),
            ),
            SizedBox(height: 4.0),
            Text(name,
              style: TextStyle(fontSize: 17.0, fontFamily: "Raleway",color: Colors.grey, fontWeight: FontWeight.bold ),),
            Text(rol,
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

}