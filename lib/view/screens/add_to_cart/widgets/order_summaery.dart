import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Item Purchase",
            ),
            Text("N8,500")
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Delievery Fee"), Text("")],
        )
      ],
    );
  }
}
