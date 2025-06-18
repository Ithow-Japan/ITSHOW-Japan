import 'package:flutter/material.dart';
import 'package:harugo/Service/category_service.dart';
import 'package:harugo/Service/category_achievement_service.dart';
import 'package:harugo/widgets/categoryWidget.dart';
import 'package:harugo/models/category_model.dart';
import 'package:harugo/models/category_achievement_model.dart';
import 'package:harugo/screens/expressions.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  Future<List<Map<String, dynamic>>> loadCategoriesWithAchievements() async {
    final categories = await CategoryService.getCategory();
    final achievements =
        await CategoryAchievementService.getCategoryAchievement();

    return categories.map((category) {
      final matched = achievements.firstWhere(
        (ach) => ach.categoryId == category.id,
        orElse: () =>
            CategoryAchievementModel(categoryId: category.id, achievement: 0),
      );
      return {
        'category': category,
        'achievement': matched.achievement,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xfffff6f3),
        title: const Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            "HARUGO",
            style: TextStyle(
              fontSize: 26,
              color: Color(0xffFF6700),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xfffff6f3),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadCategoriesWithAchievements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }

          final data = snapshot.data!;

          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemBuilder: (context, index) {
              final category = data[index]['category'] as CategoryModel;
              final achievement = data[index]['achievement'] as int;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpressionScreen(id: category.id),
                    ),
                  );
                },
                child: CategoryWidget(
                  id: category.id,
                  name: category.name,
                  image_path: category.image_path,
                  achievement: achievement,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
