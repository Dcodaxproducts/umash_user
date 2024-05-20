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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${'additional_note'.tr} (optional)',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                hintText: 'add_instructions'.tr,
              ),
              onChanged: con.setNote,
            ),
          ),
        ],
      );
    });
  }
}
