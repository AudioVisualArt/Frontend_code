import 'package:Clapp/src/Equipment/model/equipment_models.dart';
import 'package:Clapp/src/Equipment/pages/equipment_buy_page.dart';
import 'package:Clapp/src/Equipment/provider/equipment_provider.dart';
import 'package:Clapp/src/Space/model/SpaceModel.dart';
import 'package:Clapp/src/Space/pages/new_space.dart';
import 'package:Clapp/src/Space/provider/SpacesProvider.dart';
import 'package:Clapp/src/StockPhoto/model/stockphoto_models.dart';
import 'package:Clapp/src/StockPhoto/pages/stockphoto_buy_page.dart';
import 'package:Clapp/src/StockPhoto/provider/stockphoto_provider.dart';
import 'package:Clapp/src/User/models/user_model.dart';
import 'package:Clapp/src/services/model/worker_model.dart';
import 'package:Clapp/src/services/providers/worker_provider.dart';
import 'package:Clapp/src/services/pages/perfil_personal_disponible.dart';
import 'package:flutter/material.dart';
class RecomendadosPage extends StatefulWidget {
  final UserModel userF;
  RecomendadosPage({Key key, this.userF}) : super(key: key);

  @override
  _RecomendadosPageState createState() => _RecomendadosPageState();
}

class _RecomendadosPageState extends State<RecomendadosPage> {
  
  List<String> _categories = ["Actores", "Personal Tecnico", "Equipos", "Espacios","Arte"];
  List<StockPhotoModel> photos=new List();
  List<UserModel> usersA=new List();
  List<UserModel> usersW=new List();
  List<UserModel> usersE=new List();
  List<SpaceModel> espacios=new List();
  List<WorkerModel> actores=new List();
  List<WorkerModel> tecnico=new List();
  List<EquipmentModel> equipos=new List();
  EquipmentProvider eq=new EquipmentProvider();
  WorkersProvider wk=new WorkersProvider();
  StockPhotoProvider ph=new StockPhotoProvider();
  SpacesProvider sp=new SpacesProvider();
  double value;
  int selectedIndex=0;
  List<double> _valores=new List();
  final ScrollController sc= ScrollController();
 
