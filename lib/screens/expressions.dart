import 'package:flutter/material.dart';
import 'package:harugo/Service/expressions_service.dart';
import 'package:harugo/models/expressions_model.dart';
import 'package:harugo/widgets/expression_card.dart';

class ExpressionScreen extends StatelessWidget {
  final int id;

  const ExpressionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('표현 학습'),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder<List<ExpressionsModel>>(
          future: ExpressionsService.getExpressions(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('데이터가 없습니다.'));
            }

            final expressions = snapshot.data!;
            return Center(
              // 이 부분이 중요!
              child: SizedBox(
                height: 700,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.98),
                  itemCount: expressions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: ExpressionsCard(expression: expressions[index]),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
