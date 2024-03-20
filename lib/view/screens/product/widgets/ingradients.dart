import 'package:flutter/material.dart';
import 'package:umash_user/common/network_image.dart';

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // ingredients,
        Text('Ingredients:',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
              .map((e) => Column(
                    children: [
                      SizedBox(
                        height: 36,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const CustomNetworkImage(
                              url:
                                  'https://t3.ftcdn.net/jpg/02/05/02/74/360_F_205027453_8Zor4CEdXTirIcxWVMtpzN4zFSdx0VFy.jpg'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Onion'),
                    ],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
