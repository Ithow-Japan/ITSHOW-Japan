import 'package:flutter/material.dart';
import 'package:harugo/models/quiz_model.dart';
import 'package:harugo/Service/quiz_service.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/QuizBlockWidget.dart';
import '../Service/cookie_service.dart';
import "../screens/quizresult.dart";

class QuizScreen extends StatefulWidget {
  final int categoryId;
  const QuizScreen({super.key, required this.categoryId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<QuizModel>> _quizFuture;
  List<QuizModel> _quizzes = [];
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _quizFuture = QuizService.getQuizListFromLearned(widget.categoryId);
  }

  Future<void> _submitAnswerAndNext() async {
    final currentQuiz = _quizzes[_currentIndex];
    if (_selectedAnswer == null) return;

    bool isCorrect = (_selectedAnswer == currentQuiz.answer);

    bool success =
        await QuizService.submitQuizResult(currentQuiz.id, isCorrect);

    if (success) {
      if (_currentIndex < _quizzes.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _showResult = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QuizResultScreen()),
        );
      }
    } else {
      // 실패 처리 로직 필요시 여기에 작성
      print("결과 저장 실패");
    }
  }

  void _selectAnswer(int selected, int correct) {
    if (_showResult) return;

    setState(() {
      _selectedAnswer = selected;
      _showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizModel>>(
      future: _quizFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
            "퀴즈를 불러올 수 없습니다.",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ));
        }

        if (_quizzes.isEmpty) {
          _quizzes = snapshot.data!;
        }

        final currentQuiz = _quizzes[_currentIndex];
        final rawQuestion = currentQuiz.question;

        final choiceMatch =
            RegExp(r'1\.\s*(.*?)\s*2\.\s*(.*?)\s*3\.\s*(.*?)\s*4\.\s*(.*)')
                .firstMatch(rawQuestion);

        final choices = choiceMatch != null
            ? [
                choiceMatch.group(1)!.trim(),
                choiceMatch.group(2)!.trim(),
                choiceMatch.group(3)!.trim(),
                choiceMatch.group(4)!.trim(),
              ]
            : [];

        final questionText = rawQuestion.split(RegExp(r'1\.')).first.trim();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("퀴즈"),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffD9D9D9), width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      questionText,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                ...List.generate(choices.length, (index) {
                  final choiceNumber = index + 1;
                  final choiceText = choices[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: QuizBlockWidget(
                      choiceText: "$choiceNumber. $choiceText",
                      isSelected: _selectedAnswer == choiceNumber,
                      isCorrect: currentQuiz.answer == choiceNumber,
                      showResult: _showResult,
                      onTap: () =>
                          _selectAnswer(choiceNumber, currentQuiz.answer),
                    ),
                  );
                }),
                const Spacer(),
                ButtonWidget(
                  "다음 문제",
                  onTap: _showResult ? _submitAnswerAndNext : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
