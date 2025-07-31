// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'MainMenu.dart';

int finalScore = 0;
int questionNumber = 0;
final quiz = CocokKata();

class CocokKata {
  final List<String> question = [
    "The dog barks",
    "I ate a sandwich",
    "The baby cried",
    "Tomy rides his bike",
    "I hear the rain"
  ];

  final List<String> corrAnswer = [
    "The dog barks ",
    "I ate a sandwich ",
    "The baby cried ",
    "Tomy rides his bike ",
    "I hear the rain "
  ];
}

class MalingCocok extends StatefulWidget {
  const MalingCocok({Key? key}) : super(key: key);

  @override
  State<MalingCocok> createState() => _MalingCocokState();
}

class _MalingCocokState extends State<MalingCocok> {
  final TextEditingController txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String question = quiz.question[questionNumber];
    List<String> words = List.from(question.split(' '))..shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cocok Kata"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Susunlah kata-kata di bawah sesuai dengan tata bahasa yang benar!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Container(
                width: 350,
                child: TextFormField(
                  controller: txt,
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your answer will be displayed here',
                  ),
                ),
              ),
              SizedBox(height: 30),
              ...words.map((word) => Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          minimumSize: Size(200, 50),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            txt.text += '$word ';
                          });
                        },
                        child: Text(
                          word,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => setState(() => txt.clear()),
                child: Text('Reset'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(200, 50),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  String userAnswer = txt.text;
                  bool isCorrect = userAnswer == quiz.corrAnswer[questionNumber];

                  if (isCorrect) finalScore++;

                  debugPrint(isCorrect ? "Correct" : "Wrong");
                  debugPrint("Expected: ${quiz.corrAnswer[questionNumber]}");
                  debugPrint("User: $userAnswer");

                  txt.clear();
                  updateQuestion();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Score : $finalScore",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[700],
    );
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.question.length - 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Summary(score: finalScore)),
        );
      } else {
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget {
  final int score;

  const Summary({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cocok Kata"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              score >= 3 ? 'assets/good.png' : 'assets/sad.png',
              height: score >= 3 ? 145 : 250,
            ),
            SizedBox(height: 20),
            Text(
              score >= 3 ? "Good Job" : "Nice try",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: score >= 3 ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Final Score: $score",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: Size(300, 50),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                questionNumber = 0;
                finalScore = 0;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainMenu()),
                );
              },
              child: Text(
                "Back to Main Menu",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[700],
    );
  }
}
