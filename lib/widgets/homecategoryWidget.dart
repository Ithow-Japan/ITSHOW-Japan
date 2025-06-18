import 'package:flutter/material.dart';

class HomeCategoryWidget extends StatelessWidget {
  final int id;
  final String name;
  final int achievement; // 퍼센트 (0~100)
  final String firstKorean;

  const HomeCategoryWidget({
    super.key,
    required this.id,
    required this.name,
    required this.achievement,
    required this.firstKorean,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,
        height: 160,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "$achievement%",
                    style: const TextStyle(
                      color: Color(0xffFD6929),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "학습완료",
                    style: TextStyle(
                      color: Color(0xff9E9E9E),
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      "총 245개", // 필요 시 매개변수화 가능
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xff919191),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Container(
                  width: 230,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffffe7dd),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          firstKorean.isNotEmpty ? firstKorean : '표현이 없습니다',
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_right_rounded),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
