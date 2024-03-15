import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/images.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? const Color.fromRGBO(255, 255, 255, 0.3)
                : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Icon(
                    Iconsax.timer_1,
                    color: primaryColor,
                    size: 36,
                  ),
                  SizedBox(height: 8),
                  Text('10-15 mins'),
                ],
              ),
              Container(
                height: 50,
                width: 1,
                color: Colors.orange,
              ),
              const Column(
                children: [
                  Icon(
                    Iconsax.star,
                    color: Colors.orange,
                    size: 36,
                  ),
                  SizedBox(height: 8),
                  Text('4.5(26)'),
                ],
              ),
              Container(
                height: 50,
                width: 1,
                color: Colors.orange,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        Images.user_placeholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('John Doe'),
                ],
              ),
            ],
          ),
        ),
        // product details,
        const SizedBox(height: 16),
        // name,
        Text('Cheese Burger', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 8),
        // price,
        Text('\$150',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        const SizedBox(height: 16),
        // description,
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
          'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
          'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
