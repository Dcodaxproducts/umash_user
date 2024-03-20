import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:umash_user/common/icons.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/utils/widget_size.dart';
import 'package:umash_user/view/base/animation_builder.dart';
import 'package:umash_user/view/screens/product/product_details.dart';

class ProductViewHorizontal extends StatelessWidget {
  final String title;
  const ProductViewHorizontal({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View All'.tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: CustomSize.foodHeight_H,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: CustomAnimationBuilder(
              direction: AnimationDirection.fromLeft,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) =>
                    FoodWidgetHorizontal(favourite: index.isEven),
                separatorBuilder: (context, index) => const SizedBox(width: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodWidgetHorizontal extends StatelessWidget {
  final bool favourite;
  const FoodWidgetHorizontal({required this.favourite, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchScreen(const ProductDetailScreen()),
      child: SizedBox(
        width: CustomSize.foodWidth_H,
        child: Stack(
          children: [
            Container(
              width: CustomSize.foodWidth_H,
              height: CustomSize.foodImageHeight_H,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(radius)),
              ),
              child: const ClipRRect(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(radius)),
                child: CustomNetworkImage(url: 'https://picsum.photos/200'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(radius)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Southern Style BBQ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'N8,000',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Spacer(),
                        CustomIcon(
                          padding: 5,
                          icon: Icons.add,
                          iconSize: 16,
                          radius: 5,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductViewShimmerHorizontal extends StatelessWidget {
  const ProductViewShimmerHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 50,
                height: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: CustomSize.foodHeight_H,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => SizedBox(
                    width: CustomSize.foodWidth_H,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: CustomSize.foodWidth_H,
                            height: CustomSize.foodImageHeight_H,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 50,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(width: 15)),
        ),
      ],
    );
  }
}
