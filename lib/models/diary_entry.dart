import 'package:flutter/foundation.dart';
import 'dart:io';

class DiaryEntry {
  String id;
  String mood;
  String imageUrl;
  String description;
  bool isFavorite = false;
  String deviceImagePath;
  DateTime date;

  DiaryEntry(this.id, this.mood, this.description, this.imageUrl,
      this.isFavorite, this.date, this.deviceImagePath);
}
