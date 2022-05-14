import 'package:flutter/material.dart';
import 'dart:math';

class RandomQuotes extends StatelessWidget {
  RandomQuotes({
    Key? key,
  }) : super(key: key);

  final Quotes = [
    'The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela',
    'The way to get started is to quit talking and begin doing. -Walt Disney',
    'If life were predictable it would cease to be life, and be without flavor. -Eleanor Roosevelt',
    'If you look at what you have in life, you\'ll always have more. If you look at what you don\'t have in life, you\'ll never have enough. -Oprah Winfrey',
    'Your time is limited, so don\'t waste it living someone else\'s life. Don\'t be trapped by dogma which is living with the results of other people\'s thinking. -Steve Jobs',
    'Spread love everywhere you go. Let no one ever come to you without leaving happier. -Mother Teresa',
    'When you reach the end of your rope, tie a knot in it and hang on. -Franklin D. Roosevelt',
    'Always remember that you are absolutely unique. Just like everyone else. -Margaret Mead',
    'Don\'t judge each day by the harvest you reap but by the seeds that you plant. -Robert Louis Stevenson',
    'The future belongs to those who believe in the beauty of their dreams. -Eleanor Roosevelt',
    'Tell me and I forget. Teach me and I remember. Involve me and I learn. -Benjamin Franklin',
    'The best and most beautiful things in the world cannot be seen or even touched — they must be felt with the heart. -Helen Keller',
    'It is during our darkest moments that we must focus to see the light. -Aristotle',
    'Whoever is happy will make others happy too. -Anne Frank',
    'Do not go where the path may lead, go instead where there is no path and leave a trail. -Ralph Waldo Emerson',
    ' "I would rather die of passion than of boredom." -Vincent van Gogh',
    '"If you look at what you have in life, you\'ll always have more. If you look at what you don\'t have in life, you\'ll never have enough." -Oprah Winfrey',
    '"First, have a definite, clear practical ideal; a goal, an objective. Second, have the necessary means to achieve your ends; wisdom, money, materials, and methods. Third, adjust all your means to that end." -Aristotle',
    '"Whatever the mind of man can conceive and believe, it can achieve." -Napoleon Hill',
    '"I attribute my success to this: I never gave or took any excuse." -Florence Nightingale',
    '"If you\'re offered a seat on a rocket ship, don\'t ask what seat! Just get on." -Sheryl Sandberg',
    '"I didn\'t fail the test. I just found 100 ways to do it wrong." -Benjamin Franklin',
    '"Too many of us are not living our dreams because we are living our fears." -Les Brown',
    '"I have learned over the years that when one\'s mind is made up, this diminishes fear." -Rosa Parks',
    '"It does not matter how slowly you go as long as you do not stop." -Confucius',
    '"Life is 10% what happens to me and 90% of how I react to it." -Charles Swindoll',
    '"You may be disappointed if you fail, but you are doomed if you don\'t try." -Beverly Sills',
    '"How wonderful it is that nobody need wait a single moment before starting to improve the world." -Anne Frank',
    ' "The only person you are destined to become is the person you decide to be." -Ralph Waldo Emerson',
    '“Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma – which is living with the results of other people’\s thinking.” – Steve Jobs',
    '“Be yourself; everyone else is already taken.” -Oscar Wilde',
    '“Be who you are and say what you feel, because those who mind don\'t matter, and those who matter don\'t mind.”― Bernard M. Baruch',
    '“Live as if you were to die tomorrow. Learn as if you were to live forever.”― Mahatma Gandhi'
  ];
  int randomQuoteSelector() {
    Random random = Random();
    int randomNumber = random.nextInt(Quotes.length);
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      width: double.infinity,
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              Quotes[randomQuoteSelector()],
              style: const TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 20,
                color: Color.fromRGBO(71, 28, 28, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
