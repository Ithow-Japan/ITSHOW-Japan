class AttendanceModel {
  final int id, user_id, streak;
  final DateTime date;
  final String created_at; // String으로 변경

  AttendanceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user_id = json['user_id'],
        streak = json['streak'],
        date = DateTime.parse(json['date']), // date만 DateTime 변환
        created_at = json['created_at']; // created_at은 String 유지
}
