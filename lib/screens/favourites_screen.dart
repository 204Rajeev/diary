import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/journal_info.dart';
import '../widgets/journal_list_item.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  static const routeName = '/FavouriteScreen';
  @override
  Widget build(BuildContext context) {
    final journalList = Provider.of<JournalInfo>(context);
    return journalList.entries.isEmpty
        // ignore: prefer_const_constructors
        ? Scaffold(
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
                elevation: 0,
                title: const Text(
                  'Your Favourite Entries',
                  style: TextStyle(
                    color: Color.fromRGBO(71, 28, 28, 1),
                  ),
                )),
            backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
            body: const Center(
                child: Text(
              'Add Your Favourite entries',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
            appBar: AppBar(
                backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
                title: const Text(
                  'Your Favourite Entries',
                  style: TextStyle(
                    color: Color.fromRGBO(71, 28, 28, 1),
                  ),
                )),
            body: ListView.builder(
                itemCount: journalList.favEntries.length,
                itemBuilder: (_, int index) => Column(
                      children: [
                        JournalListItem(
                          date: journalList.favEntries[index].date,
                          mood: journalList.favEntries[index].mood,
                          description:
                              journalList.favEntries[index].description,
                          favStatus: journalList.favEntries[index].isFavorite,
                          imageUrl: journalList.favEntries[index].imageUrl,
                        )
                      ],
                    )),
          );
  }
}
