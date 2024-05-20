import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/controller/product_controller.dart';
import 'package:umash_user/helper/price_converter.dart';
import 'package:umash_user/utils/colors.dart';

class ProductInfo extends StatelessWidget {
  final double finalPrice;
  const ProductInfo({required this.finalPrice, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (con) {
      final product = con.product!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.sp),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromRGBO(255, 255, 255, 0.3)
                  : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.timer_1,
                        color: primaryColor,
                        size: 36.sp,
                      ),
                      SizedBox(height: 8.sp),
                      Text(product.cookingTime ?? ''),
                    ],
                  ),
                ),
                Container(
                  height: 50.sp,
                  width: 1.sp,
                  color: Colors.orange,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        Iconsax.star,
                        color: Colors.orange,
                        size: 36.sp,
                      ),
                      SizedBox(height: 8.sp),
                      Text('$rating(${product.rating?.length})'),
                    ],
                  ),
                ),
                Container(
                  height: 50.sp,
                  width: 1.sp,
                  color: Colors.orange,
                ),
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 18.sp,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.sp),
                          child: Image.network(
                            product.receipeMaker?.image ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      Text(
                        '${product.receipeMaker?.fname} ${product.receipeMaker?.lname}',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // product details
          const SizedBox(height: 16),
          // name
          Text(product.name ?? '',
              style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          // price,
          Text(PriceConverter.convertPrice(finalPrice),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
          if (product.description != null &&
              product.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            // description,
            Text(
              product.description ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ]
        ],
      );
    });
  }

  String get rating {
    double rating = 0.0;
    for (var element in ProductController.to.product!.rating!) {
      rating += double.parse(element.average ?? '0');
    }
    return rating.toStringAsFixed(1);
  }
}
