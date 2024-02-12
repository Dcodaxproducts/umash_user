import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/icons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/add_to_cart/add_to_cart_view.dart';
import 'package:umash_user/view/screens/customization/customization_view.dart';
import 'package:umash_user/view/screens/product/widgets/size_widget.dart';
import 'widgets/ingradients.dart';
import 'widgets/product_info.dart';
import 'widgets/product_slider.dart';
import 'widgets/taste_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: pagePadding.copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomIcon(
                    icon: Iconsax.category,
                    onTap: pop,
                  ),
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomIcon(
                    icon: Iconsax.heart,
                    onTap: () {},
                  ),
                ],
              ),
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(height: 32),
                  const ProductSlider(),
                  const SizedBox(height: 16),
                  const ProductInfo(),
                  const IngredientsWidget(),
                  const SizedBox(height: 16),
                  TasteSelectionWidget(),
                  SizeSelectionWidget(),
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: pagePadding,
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
              text: 'Customize',
              radius: 8,
              color: secondaryColor,
              textColor: primaryColor,
              iconData: Iconsax.edit,
              onPressed: () {
                launchScreen(const CustomizationView());
              },
            )),
            const SizedBox(width: 16),
            Expanded(
                child: PrimaryButton(
              text: 'Add to Cart',
              radius: 8,
              iconData: Iconsax.shopping_bag,
              onPressed: () {
                launchScreen(const AddtoCartView());
              },
            )),
          ],
        ),
      ),
    );
  }
}
