import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class DisplayScreen extends StatelessWidget {
  static const routeName = '/displayScreen';
  const DisplayScreen(
      {Key? key,
      required this.date,
      required this.imageUrl,
      required this.favStatus,
      required this.description,
      required this.mood,
      required this.imagePath})
      : super(key: key);

  final DateTime date;
  final String imageUrl;
  final bool favStatus;
  final String description;
  final String mood;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
        elevation: 0,
        title: Text(
          DateFormat.yMMMMd().format(date) +
              ',' +
              DateFormat('EEEE').format(date) +
              ',' +
              date.hour.toString() +
              ':' +
              date.minute.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color.fromRGBO(71, 28, 28, 1),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      mood,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  width: 180,
                ),
                favStatus
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 60,
                      )
                    : const Icon(
                        Icons.favorite_outlined,
                        color: Color.fromRGBO(71, 28, 28, 1),
                        size: 60,
                      ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 300,
              width: double.infinity,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 0.1,
              color: Color.fromRGBO(71, 28, 28, 1),
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                description,
                style:
                    const TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
