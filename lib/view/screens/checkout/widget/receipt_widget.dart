import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/controller/splash_controller.dart';
import '../../../../controller/coupon_controller.dart';
import '../../../../controller/order_controller.dart';
import '../../../base/receipt_row.dart';

class OrderReceiptWidget extends StatelessWidget {
  const OrderReceiptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          child: Column(
            children: [
              ReceiptRow(
                title: 'Items Price',
                price: cartController.itemsPrice,
              ),
              ReceiptRow(
                title: 'Addons Price',
                price: cartController.addOnsAmount,
              ),
              ReceiptRow(
                title: "Items Discount (-)",
                price: cartController.discountAmount,
                color: Colors.red,
              ),
              ReceiptRow(
                title: 'Subtotal',
                price: cartController.subtotalAmount,
              ),
              ReceiptRow(
                title: SplashController.to.configModel!.taxEnabled
                    ? 'VAT/TAX (${SplashController.to.configModel!.taxPercentage} %)'
                    : 'VAT/TAX'.tr,
                price: cartController.taxAmount,
              ),
              GetBuilder<CouponController>(builder: (con) {
                return ReceiptRow(
                  title: 'Coupon Discount (-)',
                  price: con.discount ?? 0.0,
                  color: Colors.red,
                );
              }),
              GetBuilder<OrderController>(builder: (con) {
                return ReceiptRow(
                  title: 'Delivery Fee'.tr,
                  price: con.deliveryFee,
                  loading: con.calculatingDistance,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
