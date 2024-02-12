import 'package:flutter/material.dart';
import 'package:umash_user/data/model/response/category_model.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/categories.dart';
import 'package:umash_user/view/screens/home/widgets/product_view_horizontal.dart';
import 'package:umash_user/view/screens/home/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HomeHeaderWidget(),
          Expanded(
              child: ListView(
            padding: pagePadding,
            children: [
              CategoriesView(categories: categories),
              const ProductViewHorizontal(title: 'Suggested'),
              const ProductViewHorizontal(title: 'Top Products'),
              const ProductViewHorizontal(title: 'Extras'),
            ],
          ))
        ],
      ),
    );
  }
}
