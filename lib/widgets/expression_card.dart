import 'package:flutter/material.dart';
import 'package:harugo/models/expressions_model.dart';
import 'package:harugo/Service/expressions_service.dart';

class ExpressionsCard extends StatefulWidget {
  final ExpressionsModel expression;

  const ExpressionsCard({super.key, required this.expression});

  @override
  State<ExpressionsCard> createState() => _ExpressionsCardState();
}

class _ExpressionsCardState extends State<ExpressionsCard> {
  bool isCompleted = false;

  String _formatJapanese(String text) {
    return text.replaceFirstMapped(RegExp(r'\s*([（(])'), (match) {
      return '\n${match.group(1)}';
    });
  }

  String _formatExample(String text) {
    return text.replaceFirstMapped(RegExp(r'(B:)'), (match) {
      return '\n\n${match.group(1)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // 학습완료 버튼 (아이콘 + 텍스트)
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      if (isCompleted) return;

                      bool success =
                          await ExpressionsService.completeExpression(
                              widget.expression.id);

                      if (success) {
                        setState(() {
                          isCompleted = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("서버 오류: 학습완료 실패")),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: isCompleted ? Color(0xffFD6929) : Colors.grey,
                    ),
                  ),
                  Text(
                    "학습완료",
                    style: TextStyle(
                      color: isCompleted ? Color(0xffFD6929) : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상단 흰색 영역
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatJapanese(widget.expression.japanese),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFD6929),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            widget.expression.korean,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.expression.pronunciation,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff989898),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 중간 주황색 얇은 선
                    Container(
                      height: 2,
                      color: Color(0xffFD6929),
                    ),

                    // 하단 회색 영역
                    Container(
                      width: double.infinity,
                      color: Color(0xffFFF6F3),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.expression.explanation,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 예문 텍스트 (카드 외부)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                _formatExample(widget.expression.example),
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
