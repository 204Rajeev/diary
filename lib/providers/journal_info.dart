import 'package:diary/models/diary_entry.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class JournalInfo with ChangeNotifier {
  final List<DiaryEntry> _entries = [];
  final List<DiaryEntry> _favEntries = [];

  List<DiaryEntry> get entries {
    return _entries;
  }

  List<DiaryEntry> get favEntries {
    return _favEntries;
  }

  void addEntry(String id, String description, String imageUrl, String mood,
      bool favStatus, DateTime date) {
    _entries.add(DiaryEntry(id, mood, description, imageUrl, favStatus, date));
    addFavEntry(id);
    notifyListeners();
  }

  displayImage() {
    return imageUrl;
  }

  displayMood() {
    return moodStatus;
  }

  void addFavEntry(String id) {
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].isFavorite == true &&
          _favEntries.contains(_entries[i]) == false) {
        _favEntries.add(_entries[i]);
      }
    }
    notifyListeners();
  }

  bool favouriteStatus = false;

  void toggleFavourite(BuildContext ctx, String id) {
    favouriteStatus = !favouriteStatus;
    if (favouriteStatus == true) {
      const snackBar = SnackBar(
        content: Text('Added to favorites!'),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
    addFavEntry(id);
    notifyListeners();
  }

  void deleteEntry(
    String entryId,
  ) {
    int c = 0;
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].id == entryId) {
        _entries.removeAt(i);
        c = 1;
      }
    }
    if (c == 0) {
      return;
    }
    notifyListeners();
  }

  void toggleFromEntrieScreen(String id) {
    int c = 0;
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].id == id) {
        _entries[i].isFavorite = !_entries[i].isFavorite;
        c = 1;
      }
    }
    if (c == 0) {
      return;
    }
    addFavEntry(id);
    notifyListeners();
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
