import 'package:intl/intl.dart';
import 'dart:io';
import '../providers/journal_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class AddJournal extends StatefulWidget {
  static const routeName = '/AddJournal';

  AddJournal({Key? key}) : super(key: key);

  @override
  State<AddJournal> createState() => _AddJournalState();
}

class _AddJournalState extends State<AddJournal> {
  final journalEntry = TextEditingController();
  final now = DateTime.now();
  var isLoading = false;
  late PickedFile _deviceImage;
  late File savedImage;
  bool tookpictures = false;

  Future<void> _takepictures() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.camera);

    if (imageFile == null) {
      return; 
    }
    setState(() {
      _deviceImage = imageFile;
      tookpictures = true;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);

    savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
  }

  @override
  void dispose() {
    journalEntry.dispose();
    super.dispose();
  }

  bool favouriteStatus = false;

  void toggleFavourite(BuildContext ctx) {
    favouriteStatus = !favouriteStatus;

    if (favouriteStatus == true) {
      const snackBar = SnackBar(
        content: Text('Added to favorites!'),
        duration: Duration(seconds: 1, milliseconds: 500),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<JournalInfo>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(252, 156, 84, 1),
        title: const Text(
          'Journal',
          style: TextStyle(color: Color.fromRGBO(71, 28, 28, 1)),
        ),
      ),
      backgroundColor: const Color.fromRGBO(250, 214, 165, 1),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(71, 28, 28, 1),
              ),
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            info.displayImage(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(now) +
                                  ',' +
                                  DateFormat('EEEE').format(now),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'I feel ' + info.displayMood() + '!',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w200, fontSize: 27),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggleFavourite(context);
                            });
                          },
                          child: favouriteStatus
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 40,
                                )
                              : const Icon(
                                  Icons.favorite_outlined,
                                  color: Color.fromRGBO(71, 28, 28, 1),
                                  size: 40,
                                ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                        child: SizedBox(
                      height: 500,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          textSelectionHandleColor:
                              const Color.fromRGBO(252, 156, 84, 1),
                        ),
                        child: TextField(
                          cursorColor: const Color.fromRGBO(71, 28, 28, 1),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type Your answer here',
                          ),
                          controller: journalEntry,
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          heroTag: "btn1",
                          elevation: 0,
                          backgroundColor:
                              const Color.fromRGBO(252, 156, 84, 1),
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });

                            info
                                .addEntry(
                              journalEntry.text,
                              info.displayImage(),
                              info.displayMood(),
                              favouriteStatus,
                              now,
                              savedImage,
                              tookpictures,
                            )
                                .then((_) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushNamed(context, '/');
                            });
                          },
                          tooltip: 'Submit your journal',
                          child: const Icon(
                            Icons.check,
                            color: Color.fromRGBO(250, 214, 165, 1),
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: "btn2",
                          elevation: 0,
                          backgroundColor:
                              const Color.fromRGBO(252, 156, 84, 1),
                          onPressed: _takepictures,
                          tooltip: 'Submit your journal',
                          child: const Icon(
                            Icons.camera_alt,
                            color: Color.fromRGBO(250, 214, 165, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 0.1,
                    color: Color.fromRGBO(71, 28, 28, 1),
                  ),
                  tookpictures == false
                      ? GestureDetector(
                          onTap: _takepictures,
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                            child: Image.asset('assets/images/add.png',
                                fit: BoxFit.fitHeight),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(20),
                          height: 300,
                          width: 300,
                          child: Image.file(
                            File(_deviceImage.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                ],
              ),
            ),
    );
  }
}
