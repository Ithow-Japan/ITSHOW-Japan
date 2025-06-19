import 'package:harugo/models/quiz_model.dart';
import 'package:harugo/Service/expressions_service.dart';
import 'package:harugo/Service/cookie_service.dart';

class QuizService {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<QuizModel>> getQuizListFromLearned(
      List<int> categoryIds) async {
    List<QuizModel> quizzes = [];

    try {
      for (int categoryId in categoryIds) {
        final learned =
            await ExpressionsService.getLearnedExpressions(categoryId);

        for (final expression in learned) {
          try {
            final response = await _apiClient.dio.get('/quiz/${expression.id}');
            if (response.statusCode == 200) {
              final quizJsonRaw = response.data['quiz'];
              if (quizJsonRaw != null &&
                  quizJsonRaw is List &&
                  quizJsonRaw.isNotEmpty) {
                for (var quizJson in quizJsonRaw) {
                  final quiz = QuizModel.fromJson(quizJson);
                  quizzes.add(quiz);
                }
              }
            }
          } catch (e) {
            print("퀴즈 ID ${expression.id} 호출 실패: $e");
          }
        }
      }
      Future<List<QuizModel>> getQuizListFromLearned(
          List<int> categoryIds) async {
        List<QuizModel> quizzes = [];

        print("categoryIds: $categoryIds"); // 카테고리 ID 리스트 확인

        try {
          for (int categoryId in categoryIds) {
            print("Fetching learned expressions for categoryId: $categoryId");
            final learned =
                await ExpressionsService.getLearnedExpressions(categoryId);
            print(
                "Category $categoryId has ${learned.length} learned expressions.");

            for (final expression in learned) {
              print("Fetching quizzes for expressionId: ${expression.id}");
              try {
                final response =
                    await _apiClient.dio.get('/quiz/${expression.id}');
                if (response.statusCode == 200) {
                  final quizJsonRaw = response.data['quiz'];
                  print(
                      "Expression ${expression.id} returned ${quizJsonRaw?.length ?? 0} quizzes");
                  if (quizJsonRaw != null &&
                      quizJsonRaw is List &&
                      quizJsonRaw.isNotEmpty) {
                    for (var quizJson in quizJsonRaw) {
                      final quiz = QuizModel.fromJson(quizJson);
                      quizzes.add(quiz);
                    }
                  }
                }
              } catch (e) {
                print("퀴즈 ID ${expression.id} 호출 실패: $e");
              }
            }
          }

          print("총 퀴즈 개수: ${quizzes.length}");
          return quizzes;
        } catch (e) {
          print("퀴즈 불러오기 실패: $e");
          return [];
        }
      }

      return quizzes;
    } catch (e) {
      print("퀴즈 불러오기 실패: $e");
      return [];
    }
  }

  /// 문제 정답 제출 및 완료 처리
  static Future<bool> submitQuizResult(int quizId, bool isCorrect) async {
    try {
      final response = await _apiClient.dio.post('/quiz/$quizId/result', data: {
        "completed": isCorrect ? 1 : 0,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("퀴즈 결과 저장 성공: ${response.statusCode}");
        return true;
      } else {
        print("퀴즈 결과 저장 실패: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("퀴즈 결과 저장 중 오류 발생: $e");
      return false;
    }
  }

  static Future<bool> checkQuizAnswer(int quizId, int answerIndex) async {
    try {
      final response = await _apiClient.dio.post(
        '/quiz/$quizId/answer',
        data: {
          "selectedOption": answerIndex + 1, // 예: 0, 1, 2, 3 중 하나
        },
      );

      if (response.statusCode == 200) {
        return response.data['correct'] ?? false;
      } else {
        print("정답 확인 실패: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("정답 확인 중 오류 발생: $e");
      return false;
    }
  }
}
