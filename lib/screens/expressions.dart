import 'package:flutter/material.dart';
import 'package:harugo/Service/expressions_service.dart';
import 'package:harugo/models/expressions_model.dart';
import 'package:harugo/widgets/expression_card.dart';

class ExpressionScreen extends StatelessWidget {
  final int id;

  const ExpressionScreen({super.key, required this.id});

  Future<Map<String, dynamic>> _fetchData(int id) async {
    // 두 요청 병렬 처리
    final results = await Future.wait([
      ExpressionsService.getExpressions(id),
      ExpressionsService.getLearnedExpressions(id),
    ]);

    final expressions = results[0];
    final learned = results[1];

    // 학습된 표현의 ID만 추출
    final learnedIds = learned.map((e) => e.id).toList();

    return {
      'expressions': expressions,
      'learnedIds': learnedIds,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('표현 학습'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchData(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!['expressions'].isEmpty) {
            return Center(child: Text('데이터가 없습니다.'));
          }

          final expressions =
              snapshot.data!['expressions'] as List<ExpressionsModel>;
          final learnedIds = snapshot.data!['learnedIds'] as List<int>;

          return Center(
            child: SizedBox(
              height: 700,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.98),
                itemCount: expressions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ExpressionsCard(
                      expression: expressions[index],
                      learnedExpressionIds: learnedIds, // ✅ 전달!
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
