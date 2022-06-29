import 'package:diary/widgets/journal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/journal_info.dart';
import '../widgets/app_drawer.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({Key? key}) : super(key: key);

  static const String routeName = '/entryScreen';

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  var _isInit = true;
  var isLoading = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<JournalInfo>(context)
          .fetchEntries()
          .then((value) => changeLoadingStatus());
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void changeLoadingStatus() {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final journalList = Provider.of<JournalInfo>(context, listen: false);
    return (journalList.entries.isEmpty && isLoading == false)
        ? Scaffold(
            drawer: const Drawer(
              backgroundColor: Color.fromRGBO(250, 214, 165, 1),
              child: AppDrawer(),
            ),
            backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
              title: const Text(
                'Your Entries',
                style: TextStyle(
                  color: Color.fromRGBO(71, 28, 28, 1),
                ),
              ),
            ),
            body: const Center(
                child: Text(
              'Add Your entries',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
            )),
          )
        : isLoading
            ? const Scaffold(
                backgroundColor: Color.fromRGBO(250, 214, 165, 1),
                body: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(71, 28, 28, 1),
                  ),
                )),
              )
            : Scaffold(
                drawer: const Drawer(
                  backgroundColor: Color.fromRGBO(250, 214, 165, 1),
                  child: AppDrawer(),
                ),
                backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
                  title: const Text(
                    'Your Entries',
                    style: TextStyle(
                      color: Color.fromRGBO(71, 28, 28, 1),
                    ),
                  ),
                ),
                body: ListView.builder(
                    itemCount: journalList.entries.length,
                    itemBuilder: (_, int index) => Column(
                          children: [
                            JournalListItem(
                              date: journalList.entries[index].date,
                              mood: journalList.entries[index].mood,
                              description:
                                  journalList.entries[index].description,
                              favStatus: journalList.entries[index].isFavorite,
                              imageUrl: journalList.entries[index].imageUrl,
                              id: journalList.entries[index].id, 
                              imagePath_: journalList.entries[index].deviceImagePath,
                            )
                          ],
                        )));
  }
}
