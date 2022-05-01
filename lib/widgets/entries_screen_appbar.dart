import 'package:flutter/material.dart';

class EntriesScreenAppBar extends StatelessWidget {
  const EntriesScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your Entries',
      style: TextStyle(
        color: const Color.fromRGBO(71, 28, 28, 1),
      ),
    );
  }
}
