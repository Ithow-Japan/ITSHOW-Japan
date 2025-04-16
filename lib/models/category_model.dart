class CategoryModel {
  final int id;
  final String name, image_path;
  final int achievement;

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image_path = json['image_path'],
        achievement = json['achievement'];
}
