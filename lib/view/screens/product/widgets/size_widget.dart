import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/helper/price_converter.dart';
import 'package:umash_user/utils/colors.dart';

class SizeSelectionWidget extends StatelessWidget {
  final Variation variation;
  final List<int> selectedVariation;
  final Function() onSelected;
  const SizeSelectionWidget({
    required this.variation,
    required this.selectedVariation,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(variation.name!,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(width: 10.sp),
            Text(
              variation.isRequired! ? '(Required *)' : '(Optional)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: variation.isRequired!
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
            ),
          ],
        ),
        SizedBox(height: 8.sp),
        Wrap(
          spacing: 16.sp,
          runSpacing: 16.sp,
          children: [
            for (int index = 0;
                index < variation.variationValues!.length;
                index++)
              Builder(builder: (context) {
                final e = variation.variationValues![index];
                return SizeOption(
                  text: e.label ?? '',
                  price: PriceConverter.convertPrice(e.optionPrice ?? 0),
                  selected: selectedVariation.contains(index),
                  onTap: () {
                    if (selectedVariation[0] != index) {
                      selectedVariation[0] = index;
                    }
                    onSelected();
                  },
                );
              }),
          ],
        ),
        SizedBox(height: 16.sp),
      ],
    );
  }
}

class SizeOption extends StatelessWidget {
  final String text;
  final String price;
  final bool selected;
  final void Function()? onTap;
  const SizeOption({
    super.key,
    required this.text,
    this.selected = false,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
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
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: selected ? primaryColor : null,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
