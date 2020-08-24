import 'package:flutter/material.dart';
import 'package:Clapp/src/MyStudio/pages/project_management.dart';

class NewContract extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewContract();
  }


}
class _NewContract extends State<NewContract>{
  var _selectedValue;
  var _categoriesJobPosition = List<DropdownMenuItem>();

  var _categoriesWorkDays = List<DropdownMenuItem>();

  var _categoriesPlace = List<DropdownMenuItem>();

  var _categoriesDesiredSkills = List<DropdownMenuItem>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('New Contract',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
          ),
        body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 50.0,

              ),
              child: Form(
                //key: formKey,
                child: Column(

                  children: <Widget>[
                    _jobPosition(),
                    SizedBox(height: 25),
                    _workDays(),
                    SizedBox(height: 25),

                    _place(),
                    SizedBox(height: 25),
                    _payment(),
                    SizedBox(height: 25),
                    _desiredSkills(),
                    SizedBox(height: 45),

                    RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      label: Text('Open Contract',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, fontFamily: "Raleway")),
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.playlist_add_check,
                        color: Colors.white,
                      ),
                      color: Color.fromRGBO(89, 122, 121, 1.0),

                      onPressed: () {Navigator.pop(context, new MaterialPageRoute(
                          builder: (context) =>
                          new ProjectManagement())

                      );},
                    ),

                  ],
                ),
              ),
            ),
          ),


        ));
  }

  Widget _jobPosition(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _categoriesJobPosition,
      hint: Text('Job Positions'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }

  Widget _workDays(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _categoriesWorkDays,
      hint: Text('Work Days'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }

  Widget _place(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items:_categoriesPlace,
      hint: Text('Place'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }

  Widget _payment() {
    return TextFormField(

      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Payment',
      ),

    );
  }

  Widget _desiredSkills(){
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _categoriesDesiredSkills,
      hint: Text('Desired Skills'),
      onChanged: (value){
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }
  }

