import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/data/model/response/category_model.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/utils/widget_size.dart';
import 'animations/animation_builder.dart';

class CategoriesView extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoriesView({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: CustomSize.categoryWidgetSize,
                  child: CustomAnimationBuilder(
                    direction: AnimationDirection.fromLeft,
                    child: ListView.separated(
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryWidget(
                            image: categories[index].image!,
                            name: categories[index].name!,
                            onTap: () {},
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20)),
                  ),
                ),
              ],
            ),
          );
  }
}

class CategoryWidget extends StatelessWidget {
  final String image, name;
  final Function()? onTap;
  final bool selected;
  const CategoryWidget(
      {required this.image,
      this.selected = false,
      required this.name,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: CustomSize.categoryImageSize,
            width: CustomSize.categoryImageSize,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: CustomNetworkImage(
                  url: 'https://picsum.photos/${Random().nextInt(100)}'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 20),
      child: SizedBox(
        height: CustomSize.categoryWidgetSize,
        child: ListView.separated(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: CustomSize.categoryWidgetSize,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: CustomSize.categoryImageSize,
                        width: CustomSize.categoryImageSize,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 15)),
      ),
    );
  }
}
