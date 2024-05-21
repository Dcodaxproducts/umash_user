import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/order_controller.dart';

class AdditionalNoteWidget extends StatelessWidget {
  final TextEditingController controller;
  const AdditionalNoteWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (con) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Note (optional)',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: TextField(
                controller: controller,
                maxLines: 4,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Instructions'.tr,
                ),
                onChanged: con.setNote,
              ),
            ),
          ],
        ),
      );
    });
  }
}
