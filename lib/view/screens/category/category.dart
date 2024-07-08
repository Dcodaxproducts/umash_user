import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/controller/category_controller.dart';
import 'package:umash_user/data/model/response/category_model.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/home/widgets/product_view_horizontal.dart';

class CategoryProductScreen extends StatelessWidget {
  final CategoryModel category;
  CategoryProductScreen({required this.category, super.key}) {
    CategoryController.to.getCategoryProductList(category.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomBackButton(),
          ),
          title: Text(category.name ?? ''),
        ),
        body: GetBuilder<CategoryController>(
          builder: (con) {
            return con.categoryProductList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: pagePadding,
                    itemCount: con.categoryProductList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0.sp,
                      crossAxisSpacing: 16.sp,
                      mainAxisSpacing: 16.sp,
                    ),
                    itemBuilder: (context, index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: FoodWidgetHorizontal(
                          favourite: index.isEven,
                          category: true,
                          product: con.categoryProductList[index],
                        ),
                      );
                    },
                  );
          },
        ));
  }
}
