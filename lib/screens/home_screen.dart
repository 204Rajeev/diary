import 'package:diary/models/arg.dart';
import 'package:flutter/material.dart';

import '../widgets/mood_slider.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                              onPressed: () => moodSelector(context)),
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
    );
  }
}

class MoodSlider extends StatefulWidget {
  MoodSlider({Key? key}) : super(key: key);

  @override
  State<MoodSlider> createState() => _MoodSliderState();
}

class _MoodSliderState extends State<MoodSlider> {
  double _value = 10;

  final String _great = 'assets/images/greatMood.png';

  final String _good = 'assets/images/goodMood.png';

  final String _okayish = 'assets/images/okayishMood.png';

  final String _bad = 'assets/images/badMood.png';

  final String _terible = 'assets/images/teribleMood.png';

  String imageUrl = 'assets/images/greatMood.png';

  String moodStatus = 'Great';

  String showImage() {
    return imageUrl;
  }

  String showMood() {
    return moodStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: 250,
          padding: const EdgeInsets.all(10),
          child: Image.asset(imageUrl, fit: BoxFit.fitHeight),
        ),
        Expanded(
          child: Slider(
            value: _value,
            min: 0,
            max: 50,
            divisions: 5,
            activeColor: const Color.fromRGBO(71, 28, 28, 1),
            label: _value.toString(),
            onChanged: (double newVal) {
              setState(() {
                _value = newVal;
                if (_value == 10) {
                  imageUrl = _great;
                  moodStatus = 'Great';
                } else if (_value == 20) {
                  imageUrl = _good;
                  moodStatus = 'Good';
                } else if (_value == 30) {
                  moodStatus = 'Okayish';
                  imageUrl = _okayish;
                } else if (_value == 40) {
                  imageUrl = _bad;
                  moodStatus = 'Bad';
                } else if (_value == 50) {
                  imageUrl = _terible;
                  moodStatus = 'Terible';
                }
              });
              //JournalInfo(imageUrl, moodStatus);
            },
          ),
        ),
        Text(
          moodStatus,
          style: const TextStyle(
              color: Color.fromRGBO(71, 28, 28, 1),
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
