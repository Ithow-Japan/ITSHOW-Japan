import 'package:flutter/material.dart';
import 'package:harugo/Service/category_service.dart';
import 'package:harugo/models/category_model.dart';
import 'package:harugo/screens/categoryScreen.dart';
import 'package:harugo/widgets/homecategoryWidget.dart';
import 'package:harugo/widgets/AttendanceWidget.dart'; // AttendanceWidget 추가

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final Future<List<CategoryModel>> category = CategoryService.getCategory();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CategoryScreen()));
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          // 전체 스크롤 가능하게 감쌈
          child: Column(
            children: [
              // 카테고리 데이터 표시
              FutureBuilder(
                future: category,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200, // 카테고리 위젯 크기 설정
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return HomeCategoryWidget(
                              id: item.id, name: item.name);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 20,
                        ),
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              SizedBox(height: 20), // 카테고리와 출석체크 사이 간격

            ],
          ),
        ),
      ),
    );
  }
}
