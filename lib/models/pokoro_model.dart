class PokoroModel {
  final int level_required;
  final String pokoro_name, image;
  PokoroModel.fromJson(Map<String, dynamic> json)
      : pokoro_name = json['pokoro_name'],
        level_required = json['level_required'],
        image = json['image'];
}
