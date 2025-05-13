class AttendanceModel {
  final int id, user_id, streak;
  final DateTime date, created_at;

  AttendanceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user_id = json['user_id'],
        streak = json['streak'],
        date = json['date'],
        created_at = json['created_at'];
}
