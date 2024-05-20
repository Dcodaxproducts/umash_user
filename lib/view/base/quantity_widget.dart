import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        IconButton.outlined(
          color: primaryColor,
          style: IconButton.styleFrom(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            padding: EdgeInsets.zero,
            side: const BorderSide(color: primaryColor),
          ),
          onPressed: onRemove,
          icon: Icon(Icons.remove, size: 20.sp),
        ),
        SizedBox(width: 8.sp),
        Text(
          '$quantity',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(width: 8.sp),
        IconButton.outlined(
          color: primaryColor,
          style: IconButton.styleFrom(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            padding: EdgeInsets.zero,
            side: const BorderSide(color: primaryColor),
          ),
          onPressed: onAdd,
          icon: Icon(Icons.add, size: 20.sp),
        ),
      ],
    );
  }
}
