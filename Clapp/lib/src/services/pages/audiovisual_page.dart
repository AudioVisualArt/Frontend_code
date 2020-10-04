import 'package:Clapp/src/services/pages/other_page.dart';
import 'package:Clapp/src/services/pages/personel_page.dart';
import 'package:Clapp/src/services/pages/spaces_page.dart';
import 'package:flutter/material.dart';

import 'package:Clapp/src/services/pages/equipment_page.dart';
import 'package:Clapp/src/services/pages/other_page.dart';
import 'package:Clapp/src/services/pages/personel_page.dart';
import 'package:Clapp/src/services/pages/spaces_page.dart';

class AudiovisualPage extends StatefulWidget{
  AudiovisualPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AudiovisualPage();
  }

}

class _AudiovisualPage extends State<AudiovisualPage>{
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    final List<Widget> _screens = [

      PersonelPage(),
      EquipmentPage(),
      SpacesPage(),
      OtherPage(),

    ];



    return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          fixedColor: Color.fromRGBO(0, 51, 51, 1.0),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              title: Text('Personal'),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera_roll,
                ),
                title: Text('Equipo')),
            BottomNavigationBarItem(
                icon: Icon(Icons.panorama), title: Text('Espacios')),


            BottomNavigationBarItem(
                icon: Icon(Icons.camera_enhance), title: Text('Otros')),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

