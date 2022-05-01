import 'package:diary/providers/journal_info.dart';
import 'package:flutter/material.dart';

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

  String imageUrl = 'assets/images/greatMood.png';

  String moodStatus = 'Great';

  String showImage() {
    return imageUrl;
  }

  String showMood() {
    return moodStatus;
  }

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
              JournalInfo(imageUrl, moodStatus);
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
