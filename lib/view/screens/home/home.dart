import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/controller/product_controller.dart';
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
          Expanded(child: GetBuilder<ProductController>(builder: (con) {
            return ListView(
              padding: pagePadding,
              children: [
                const CategoriesView(),
                ProductViewHorizontal(
                  title: 'Top Products',
                  products: con.popularProductList ?? [],
                ),
                ProductViewHorizontal(
                  title: 'Latest',
                  products: con.latestProductList ?? [],
                ),
              ],
            );
          }))
        ],
      ),
    );
  }
}
