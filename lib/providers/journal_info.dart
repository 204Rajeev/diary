import 'package:flutter/cupertino.dart';

class JournalInfo with ChangeNotifier {
  JournalInfo(this.url, this.mood);
  final String url;
  final String mood;

  String showImage() {
    return url;
  }

  String showMood() {
    return mood;
  }
}
