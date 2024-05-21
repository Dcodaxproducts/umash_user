import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/controller/coupon_controller.dart';
import 'package:umash_user/helper/price_converter.dart';

class CouponWidget extends StatefulWidget {
  const CouponWidget({super.key});

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (con) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupon Code',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.sp),
            GetBuilder<CouponController>(builder: (coupon) {
              return CustomTextField(
                controller: _controller,
                hintText: 'Enter Coupon Code',
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 5.sp),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        if (coupon.discount! < 1) {
                          coupon
                              .applyCoupon(_controller.text, con.totalAmount)
                              .then((discount) {
                            if (discount! > 0) {
                              showToast(
                                'You got ${PriceConverter.convertPrice(discount)} discount',
                                success: true,
                              );
                            } else {
                              showToast('Invalid Code');
                            }
                          });
                        } else {
                          coupon.removeCouponData(true);
                        }
                      } else {
                        showToast('Enter a coupon code');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
