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
      backgroundColor: Color(0xffFFD7C5),
      body: FutureBuilder(
        future: category,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return CategoryWidget(id: item.id, name: item.name);
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
