import 'package:flutter/material.dart';
import 'package:harugo/models/pokoro_model.dart';
import 'package:harugo/Service/pokoro_service.dart';
import 'package:harugo/widgets/pokoroContainerWidget.dart';
import "../Service/pokoro_status_service.dart";
import "../models/pokoro_status.model.dart";

class PokoroScreen extends StatelessWidget {
  const PokoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            "나의 포코로",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xffFFE7DD),
      body: FutureBuilder<List<PokoroModel>>(
        future: PokoroService.getPokoro(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('포코로 데이터 없음'));
          }

          final Map<String, String> pokoroNameMap = {
            "pokoro": "포코로",
            "cook_pokoro": "요리사 포코로",
            "artist_pokoro": "화가 포코로",
            "child_pokoro": "유치원 포코로",
            "student_pokoro": "모범생 포코로",
          };

          // 현재 착용 중인 포코로 1개 선택
          final pokoro = snapshot.data!.first;
          final image = pokoro.image;
          final pokoroName = pokoroNameMap[pokoro.pokoro_name] ?? "알 수 없음";

          return Stack(
            children: [
              // 배경 포코로 이미지
              Positioned(
                top: -80,
                left: 0,
                right: 0,
                child: Image.asset(image),
              ),
              Transform.translate(
                offset: const Offset(310, 70),
                child: Image.asset(
                  'assets/icons/hanger.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 470,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Container(
                    width: 210,
                    height: 62,
                    decoration: BoxDecoration(
                      color: const Color(0xffFD6929),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "현재 착용 의상",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            pokoroName,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 560, left: 20, right: 20),
                  child: FutureBuilder<PokoroStatusModel?>(
                    future: PokoroStatusService.getPokoroStatus(),
                    builder: (context, gageSnapshot) {
                      if (gageSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (gageSnapshot.hasError || gageSnapshot.data == null) {
                        return const Text("게이지 정보 없음");
                      }

                      return PokoroContainerWidget(
                          gage: gageSnapshot.data!.gage);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
