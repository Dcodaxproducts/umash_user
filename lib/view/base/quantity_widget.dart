import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';

class QuantityWidget extends StatelessWidget {
  final int quantity;
  final Function() onAdd;
  final Function() onRemove;
  const QuantityWidget({
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        InkWell(
          onTap: onRemove,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: primaryColor),
            ),
            child: Icon(
              Icons.remove,
              size: MediaQuery.sizeOf(context).height * 0.02,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$quantity',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onAdd,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: primaryColor),
            ),
            child: Icon(
              Icons.add,
              size: MediaQuery.sizeOf(context).height * 0.02,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
