import 'package:flutter/material.dart';
import 'package:harugo/widgets/categoryWidget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryWidget(),
    );
  }
}
