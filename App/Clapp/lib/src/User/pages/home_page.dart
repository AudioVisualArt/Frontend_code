import 'package:Clapp/src/User/bloc/provider.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
          children: <Widget>[
            Text('Email: ${bloc.email}'),
            Text('Pass: ${bloc.passw}')
          ],
        ),

    );
  }
}