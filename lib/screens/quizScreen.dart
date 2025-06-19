import 'package:flutter/material.dart';
import 'package:harugo/models/quiz_model.dart';
import 'package:harugo/Service/quiz_service.dart';
import 'package:harugo/widgets/ButtonWidget.dart';
import 'package:harugo/widgets/QuizBlockWidget.dart';
import "../screens/quizresult.dart";

class QuizScreen extends StatefulWidget {
  final List<int> categoryIds; // 단일 int에서 List<int>로 변경
  const QuizScreen({super.key, required this.categoryIds});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<QuizModel>> _quizFuture;
  List<QuizModel> _quizzes = [];
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _showResult = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    // 여러 카테고리 ID를 전달
    _quizFuture = QuizService.getQuizListFromLearned(widget.categoryIds);
  }

  Future<void> _submitAnswerAndNext() async {
    if (_selectedAnswer == null) return;

    final currentQuiz = _quizzes[_currentIndex];

    bool success =
        await QuizService.submitQuizResult(currentQuiz.id, _isCorrect);

    if (success) {
      if (_currentIndex < _quizzes.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _showResult = false;
          _isCorrect = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QuizResultScreen()),
        );
      }
    } else {
      print("결과 저장 실패");
    }
  }

  void _selectAnswer(int selected) async {
    if (_showResult) return;

    final currentQuiz = _quizzes[_currentIndex];

    setState(() {
      _selectedAnswer = selected;
    });

    // 서버에 정답 확인 요청
    bool isCorrect =
        await QuizService.checkQuizAnswer(currentQuiz.id, selected - 1);

    setState(() {
      _showResult = true;
      _isCorrect = isCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizModel>>(
      future: _quizFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("퀴즈"),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("퀴즈"),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: const Center(
              child: Text(
                "퀴즈를 불러올 수 없습니다.",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ),
          );
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
            title: Text(
                "퀴즈 (${_currentIndex + 1}/${_quizzes.length})"), // 진행 상황 표시
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              children: [
                // 카테고리 정보 표시 (선택사항)
                if (widget.categoryIds.length > 1)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Text(
                      "카테고리 ${widget.categoryIds.length}개에서 선별된 퀴즈",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                      isCorrect: _isCorrect && _selectedAnswer == choiceNumber,
                      showResult: _showResult,
                      onTap: () => _selectAnswer(choiceNumber),
                    ),
                  );
                }),
                const Spacer(),
                ButtonWidget(
                  _currentIndex == _quizzes.length - 1 ? "결과 보기" : "다음 문제",
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
