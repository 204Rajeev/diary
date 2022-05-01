import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromRGBO(252, 156, 84, 1),
          ),
          child: Text('welcome'),
        ),
        ListTile(
          title: const Text('Show Favorites'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          title: const Text('All Entries'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          title: const Text('Home'),
          onTap: () {},
        ),
      ],
    );
  }
}
