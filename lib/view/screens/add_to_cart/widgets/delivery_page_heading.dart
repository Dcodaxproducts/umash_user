import 'package:flutter/material.dart';

class DeliveryPageHeading extends StatelessWidget {
  final String title;
  final Widget? traling;
  const DeliveryPageHeading({super.key, required this.title, this.traling});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        traling ?? const SizedBox.shrink()
      ],
    );
  }
}
