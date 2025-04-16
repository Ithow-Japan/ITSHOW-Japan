import 'package:flutter/material.dart';
import 'package:harugo/Service/category_service.dart';
import 'package:harugo/widgets/categoryWidget.dart';
import 'package:harugo/models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final Future<List<CategoryModel>> category = CategoryService.getCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xfffff6f3),
        title: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            "HARUGO",
            style: TextStyle(
              fontSize: 26,
              color: Color(0xffFF6700),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xfffff6f3),
      body: FutureBuilder(
        future: category,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return CategoryWidget(
                      id: item.id,
                      name: item.name,
                      image_path: item.image_path,
                      achievement: item.achievement,);
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: snapshot.data!.length);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
