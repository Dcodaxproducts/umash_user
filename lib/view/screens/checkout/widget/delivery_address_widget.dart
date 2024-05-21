// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/controller/order_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/view/base/divider.dart';
import '../../../../controller/location_controller.dart';
import '../../../../utils/style.dart';
import '../../address/add_address.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (con) {
        return con.deliveryType != 'delivery'
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.sp),
                  if (con.address != null) ...[
                    Text(
                      con.address!.addressType,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 5.sp),
                    Text(
                      con.address!.address,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: 5.sp),
                    Text(
                      con.address!.contactPersonNumber,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).hintColor),
                    )
                  ],
                  if (con.address == null)
                    InkWell(
                      onTap: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) => const ShippingAddressSheet(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        child: Row(
                          children: [
                            Icon(Iconsax.location, size: 20.sp),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Select Delivery Address',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Icon(
                              Iconsax.arrow_right_3,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              );
      },
    );
  }
}

class ShippingAddressSheet extends StatelessWidget {
  const ShippingAddressSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Column(
            children: [
              // title
              Text(
                'Delivery Address',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              // address list
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    final address = locationController.addressList[index];
                    LatLng latlng = LatLng(double.parse(address.latitude),
                        double.parse(address.longitude));
                    if (LocationController.to.inServiceArea(latlng) != -1) {
                      OrderController.to.address = address;
                      pop();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              locationController.addressList[index].addressType,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              locationController.addressList[index].address,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<OrderController>(builder: (orderController) {
                        return Visibility(
                          visible: orderController.address ==
                              locationController.addressList[index],
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      })
                    ],
                  ),
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 30),
                itemCount: locationController.addressList.length,
              ),
              const CustomDivider(padding: 20),
              InkWell(
                onTap: () {
                  pop();
                  launchScreen(const AddAddressScreen(setLocation: true));
                },
                child: Row(
                  children: [
                    Icon(
                      Iconsax.add_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(
                      'Add New Address',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    });
  }
}
