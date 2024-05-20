import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/controller/cart_controller.dart';

class CouponWidget extends StatefulWidget {
  const CouponWidget({super.key});

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (con) {
      return Row(
        children: [
          Icon(Iconsax.discount_circle, size: 20.sp),
          SizedBox(width: 5.sp),
          Expanded(
            child: Text(
              'apply_coupon'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
            child: Text(
              'select'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.blue),
            ),
            onPressed: () {
              // if (coupon.discount! < 1) {
              //   coupon
              //       .applyCoupon(_controller.text, con.totalAmount)
              //       .then((discount) {
              //     if (discount! > 0) {
              //       showToast(
              //         '${'you_got'.tr} ${PriceConverter.convertPrice(discount)} ${'discount'.tr}',
              //         success: true,
              //       );
              //     } else {
              //       showToast('invalid_code_or'.tr);
              //     }
              //   });
              // } else {
              //   coupon.removeCouponData(true);
              // }
            },
          ),
        ],
      );
    });
  }
}
