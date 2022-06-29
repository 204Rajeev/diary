import 'package:diary/models/diary_entry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/home_screen.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../helpers/db_helper.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class JournalInfo with ChangeNotifier {
  List<DiaryEntry> _entries = [];

  List<DiaryEntry> get entries {
    return _entries;
  }

  List<DiaryEntry> get favEntries {
    return _entries.where((entryItem) => entryItem.isFavorite).toList();
  }

  Future<void> fetchEntries() async {
    final url = Uri.https(
        'mydiary2-c828e-default-rtdb.firebaseio.com', '/Entries.json');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List<DiaryEntry> loadedEntries = [];
      extractedData.forEach((entryId, entryData) {
        loadedEntries.add(DiaryEntry(
          entryId,
          entryData['mood'],
          entryData['description'],
          entryData['imageUrl'],
          entryData['isFavourite'],
          DateTime.parse(entryData['title']),
          entryData['deviceImagePath'],
        ));
      });
      _entries = loadedEntries;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');

  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  //   return file;
  // }

  Future<void> addEntry(String description, String imageUrl, String mood,
      bool favStatus, DateTime date, File pickedImage, bool didPickImage) {
    if (didPickImage == false) {}
    final url = Uri.https(
        'mydiary2-c828e-default-rtdb.firebaseio.com', '/Entries.json');
    return http
        .post(url,
            body: jsonEncode({
              'title': date.toString(),
              'description': description,
              'imageUrl': imageUrl,
              'mood': mood,
              'isFavourite': favStatus,
              'deviceImagePath': pickedImage.path
            }))
        .then((response) {
      _entries.add(DiaryEntry(jsonDecode(response.body)['name'], mood,
          description, imageUrl, favStatus, date, pickedImage.path));

      notifyListeners();
      //DBHelper.insert('entry', {'id':});
      return Future.value();
    });
  }

  displayImage() {
    return imageUrl;
  }

  displayMood() {
    return moodStatus;
  }

  Future<void> deleteEntry(
    String entryId,
  ) async {
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].id == entryId) {
        var existingEntry = _entries[i];
        final url = Uri.https('mydiary2-c828e-default-rtdb.firebaseio.com',
            '/Entries/$entryId.json');
        _entries.removeAt(i);
        notifyListeners();
        try {
          final response = await http.delete(url);
          if (response.statusCode >= 400) {
            _entries.insert(i, existingEntry);
            notifyListeners();
          } else {
            const snackBar = SnackBar(
              content: Text('Entry deleted!'),
              duration: Duration(seconds: 1, milliseconds: 500),
            );
          }
        } catch (error) {
          throw error;
        }
      }
    }

    notifyListeners();
  }

  Future<void> toggleFromEntrieScreen(String title, BuildContext ctx) async {
    for (int i = 0; i < _entries.length; i++) {
      if (_entries[i].date.toString() == title) {
        _entries[i].isFavorite = !_entries[i].isFavorite;
        notifyListeners();
        final url = Uri.https('mydiary2-c828e-default-rtdb.firebaseio.com',
            '/Entries/${entries[i].id}.json');
        await http.patch(url,
            body: json.encode({
              'isFavourite': _entries[i].isFavorite,
            }));
        notifyListeners();
        if (_entries[i].isFavorite == true) {
          const snackBar = SnackBar(
            content: Text('Added to favorites!'),
            duration: Duration(seconds: 1, milliseconds: 500),
          );

          ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
        }
      }
    }

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
