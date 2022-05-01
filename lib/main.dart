import 'package:diary/screens/add_journal.dart';
import 'package:diary/screens/entries_screen.dart';

import 'package:diary/screens/bottom_navigation_bar_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(252, 156, 84, 1),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromRGBO(250, 214, 165, 1)),
      ),
      title: 'FlutterDiary',
      initialRoute: '/',
      routes: {
        '/': (ctx) => bottomNavigationBarScreen(),
        EntryScreen.routeName: (ctx) => EntryScreen(),
        AddJournal.routeName: (ctx) => AddJournal(),
      },
      onGenerateRoute: (settings) {},
    );
  }
}
