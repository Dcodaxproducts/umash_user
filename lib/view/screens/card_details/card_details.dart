import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/text.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/card_details/widgets/card_detail_form.dart';
import 'package:umash_user/view/screens/card_details/widgets/payment_method_list.dart';
import 'package:umash_user/view/screens/success_screen/success_screen.dart';

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({super.key});

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
          'Payment',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Column(children: [
            const SizedBox(height: 20),
            const PageHeading(
              title: "Select Payment Method",
            ),
            const SizedBox(height: 10),
            PaymentMethodList(),
            const SizedBox(
              height: 20,
            ),
            const PageHeading(
              title: "Enter card credentials",
            ),
            const CardDetailForm()
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: pagePadding,
        child: MaterialButton(
            height: 50,
            onPressed: () {
              launchScreen(const SuccessfulScreen());
            },
            color: primaryColor,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              "Proceed",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}

class PaymentTypeCheckBox extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function(bool?)? onPressed;
  final String imageAddress;
  const PaymentTypeCheckBox(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onPressed,
      required this.imageAddress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 66,
        decoration: BoxDecoration(
            color: isSelected ? secondryColor : Colors.white,
            border: Border.all(color: isSelected ? primaryColor : Colors.grey),
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        imageAddress,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white),
                  ),
                ],
              ),
              RadioMenuButton(
                value: true,
                groupValue: isSelected,
                onChanged: onPressed,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum PaymentMethos { paypal, stripe, cash }
