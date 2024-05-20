import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/controller/product_controller.dart';
import 'package:umash_user/utils/colors.dart';

class TasteSelectionWidget extends StatelessWidget {
  final Function(int)? onSelect;
  final int seletctedTaste;
  const TasteSelectionWidget(
      {required this.onSelect, required this.seletctedTaste, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (con) {
      final tags = con.product?.tags ?? [];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Taste:',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          SizedBox(height: 8.sp),
          StatefulBuilder(builder: (context, setState) {
            return Wrap(
              spacing: 16.sp,
              runSpacing: 16.sp,
              children: tags
                  .map((e) => TasteOption(
                        text: e.tag ?? '',
                        selected: tags.indexOf(e) == seletctedTaste,
                        onTap: () => onSelect!(tags.indexOf(e)),
                      ))
                  .toList(),
            );
          }),
          SizedBox(height: 16.sp),
        ],
      );
    });
  }
}

class TasteOption extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  const TasteOption({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? secondryColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? primaryColor : Theme.of(context).dividerColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? primaryColor : null,
          ),
        ),
      ),
    );
  }
}
