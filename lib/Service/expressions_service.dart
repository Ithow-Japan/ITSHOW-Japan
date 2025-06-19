import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:harugo/models/expressions_model.dart';
import 'package:harugo/Service/cookie_service.dart';

class ExpressionsService {
  // ApiClient 인스턴스 가져오기
  static final ApiClient _apiClient = ApiClient();

  // 특정 카테고리 표현 가져오기
  static Future<List<ExpressionsModel>> getExpressions(int id) async {
    List<ExpressionsModel> expressionInstances = [];
    try {
      final response = await _apiClient.dio.get('/expressions/$id');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        final List<dynamic> expressionList = json['data'];

        for (var item in expressionList) {
          expressionInstances.add(ExpressionsModel.fromJson(item));
        }
        return expressionInstances;
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("표현 API 호출 중 오류 발생: $e");
      return [];
    }
  }

  // 표현 학습 완료 처리
  static Future<bool> completeExpression(int id) async {
    try {
      await _apiClient.printCookies();

      final response = await _apiClient.dio.post(
        '/expressions/complete/$id',
        data: {},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("학습완료 POST 성공: ${response.statusCode}");
        print("응답 데이터: ${response.data}");
        return true;
      } else {
        print("서버 응답 오류(POST): ${response.statusCode}");
        print("응답 내용: ${response.data}");
        return false;
      }
    } catch (e) {
      print("POST 호출 중 오류 발생: $e");
      if (e is DioException) {
        print("Dio 오류 상세: ${e.response?.statusCode} - ${e.response?.data}");
      }
      return false;
    }
  }

  // 학습된 표현 불러오기
  static Future<List<ExpressionsModel>> getLearnedExpressions(
      int categoryId) async {
    List<ExpressionsModel> learnedExpressions = [];
    try {
      final response =
          await _apiClient.dio.get('/expressions/learned/$categoryId');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        final List<dynamic> expressionList = json['data'];

        for (var item in expressionList) {
          learnedExpressions.add(ExpressionsModel.fromJson(item));
        }
        return learnedExpressions;
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("학습 표현 조회 중 오류 발생: $e");
      return [];
    }
  }
}
