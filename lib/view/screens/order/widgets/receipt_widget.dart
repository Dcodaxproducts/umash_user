import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/helper/price_converter.dart';
import '../../../../common/seperator.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../data/model/response/order_details_model.dart';
import '../../../../utils/style.dart';

class OrderDetailsReceipt extends StatelessWidget {
  final OrderDetailsModel order;
  const OrderDetailsReceipt({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Receipt'.tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          ReceiptRow(
            title: 'Items Price'.tr,
            price: itemsPrice,
          ),
          ReceiptRow(
            title: 'Addons Price'.tr,
            price: addOnsAmount,
          ),
          ReceiptRow(
            title: '${'Item Discount'.tr} (-)',
            price: discountAmount,
            color: Colors.red,
          ),
          ReceiptRow(
            title: 'Subtotal'.tr,
            price: subtotal,
          ),
          ReceiptRow(
            title: SplashController.to.configModel!.taxEnabled
                ? '${'Vat/Tax'.tr} (${SplashController.to.configModel!.taxPercentage} %)'
                : 'Vat/Tax'.tr,
            price: order.totalTaxAmount?.toDouble() ?? 0,
          ),
          ReceiptRow(
            title: '${'Coupon Discount'.tr} (-)',
            price: 0,
            color: Colors.red,
          ),
          ReceiptRow(
            title: 'Delivery Fee'.tr,
            price: order.deliveryCharge ?? 0,
          ),
          const SizedBox(height: 10),
          const MySeparator(),
          const SizedBox(height: 5),
          ReceiptRow(
            title: 'Total Amount'.tr,
            price: order.orderAmount ?? 0,
            total: true,
          ),
        ],
      ),
    );
  }

  double get itemsPrice {
    double price = 0;
    for (var item in order.details) {
      price += item.price * item.quantity;
    }
    return price;
  }

  double get addOnsAmount {
    double addOns = 0.0;
    for (var item in order.details) {
      for (int i = 0; i < item.addOnIds.length; i++) {
        addOns += item.addOnPrices[i] * item.addOnQtys[i];
      }
    }
    return addOns;
  }

  double get discountAmount {
    double discount = 0.0;
    for (var item in order.details) {
      discount += item.discountOnProduct * item.quantity;
    }
    return discount;
  }

  double get subtotal {
    double subtotal = itemsPrice +
        addOnsAmount +
        (order.totalTaxAmount?.toDouble() ?? 0) -
        discountAmount;

    return subtotal;
  }
}

class ReceiptRow extends StatelessWidget {
  final String title;
  final double price;
  final Color? color;
  final bool total, last;
  final bool loading;
  const ReceiptRow(
      {required this.title,
      required this.price,
      this.color,
      this.last = false,
      this.total = false,
      this.loading = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: total ? 18.sp : null,
                    color: color,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            loading ? 'Calculating'.tr : PriceConverter.convertPrice(price),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: total ? 18.sp : null,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}
