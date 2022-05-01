import 'package:diary/models/arg.dart';
import '../providers/journal_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddJournal extends StatelessWidget {
  static const routeName = '/AddJournal';

  AddJournal();

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final info = Provider.of<JournalInfo>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  info.showImage(),
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Text(
                    DateTime.now().toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'I feel ' + info.showMood() + '!',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              )
            ],
          ),
          const TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Type Your answer here',
            ),
          )
        ],
      ),
    );
  }
}
