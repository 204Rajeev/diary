import 'package:flutter/foundation.dart';

class DiaryEntry {
  String id;
  String mood;
  String imageUrl;
  String description;
  bool isFavorite = false;
  DateTime date;

  DiaryEntry(this.id, this.mood, this.description, this.imageUrl,
      this.isFavorite, this.date);
}
