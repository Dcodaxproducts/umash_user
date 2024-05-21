import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/utils/colors.dart';

import '../../../../common/network_image.dart';
import '../../../../data/model/response/order_details_model.dart';
import '../../../../helper/price_converter.dart';
import '../../../../utils/style.dart';
import '../../review/review.dart';

class OrderItems extends StatelessWidget {
  final OrderDetailsModel orderDetail;
  const OrderItems({required this.orderDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ordered Items'.tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          for (var item in orderDetail.details)
            OrderItemWidget(
              detail: item,
              review: orderDetail.orderStatus == 'delivered',
            ),
        ],
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final Detail detail;
  final bool review;
  const OrderItemWidget(
      {required this.detail, required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75.0,
            width: 75.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: CustomNetworkImage(
                url: detail.product.image,
                loadingRadius: radius,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                Text(
                  detail.product.name!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),

                // discounted price
                Text(
                  PriceConverter.convertPrice(
                      PriceConverter.convertWithDiscount(
                          detail.product.price,
                          detail.product.discount,
                          detail.product.discountType)),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5.0),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Quantity'.tr,
                          style: FontStyles.bodySmall
                              .copyWith(fontWeight: FontWeight.normal),
                          children: [
                            TextSpan(
                              text: detail.quantity.toString(),
                            ),
                          ]),
                    ),
                    const Spacer(),
                    // review,
                    if (review)
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0),
                              ),
                            ),
                            builder: (_) => ReviewBottomSheet(
                              product: detail.product,
                              orderId: detail.orderId.toString(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Review Now'.tr,
                            style: FontStyles.bodySmall.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.topLeft,
      children: [
        if (detail.variation.isNotEmpty) ...[
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
                text: '${'variation'.tr}: ',
                style: FontStyles.bodySmall,
                children: [
                  TextSpan(
                    text: getVariationText,
                    style: FontStyles.bodySmall
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ]),
          ),
        ],
        if (detail.addOnIds.isNotEmpty) ...[
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
                text: "${'addons'.tr}: ",
                style: FontStyles.bodySmall,
                children: [
                  TextSpan(
                    text: addonText,
                    style: FontStyles.bodySmall
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ]),
          ),
          const SizedBox(height: 5),
        ],
      ],
    );
  }

  String get getVariationText {
    String variation = '';
    for (var item in detail.variation) {
      variation =
          '$variation${item.name} (${item.variationValues?.map((e) => '${e.label} - ${PriceConverter.convertPrice(e.optionPrice)}').join(',')}), ';
    }
    variation = variation.substring(0, variation.length - 2);
    return variation;
  }

  String get addonText {
    String addon = '';
    for (int i = 0; i < detail.addOnIds.length; i++) {
      var addonItem =
          detail.product.addOns!.firstWhere((e) => e.id == detail.addOnIds[i]);
      addon =
          '$addon(x${detail.addOnQtys[i]}) ${addonItem.name} ${PriceConverter.convertPrice((detail.addOnPrices[i] * detail.addOnQtys[i]).toDouble())}, ';
    }
    addon = addon.substring(0, addon.length - 2);
    return addon;
  }
}
