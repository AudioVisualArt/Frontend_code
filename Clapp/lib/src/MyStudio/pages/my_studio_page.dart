import 'package:flutter/material.dart';

import 'package:Clapp/src/MyStudio/pages/Project_page.dart';
import 'package:Clapp/src/MyStudio/pages/manage_page.dart';
import 'package:Clapp/src/MyStudio/pages/show_page.dart';
import 'package:Clapp/src/MyStudio/pages/store_page.dart';
import 'package:Clapp/src/item/pages/ver_productos_page.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/front_clapp/Code/Clapp/lib/src/projectos/pages/new_project_page.dart';

class MyStudioPage extends StatefulWidget {
  MyStudioPage({Key key}) : super(key: key);

  @override
  _MyStudioPageState createState() => _MyStudioPageState();
}

class _MyStudioPageState extends State<MyStudioPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final idUsuario = ModalRoute.of(context).settings.arguments;

    final List<Widget> _screens = [
      ProjectPage(),
      StorePage(),
      MostrarProductosPage(),
      ManagePage()
    ];

    print('IdUsuario: ' + idUsuario.toString());

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
                Icons.assignment,
              ),
              title: Text('Projects'),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.store_mall_directory,
                ),
                title: Text('Store')),
            BottomNavigationBarItem(
                icon: Icon(Icons.slideshow), title: Text('Show')),
            BottomNavigationBarItem(
                icon: Icon(Icons.work), title: Text('Manage')),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
