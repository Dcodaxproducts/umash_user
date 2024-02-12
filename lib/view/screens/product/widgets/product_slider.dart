import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/utils/colors.dart';

class ProductSlider extends StatelessWidget {
  const ProductSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const CustomNetworkImage(
              url:
                  'https://static.vecteezy.com/system/resources/thumbnails/025/281/832/small_2x/stock-of-fried-fries-with-burger-cinematic-editorial-foodgraphy-generative-ai-photo.jpg',
            ),
          ),
          // add arrow back and forward,
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: primaryColor),
              ),
              child: const Icon(
                Iconsax.arrow_left_2,
                size: 20,
                color: primaryColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: primaryColor),
              ),
              child: const Icon(
                Iconsax.arrow_right_3,
                size: 20,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
