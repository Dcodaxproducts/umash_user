import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/model/response/order_details_model.dart';
import '../../../../helper/date_converter.dart';
import '../../../../utils/style.dart';

class OrderAddress extends StatelessWidget {
  final DeliveryAddress deliveryAddress;
  const OrderAddress({required this.deliveryAddress, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Delivery Info'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                DateConverter.formatDateTime(deliveryAddress.createdAt),
                style: FontStyles.bodySmall.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Iconsax.user,
                size: 30,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deliveryAddress.contactPersonName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),
                    // phone number,
                    Text(
                      deliveryAddress.contactPersonNumber,
                      style: FontStyles.bodySmall
                          .copyWith(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // address,
          Text(
            deliveryAddress.address,
            style: FontStyles.bodySmall.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
