import 'package:Clapp/src/User/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';



class ProviderSignUp extends InheritedWidget{

  static ProviderSignUp _instancia;

  factory ProviderSignUp({Key key, Widget child}) {

    if (_instancia == null) {
      _instancia = new ProviderSignUp._internal(key: key , child: child);
    }
    return _instancia;
  }

  ProviderSignUp._internal({ Key key, Widget child})
      : super(key: key , child: child);


  final signUpBloc = SignUpBloc();



  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SignUpBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ProviderSignUp>().signUpBloc;
  }



}