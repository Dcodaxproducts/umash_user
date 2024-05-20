import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/checkout/checkout.dart';
import '../../base/divider.dart';
import '../../base/receipt_row.dart';
import 'widgets/cart_product.dart';
import 'widgets/header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (con) {
      return Scaffold(
        body: Column(
          children: [
            const CartHeaderWidget(),
            Expanded(
              child: ListView.separated(
                padding: pagePadding,
                itemCount: con.cartList.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.sp),
                itemBuilder: (context, index) =>
                    CartProduct(cartItem: con.cartList[index], index: index),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  const CustomDivider(padding: 20),
                  ReceiptRow(
                    title: 'Items Price',
                    price: con.itemsPrice,
                  ),
                  ReceiptRow(
                    title: 'Addons Price',
                    price: con.addOnsAmount,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: pagePadding,
          child: PrimaryButton(
            text: 'Continue to Checkout',
            onPressed: () => launchScreen(const CheckoutScreen()),
          ),
        ),
      );
    });
  }
}
