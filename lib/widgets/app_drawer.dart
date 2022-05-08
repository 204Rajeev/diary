import 'package:diary/screens/bottom_navigation_bar_screen.dart';
import 'package:diary/screens/entries_screen.dart';
import 'package:diary/screens/favourites_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromRGBO(252, 156, 84, 1),
          ),
          child: Text(
            'welcome',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        ListTile(
          title: const Text('Show Favorites'),
          onTap: () {
            Navigator.popAndPushNamed(context, FavouritesScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('All Entries'),
          onTap: () {
            Navigator.popAndPushNamed(context, EntryScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
      ],
    );
  }
}
