import 'package:flutter/material.dart';
import 'package:harugo/Service/category_service.dart';
import 'package:harugo/models/category_model.dart';
import 'package:harugo/screens/categoryScreen.dart';
import 'package:harugo/widgets/homecategoryWidget.dart';
import 'package:harugo/Service/pokoro_service.dart';
import 'package:harugo/Service/attendance_service.dart';
import 'package:harugo/models/attendance_model.dart';
import 'package:intl/intl.dart';
import '../widgets/attendanceWidget.dart';
import '../models/category_achievement_model.dart';
import '../Service/category_achievement_service.dart';
import '../Service/expressions_service.dart';

Future<List<Map<String, dynamic>>> loadHomeCategoryData() async {
  final categories = await CategoryService.getCategory();
  final achievements =
      await CategoryAchievementService.getCategoryAchievement();

  final expressionFutures = categories.map((cat) async {
    final expressions = await ExpressionsService.getExpressions(cat.id);
    return {
      'id': cat.id,
      'firstKorean': expressions.isNotEmpty ? expressions[0].korean : '',
    };
  }).toList();

  final expressionsData = await Future.wait(expressionFutures);

  return categories.map((cat) {
    final achievement = achievements.firstWhere(
      (e) => e.categoryId == cat.id,
      orElse: () =>
          CategoryAchievementModel(categoryId: cat.id, achievement: 0),
    );
    final expression = expressionsData.firstWhere(
      (e) => e['id'] == cat.id,
      orElse: () => {'firstKorean': ''},
    );

    return {
      'id': cat.id,
      'name': cat.name,
      'achievement': achievement.achievement,
      'firstKorean': expression['firstKorean'],
    };
  }).toList();
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final Future<List<CategoryModel>> category = CategoryService.getCategory();
  late Future<List<AttendanceModel>> attendanceFuture;

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords(); // 출석 기록 최초 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAttendancePopup();
    });
  }

  // 출석 기록을 /records API로부터 가져오는 함수
  void _loadAttendanceRecords() {
    setState(() {
      attendanceFuture = AttendanceService.getAttendance();
    });
  }

  // 오늘 출석했는지 확인 후 안했으면 팝업 띄우는 함수
  void _checkAttendancePopup() async {
    try {
      bool hasChecked = await AttendanceService.checkTodayAttendanceExists();

      if (!hasChecked && context.mounted) {
        _showAttendanceDialog();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("출석 상태 확인 실패: $e")),
        );
      }
    }
  }

  // 출석체크 팝업
  void _showAttendanceDialog() {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("출석체크"),
        content: const Text("오늘 아직 출석하지 않으셨어요. 출석체크 하시겠어요?"),
        actions: [
          TextButton(
            child: const Text("닫기"),
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: const Text("출석체크"),
            onPressed: () async {
              if (Navigator.canPop(context)) Navigator.pop(context);

              try {
                bool alreadyChecked =
                    await AttendanceService.checkTodayAttendanceExists();
                if (alreadyChecked) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("이미 오늘 출석하셨습니다.")),
                    );
                  }
                  return;
                }

                // 출석체크 POST 요청 (/attendance/check)
                bool result = await AttendanceService.postTodayAttendance();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result ? "출석체크 완료!" : "출석체크 실패"),
                    ),
                  );

                  if (result) {
                    _loadAttendanceRecords(); // 출석체크 성공 시 출석 기록 재조회해서 UI 갱신
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("출석 처리 중 오류 발생: $e")),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                      return Transform.translate(
                        offset: const Offset(0, -2),
                        child: Image.asset(
                          "assets/pokoro_main.png",
                          height: 320,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  const Positioned(
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
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
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
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                        child: FutureBuilder<List<AttendanceModel>>(
                          future: attendanceFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('출석 데이터 로드 실패: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('출석 기록이 없습니다.');
                            } else {
                              return AttendanceWidget(
                                  attendanceList: snapshot.data!);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "공부하러가기",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: loadHomeCategoryData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text("카테고리가 없습니다."));
                          }

                          final dataList = snapshot.data!;

                          return SizedBox(
                            height: 200,
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final item = dataList[index];
                                return HomeCategoryWidget(
                                  id: item['id'],
                                  name: item['name'],
                                  achievement: item['achievement'],
                                  firstKorean: item['firstKorean'],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 30),
                              itemCount: dataList.length,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
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
