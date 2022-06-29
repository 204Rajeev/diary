import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/random_quotes.dart';
import 'add_journal.dart';
import 'package:diary/providers/journal_info.dart';

String imageUrl = 'assets/images/greatMood.png';
String moodStatus = 'Great';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  moodSelector(
    BuildContext ctx,
  ) {
    setState(() {
      showDialog<String>(
        barrierDismissible: true,
        context: ctx,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
          title: const Text(
            'select a mood',
            style: TextStyle(
              color: Color.fromRGBO(71, 28, 28, 1),
            ),
          ),
          content: MoodSlider(),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AddJournal.routeName,
                );
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Color.fromRGBO(71, 28, 28, 1),
                ),
              ),
            ),
          ],
        ),
      );
    });
    imageUrl = 'assets/images/greatMood.png';
    moodStatus = 'Great';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Color.fromRGBO(250, 214, 165, 1),
        child: AppDrawer(),
      ),
      backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Image.asset('assets/images/diaryLogo2.png', fit: BoxFit.cover),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(children: [
                    Container(
                      height: 300,
                      padding: const EdgeInsets.all(1),
                      child: Image.asset('assets/images/image1.jpg',
                          fit: BoxFit.fitHeight),
                    ),
                    Positioned(
                      top: 20,
                      left: 10,
                      child: GestureDetector(
                        onTap: () => moodSelector(context),
                        child: SizedBox(
                          width: 250,
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Color.fromRGBO(71, 28, 28, 1),
                                    ),
                                    onPressed: () {
                                      moodSelector(context);
                                    }),
                                const Text(
                                  'Dear Diary...',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(71, 28, 28, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Quotes',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w100,
                    color: Color.fromRGBO(71, 28, 28, 1),
                  ),
                ),
              ],
            ),
            RandomQuotes(),
          ],
        ),
      ),
    );
  }
}
