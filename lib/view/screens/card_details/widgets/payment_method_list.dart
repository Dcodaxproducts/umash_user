import 'package:flutter/material.dart';
import 'package:umash_user/view/screens/card_details/card_details.dart';

// ignore: must_be_immutable
class PaymentMethodList extends StatelessWidget {
  PaymentMethodList({super.key});

  PaymentMethos selectedPayment = PaymentMethos.paypal;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => ListView(
        shrinkWrap: true,
        children: [
          PaymentTypeCheckBox(
            imageAddress: "assets/images/paypal.png",
            isSelected: selectedPayment == PaymentMethos.paypal,
            title: "Paypal",
            onPressed: (value) {
              setState(() {
                selectedPayment = PaymentMethos.paypal;
              });
            },
          ),
          PaymentTypeCheckBox(
            imageAddress: "assets/images/paypal.png",
            isSelected: selectedPayment == PaymentMethos.stripe,
            title: "Stripe",
            onPressed: (value) {
              setState(() {
                selectedPayment = PaymentMethos.stripe;
              });
            },
          ),
          PaymentTypeCheckBox(
            imageAddress: "assets/images/paypal.png",
            isSelected: selectedPayment == PaymentMethos.cash,
            title: "Cash On Delivery",
            onPressed: (value) {
              setState(() {
                selectedPayment = PaymentMethos.cash;
              });
            },
          )
        ],
      ),
    );
  }
}
