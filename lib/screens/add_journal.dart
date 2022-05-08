import 'package:intl/intl.dart';

import '../providers/journal_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddJournal extends StatefulWidget {
  static const routeName = '/AddJournal';

  AddJournal({Key? key}) : super(key: key);

  @override
  State<AddJournal> createState() => _AddJournalState();
}

class _AddJournalState extends State<AddJournal> {
  final journalEntry = TextEditingController();
  final now = DateTime.now();

  @override
  void dispose() {
    journalEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<JournalInfo>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
        title: const Text(
          'Journal',
          style: TextStyle(color: Color.fromRGBO(71, 28, 28, 1)),
        ),
      ),
      backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      info.displayImage(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(now) +
                            ',' +
                            DateFormat('EEEE').format(now),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'I feel ' + info.displayMood() + '!',
                        style: const TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 27),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      info.toggleFavourite(context, now.toString());
                    },
                    child: info.favouriteStatus
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 40,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            color: Color.fromRGBO(71, 28, 28, 1),
                            size: 40,
                          ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                  child: SizedBox(
                height: 500,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    // ignore: deprecated_member_use
                    textSelectionHandleColor:
                        const Color.fromRGBO(252, 156, 84, 1),
                  ),
                  child: TextField(
                    cursorColor: const Color.fromRGBO(71, 28, 28, 1),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Your answer here',
                    ),
                    controller: journalEntry,
                  ),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
                    onPressed: () {
                      info.addEntry(
                          now.toString(),
                          journalEntry.text,
                          info.displayImage(),
                          info.displayMood(),
                          info.favouriteStatus,
                          now);

                      Navigator.pushNamed(context, '/');
                    },
                    tooltip: 'Submit your journal',
                    child: const Icon(
                      Icons.check,
                      color: Color.fromRGBO(250, 214, 165, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
