import 'package:flutter/material.dart';
import 'package:harugo/Service/category_service.dart';
import 'package:harugo/models/category_model.dart';
import 'package:harugo/widgets/categoryWidget.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final Future<List<CategoryModel>> category = CategoryService.getCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "HARUGO",
          style: TextStyle(
            fontSize: 26,
            color: Color(0x00ff6700),
          ),
        ),
      ),
      body: FutureBuilder(
        future: category,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return CategoryWidget(id: item.id, name: item.name);
                },
                separatorBuilder: (context, index) => SizedBox(
                      width: 20,
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
