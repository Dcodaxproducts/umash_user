import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/controller/product_controller.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (con) {
      final product = con.product!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.sp),
          // ingredients,
          Text('Ingredients:',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          SizedBox(height: 8.sp),
          Wrap(
            spacing: 16.sp,
            runSpacing: 16.sp,
            children: product.addOns!
                .map((e) => Column(
                      children: [
                        SizedBox(
                          height: 36.sp,
                          width: 36.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CustomNetworkImage(url: e.image),
                          ),
                        ),
                        SizedBox(height: 8.sp),
                        Text(e.name ?? ''),
                      ],
                    ))
                .toList(),
          ),
        ],
      );
    });
  }
}
