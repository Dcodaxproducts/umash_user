import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/add_to_cart/widgets/delivery_detial_form.dart';
import 'package:umash_user/view/screens/add_to_cart/widgets/delivery_page_heading.dart';
import 'package:umash_user/view/screens/add_to_cart/widgets/order_summaery.dart';
import 'package:umash_user/view/screens/card_details/card_details.dart';

class AddtoCartView extends StatelessWidget {
  const AddtoCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Delivery Details',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: pagePadding.copyWith(bottom: 0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              DeliveryPageHeading(
                title: "Delivery Address",
                traling: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Save Address",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.arrow_drop_down_sharp)
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              const DeliveryDetailForm(),

              /// Order Summary
              const SizedBox(
                height: 20,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Order Summary
                  const DeliveryPageHeading(
                    title: "Order Summary",
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const OrderSummary(),

                  const Divider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        "N8,500",
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: pagePadding,
        child: MaterialButton(
            height: 50,
            onPressed: () {},
            color: primaryColor,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              "Proceed To Payment",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
