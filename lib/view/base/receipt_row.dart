import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/helper/price_converter.dart';

class ReceiptRow extends StatelessWidget {
  final String title;
  final double price;
  final Color? color;
  final bool total, last;
  final bool loading;
  const ReceiptRow(
      {required this.title,
      required this.price,
      this.color,
      this.last = false,
      this.total = false,
      this.loading = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: total ? 18.sp : null, color: color),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            loading ? 'calculating'.tr : PriceConverter.convertPrice(price),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: total ? 18.sp : null, color: color),
          ),
        ],
      ),
    );
  }
}
