import 'package:flutter/material.dart';

class BarraNavegacion extends StatefulWidget {
  @override
  _BarraNavegacionState createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {},
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment), title: Text('Proj ects')),
        BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory), title: Text('Store')),
        BottomNavigationBarItem(
            icon: Icon(Icons.slideshow), title: Text('Show')),
        BottomNavigationBarItem(icon: Icon(Icons.work), title: Text('Manage')),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
