import 'package:diary/screens/entries_screen.dart';
import 'package:diary/screens/favourites_screen.dart';
import 'package:diary/screens/home_screen.dart';

import 'package:diary/widgets/app_drawer.dart';

import 'package:flutter/material.dart';

class bottomNavigationBarScreen extends StatefulWidget {
  bottomNavigationBarScreen({Key? key}) : super(key: key);

  static List screens = [HomeScreen(), EntryScreen()];

  @override
  State<bottomNavigationBarScreen> createState() =>
      _bottomNavigationBarScreenState();
}

class _bottomNavigationBarScreenState extends State<bottomNavigationBarScreen> {
  List<Map<String, dynamic>> _pages = [];
  var _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
      },
      {
        'page': EntryScreen(),
      },
    ];
    super.initState();
  }

  void onTapedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(116, 58, 52, 1),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              backgroundColor: Theme.of(context).primaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.notes_outlined),
              label: 'Entries',
              backgroundColor: Theme.of(context).primaryColor),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(71, 28, 28, 1),
        unselectedItemColor: const Color.fromRGBO(250, 214, 165, 1),
        onTap: onTapedItem,
        elevation: 0,
      ),
    );
  }
}
