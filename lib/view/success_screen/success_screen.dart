import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/dashboard/dashboard.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

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
      ),
      body: Padding(
        padding: pagePadding.copyWith(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/success.png"),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Order Completed Successfuly",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Use the order id to track your order",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Order ID",
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "123456",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                  height: 50,
                  onPressed: () {
                    launchScreen(const DashboardScreen());
                  },
                  color: primaryColor,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Continue to Shopping",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
