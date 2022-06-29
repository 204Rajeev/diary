import 'package:diary/screens/display_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/journal_info.dart';

// ignore: must_be_immutable
class JournalListItem extends StatelessWidget {
  JournalListItem({
    Key? key,
    required this.date,
    required this.mood,
    required this.description,
    required this.favStatus,
    required this.imageUrl,
    required this.id, required this.imagePath_,
  }) : super(key: key);

  final DateTime date;
  final String mood;
  final String description;
  bool favStatus;
  final String imageUrl;
  final String id;
  final String imagePath_;

  int showFirst2WordsLength() {
    int spaceCount = 0, i;
    for (i = 0; i < description.length; i++) {
      if (description[i] == ' ') {
        spaceCount++;
      }
      if (spaceCount == 2) {
        break;
      }
    }

    return i;
  }

  @override
  Widget build(BuildContext context) {
    final journal = Provider.of<JournalInfo>(context);
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DisplayScreen(
                    date: date,
                    imageUrl: imageUrl,
                    favStatus: favStatus,
                    description: description,
                    mood: mood, imagePath:imagePath_ ,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          color: const Color.fromRGBO(252, 156, 84, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(date) +
                          ',' +
                          DateFormat('EEEE').format(date) +
                          ',' +
                          date.hour.toString() +
                          ':' +
                          date.minute.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 30,
                              width: 90,
                              padding: EdgeInsets.all(1),
                              child: Text(
                                description.substring(
                                        0, showFirst2WordsLength()) +
                                    '...',
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w200),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  width: 80,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        journal.toggleFromEntrieScreen(
                            date.toString(), context);
                      },
                      child: favStatus
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 40,
                            )
                          : const Icon(
                              Icons.favorite_outlined,
                              color: Color.fromRGBO(71, 28, 28, 1),
                              size: 40,
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      const Color.fromRGBO(250, 214, 165, 1),
                                  title: const Text('Delete This Entry?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          journal.deleteEntry(id);
                                          const snackBar = SnackBar(
                                            content: Text('Entry deleted!'),
                                            duration: Duration(
                                                seconds: 1, milliseconds: 500),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    71, 28, 28, 1)))),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancle',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  71, 28, 28, 1)),
                                        ))
                                  ],
                                );
                              });
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Color.fromRGBO(71, 28, 28, 1),
                          size: 40,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
