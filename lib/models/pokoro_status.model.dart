class PokoroStatusModel {
  final int level, gage;
  PokoroStatusModel.fromJson(Map<String, dynamic> json)
      : level = json['level'],
        gage = json['gage'];
}
