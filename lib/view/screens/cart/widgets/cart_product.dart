import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/view/base/quantity_widget.dart';

class CartProduct extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;
  final int quantity;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const CartProduct({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.onEditPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomNetworkImage(url: imageUrl),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 16),
                QuantityWidget(
                  quantity: quantity,
                  onAdd: () {},
                  onRemove: () {},
                )
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                icon: const Icon(
                  Iconsax.edit,
                  size: 18,
                ),
                onPressed: onEditPressed,
              ),
              IconButton(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                icon: const Icon(
                  Iconsax.trash,
                  size: 18,
                ),
                onPressed: onDeletePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
