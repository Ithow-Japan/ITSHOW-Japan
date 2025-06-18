import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/attendance_model.dart';
import "../Service/cookie_service.dart";

class AttendanceService {
  static Future<List<AttendanceModel>> getAttendance() async {
    final ApiClient apiClient = ApiClient();
    List<AttendanceModel> attendanceInstances = [];

    try {
      final response = await apiClient.dio.get('/records');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;
        final List<dynamic> attendance = json['data'];

        for (var item in attendance) {
          attendanceInstances.add(AttendanceModel.fromJson(item));
        }
        return attendanceInstances;
      } else {
        print("서버 응답 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("출석 API 호출 중 오류 발생: $e");
      return [];
    }
  }
}
