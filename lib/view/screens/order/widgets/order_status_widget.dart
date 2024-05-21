import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:umash_user/helper/date_converter.dart';
import 'package:umash_user/utils/app_constants.dart';

import '../../../../common/network_image.dart';
import '../../../../data/model/response/order_details_model.dart';
import '../../../../helper/navigation.dart';
import '../../../../utils/style.dart';
import '../../../base/view_image.dart';

class OrderStatusWidget extends StatelessWidget {
  final OrderDetailsModel orderDetails;
  const OrderStatusWidget({required this.orderDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order_status'.tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          if (AppConstants.orderStatus.contains(orderDetails.orderStatus)) ...[
            Row(
              children: [
                for (int i = 0; i < AppConstants.orderStatus.length; i++)
                  StatusIndicator(
                    active: i <=
                        AppConstants.orderStatus
                            .indexOf(orderDetails.orderStatus!),
                    isLast: i == AppConstants.orderStatus.length - 1,
                  )
              ],
            ),
            const SizedBox(height: 15),
          ],
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        orderDetails.orderStatus!.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat.jm().format(orderDetails.updatedAt!),
                      style: FontStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${orderDetails.orderStatus!}_msg'.tr,
                  style: FontStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${'Order Id'.tr}: #${orderDetails.id}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              const Icon(
                Iconsax.clock,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                DateConverter.formatDateTime(orderDetails.createdAt!),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderDetails.orderType!.tr,
                style: FontStyles.bodySmall,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  orderDetails.paymentMethod!.tr,
                  style: FontStyles.bodySmall.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          if (orderDetails.orderConfirmationImage != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Image'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () => launchScreen(
                          ViewImage(
                              image: orderDetails.orderConfirmationImage!),
                        ),
                        child: Hero(
                          tag: orderDetails.orderConfirmationImage!,
                          child: CustomNetworkImage(
                            url: orderDetails.orderConfirmationImage!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class StatusIndicator extends StatelessWidget {
  final bool active;
  final bool isLast;
  const StatusIndicator({this.active = false, this.isLast = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: isLast ? 0 : 10),
        height: 5,
        decoration: BoxDecoration(
          color: active
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
