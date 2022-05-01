import 'package:flutter/material.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key? key}) : super(key: key);

  static const String routeName = '/entryScreen';

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('List of entries'));
  }
}
