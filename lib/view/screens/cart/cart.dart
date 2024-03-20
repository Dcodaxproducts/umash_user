import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'widgets/cart_product.dart';
import 'widgets/header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CartHeaderWidget(),
          Expanded(
            child: ListView(
              padding: pagePadding.copyWith(top: 32),
              children: [
                for (int i = 0; i < 3; i++)
                  CartProduct(
                    productName: 'Product Name',
                    imageUrl: 'https://picsum.photos/200/300',
                    price: 100,
                    quantity: 2,
                    onEditPressed: () {},
                    onDeletePressed: () {},
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Theme.of(context).hintColor),
                    ),
                    Text(
                      'N19,000',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  padding: EdgeInsets.zero,
                  controller: _controller,
                  hintText: 'Add Promo Code (Optional)',
                  prefix: const Icon(Iconsax.tag, size: 20),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: Center(
                          child: Text(
                            'Apply',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Continue to Checkout',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
