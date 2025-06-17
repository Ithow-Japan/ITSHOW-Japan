class CategoryModel {
  final int id;
  final String name, image_path;
  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image_path = json['image_path'];
}
