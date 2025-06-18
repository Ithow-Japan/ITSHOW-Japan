import 'package:flutter/material.dart';
import 'package:harugo/Service/category_service.dart';
import 'package:harugo/models/category_model.dart';
import 'package:harugo/screens/categoryScreen.dart';
import 'package:harugo/widgets/homecategoryWidget.dart';
import 'package:harugo/widgets/AttendanceWidget.dart';
import 'package:harugo/Service/pokoro_service.dart';

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
        body: SingleChildScrollView(
          // 전체를 스크롤 가능하게
          child: Column(
            children: [
              Stack(
                children: [
                  FutureBuilder<String?>(
                    future: PokoroService.getPokoroImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 310,
                          color: Colors.grey[300],
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        // 이미지 경로 없으면 기본 이미지
                        return Transform.translate(
                          offset: Offset(0, -90),
                          child: Image.asset(
                            "assets/pokoro_main.png",
                            height: 500,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      // 서버에서 받아온 이미지 경로 사용
                      return Transform.translate(
                        offset: Offset(0, -2),
                        child: Image.asset(
                          "assets/pokoro_main.png",
                          height: 320,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.all(34),
                      child: Text(
                        "HARUGO",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 300,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Text(
                          "이번 주 출석체크",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AttendanceWidget(attendanceDates: [
                          '2025-05-20', // 화요일 출석
                          '2025-05-21', // 수요일 출석
                        ], currentDate: DateTime(2025, 6, 19)),
                      ),
                      SizedBox(height: 20), // 간격 추가
                      // 카테고리 영역
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "공부하러가기",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: category,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: 200, // 필요에 따라 높이 조정
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var item = snapshot.data![index];
                                  return HomeCategoryWidget(
                                    id: item.id,
                                    name: item.name,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 30),
                                itemCount: snapshot.data!.length,
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      SizedBox(height: 50), // 하단 여백
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
