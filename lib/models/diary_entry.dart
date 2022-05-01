import 'package:flutter/foundation.dart';

class DiaryEntry {
  String id;
  String title;
  String mood;
  String imageUrl;
  String description;
  bool isFavorite = false;

  DiaryEntry(this.id, this.title, this.mood, this.description, this.imageUrl);
}