  @override
  Widget build(BuildContext context) {
    _valores=ModalRoute.of(context).settings.arguments;
    
    return Container(
      child: Scaffold(
        appBar: AppBar(
        title: Text(
          'Recomendados',
          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mostraritems.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  controller: sc,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            FutureBuilder(
              future: _llenarR(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  return _tarjetas(selectedIndex);
                }
                else{
                  return Container(

                  );
                }
              },
            ),
           SizedBox(height: 65.0),
          ]
          
          ),
      ),
      bottomSheet: _presupuesto()
      ),
    );
  }


  Widget buildCategory(int index) {
 
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0: value=sc.position.minScrollExtent;
          break;
            
          case 1:value=sc.position.minScrollExtent;
          break;

          case 2:value=sc.position.maxScrollExtent;
          break;
          case 3:value=sc.position.maxScrollExtent;
          break;
          default:
        }
        setState(() {
          selectedIndex = index;
          sc.animateTo(value, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: <Widget>[
              Text(
                _categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Colors.blue : Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0), //top padding 5
                height: 2,
                width: 40,
                color: selectedIndex == index ? Colors.black : Colors.transparent,
              )
            ],
          ),
        ),
    );
  }

  Future<bool> _llenarR() async {
    List workers=await wk.cargarTrabajadores();
    int i=0;
    this.actores.clear();
    this.tecnico.clear();
    this.usersW.clear();
    this.usersA.clear();
    workers.forEach((element) async{
      UserModel user= await wk.cargarUsuarioTrabajador(element.userId);
      if(element.mainRol=="Actor" && element.minPayment<=_valores[0]){
        this.actores.add(element);
        this.usersA.add(user);
        print("entre 1");
      }else{
        if(element.minPayment<=_valores[1]){
          print("Valor: ${_valores[1]} y min pay ${element.minPayment}");
          this.tecnico.add(element);
          this.usersW.add(user);
          print("Entre 2");
        }
        
      }
     
    });
    this.photos=await ph.cargarPhotos();
    this.photos.removeWhere((element) => element.valor>_valores[4]);
    this.equipos=await eq.cargarEquipments();
    this.equipos.removeWhere((element) => element.valor>_valores[2]);
    this.espacios=await sp.cargarEspacios();
    this.espacios.removeWhere((element) => element.priceHour>_valores[3]);
    this.espacios.forEach((element) async {
      UserModel user= await wk.cargarUsuarioTrabajador(element.userOwner);
      this.usersE.add(user);
    });

    return true;

  }

  Widget _tarjetasActores(index)  {
    WorkerModel wker=this.actores[index];
    UserModel user= this.usersA[index];
    if(user.photoUrl==null){
      user.photoUrl=('https://britz.mcmaster.ca/images/nouserimage.gif/image');
    }
    return InkWell(
      child: Container(
                
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
                height: 300,
                width: 160,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 189, 185 , 1.0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(5.0, 4.0)
                      )
                    ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Text(user.name, 
                        style: TextStyle(
                          color: Color.fromRGBO(0, 51, 51, 0.8),
                            fontSize: 15.5,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center
                        ),
                      ),
                      
                      SizedBox(height: 5.0,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image(
                          image: NetworkImage(user.photoUrl),
                          width: 140,
                          height: 120,
                          fit: BoxFit.cover,
                          ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Profesion: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Text(wker.profession,textAlign: TextAlign.center,),
                      SizedBox(height: 5.0,),                    
                      Text('Pago minimo: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                      )),
                      Text(wker.minPayment.toString(), textAlign: TextAlign.center,),  

                    ],
                  ),
                ),
      ),
      onTap: (){
        Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PerfilPersonal(
                          wker.userId,
                          wker.mainRol,
                          user.name,
                          wker.description,
                          wker.profession,
                          user.cityResidence,
                          user.photoUrl,
                          widget.userF,
                          wker.hvUrl)
                    ),
        );
      },
    );
  }
  Widget _tarjetasTecnico(index)  {
    WorkerModel wker=this.tecnico[index];
    UserModel user= this.usersW[index];
    if(user.photoUrl==null){
      user.photoUrl=('https://britz.mcmaster.ca/images/nouserimage.gif/image');
    }
    return InkWell(
          child: Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
                height: 300,
                width: 160,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 189, 185 , 1.0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(5.0, 4.0)
                      )
                    ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 40,

                        child:  Text(user.name,
                      style: TextStyle(
                         color: Color.fromRGBO(0, 51, 51, 0.8),
                          fontSize: 15.5,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center
                        ),
                      ),
                     
                      SizedBox(height: 5.0,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage(user.photoUrl),
                           width: 140,
                          height: 120,
                          fit:BoxFit.cover
                          ),
                      ),
                     SizedBox(height: 10.0,),
                      Text('Profesion: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Text(wker.profession,textAlign: TextAlign.center,),
                      SizedBox(height: 5.0,),                    
                      Text('Pago minimo: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                      )),
                      Text(wker.minPayment.toString(), textAlign: TextAlign.center,),  


                    ],
                  ),
                ),
      ),
      onTap: (){
       Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PerfilPersonal(
                          wker.userId,
                          wker.mainRol,
                          user.name,
                          wker.description,
                          wker.profession,
                          user.cityResidence,
                          user.photoUrl,
                          widget.userF,
                          wker.hvUrl)
                    ),
        );
      }
    );
  }
  Widget _tarjetasEquipos(index)  {
    EquipmentModel equip=this.equipos[index];
    if(equip.fotoUrl==null || equip.fotoUrl==""){
      equip.fotoUrl=('https://evangelismodigital.net/wp-content/plugins/learnpress/assets/images/no-image.png');
    }
      return InkWell(
            onTap: ()=> Navigator.push(
                      context,
                      new MaterialPageRoute(
                      builder: (context) => new EquipmentCompraPage(
                      equipmentModel: equip,
                      userModel: widget.userF,
                  ))),
            child: Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
                  height: 300,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(181, 189, 185 , 1.0),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(5.0, 4.0)
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child:Text(equip.titulo,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 51, 51, 0.8),
                              fontSize: 15.5,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center
                          )
                        )
                        ,
                        SizedBox(height: 5.0,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            image: NetworkImage(equip.fotoUrl),
                            width: 140,
                            height: 120,
                            fit: BoxFit.cover,
                            ),
                        ),
                        SizedBox(height: 10.0,),
                        Text("Marca: " , style: TextStyle(
                          fontWeight: FontWeight.bold)),
                        Text(equip.marca, textAlign: TextAlign.center),
                        SizedBox(height: 5.0,),
                        Text("Modelo: " , style: TextStyle(
                          fontWeight: FontWeight.bold)),
                        Text(equip.modelo, textAlign: TextAlign.center),
                        SizedBox(height: 5.0,),
                        Text("Valor: " , style: TextStyle(
                          fontWeight: FontWeight.bold)),
                        Text(equip.valor.toString(), textAlign: TextAlign.center),

                      ],
                    ),
                  ),
        ),
      );
  }

  Widget _tarjetasEspacios(index) {
    SpaceModel space=this.espacios[index];
    if(space.imageUrl==null || space.imageUrl==""){
      space.imageUrl=('https://evangelismodigital.net/wp-content/plugins/learnpress/assets/images/no-image.png');
    }

    return InkWell(
            child: Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
                  height: 300,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(181, 189, 185 , 1.0),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(5.0, 4.0)
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Text(space.name,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 51, 51, 0.8),
                              fontSize: 15.5,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            image: NetworkImage(space.imageUrl),
                            width: 140,
                            height: 120,
                            fit: BoxFit.cover,
                            ),
                        ),
                        SizedBox(height: 10.0,),
                        Text("Locacion: " , style: TextStyle(
                          fontWeight: FontWeight.bold)),
                        Text(space.location,textAlign: TextAlign.center,),

                        SizedBox(height: 5.0,),
                        Text("Precio hora: " , style: TextStyle(
                          fontWeight: FontWeight.bold)),
                        Text(space.priceHour.toString(),textAlign: TextAlign.center),
                      
                      ],
                    ),
                  ),
        ),
        onTap: (){
          Navigator.pushNamed(context, 'space_details',
                arguments: SegPagina(this.usersE[index], space));
        },
      );
    
  }

  Widget _tarjetasArte(index)  {
    StockPhotoModel ph=this.photos[index];
    if(ph.fotoUrl==null || ph.fotoUrl==""){
      ph.fotoUrl=('https://evangelismodigital.net/wp-content/plugins/learnpress/assets/images/no-image.png');
    }
      return InkWell(
          child: Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top:5.0,left: 5.0,right: 5.0),
                height: 300,
                width: 160,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 189, 185 , 1.0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(5.0, 4.0)
                      )
                    ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Text(ph.titulo,
                        style: TextStyle(
                           color: Color.fromRGBO(0, 51, 51, 0.8),
                            fontSize: 15.5,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                          image: NetworkImage(ph.fotoUrl),
                           width: 140,
                          height: 120,
                          fit: BoxFit.cover,
                          ),
                      ),
                      SizedBox(height: 10.0,),
                      Text("Typo: " , style: TextStyle(
                        fontWeight: FontWeight.bold)),
                      Text(ph.photoType,textAlign: TextAlign.center,),
                      SizedBox(height: 5.0,),
                      Text("Valor: " , style: TextStyle(
                        fontWeight: FontWeight.bold)),
                      Text(ph.valor.toString(),textAlign: TextAlign.center),

                    ],
                  ),
                ),
      ),
      onTap: (){
        Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new StockPhotoComprarPage(
                                  stockPhotoModel: ph,
                                  userModel: widget.userF,
                                )));
      },
    );
  
    
  }

  Widget _tarjetas(int selectedIndex) {
  
    switch (selectedIndex) {
      case 0: return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: actores.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ), 
                itemBuilder: (context,index) {
                  return _tarjetasActores(index);
                } ,
                ),
            ),
          );
        
        break;
      case 1:return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: tecnico.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ), 
                itemBuilder: (context,index) => _tarjetasTecnico(index),
                ),
            ),
          );
        break;
      case 2: return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: equipos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ), 
                itemBuilder: (context,index) =>  _tarjetasEquipos(index),
                ),
            ),
          );
        break;
      case 3: return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: espacios.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ), 
                itemBuilder: (context,index) => _tarjetasEspacios(index),
                ),
            ),
          );
        break;
      case 4: return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ), 
                itemBuilder: (context,index) => _tarjetasArte(index),
                ),
            ),
          );

        break;
      default:
      return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                itemCount: actores.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.70,
                ), 
                itemBuilder: (context,index) {
                  return _tarjetasActores(index);
                } ,
                ),
            ),
      );
      break;
    }

  }

  Widget _presupuesto() {
    switch (selectedIndex) {
      case 0: return Card(
        
              child: ListTile(
          
                title: Row(children: [
                  SizedBox(width: 100,),
                  Icon(Icons.monetization_on_outlined,color: Colors.green,),
                  SizedBox(width: 50,),
                  Text("${_valores[0]}"),
                ],),
              ),
            );
        
        break;
      case 1:  return Card(
        
              child: ListTile(
          
                title: Row(children: [
                  SizedBox(width: 100,),
                  Icon(Icons.monetization_on_outlined,color: Colors.green,),
                  SizedBox(width: 50,),
                  Text("${_valores[1]}"),
                ],),
              ),
            );
        
        break;
      case 2:  return Card(
        
              child: ListTile(
          
                title: Row(children: [
                  SizedBox(width: 100,),
                  Icon(Icons.monetization_on_outlined,color: Colors.green,),
                  SizedBox(width: 50,),
                  Text("${_valores[2]}"),
                ],),
              ),
            );
        
        break;
      case 3:  return Card(
        
              child: ListTile(
          
                title: Row(children: [
                  SizedBox(width: 100,),
                  Icon(Icons.monetization_on_outlined,color: Colors.green,),
                  SizedBox(width: 50,),
                  Text("${_valores[3]}"),
                ],),
              ),
            );
        
        break;
      case 4:  return Card(       
              child: ListTile(
                title: Row(children: [
                  SizedBox(width: 100,),
                  Icon(Icons.monetization_on_outlined,color: Colors.green,),
                  SizedBox(width: 50,),
                  Text("${_valores[4]}"),
                ],),
              ),
            );
        break;
      default:  return Card(
        
              child: ListTile(
          
                title: Row(children: [
                  SizedBox(width: 100,),
                  Icon(Icons.monetization_on_outlined,color: Colors.green,),
                  SizedBox(width: 50,),
                  Text("0"),
                ],),
              ),
            );
        
        break;
    }
  }
}
