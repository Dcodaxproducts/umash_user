import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/data/model/body/cart_model.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/helper/price_converter.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/quantity_widget.dart';
import 'package:umash_user/view/screens/product/product_details.dart';

// ignore: must_be_immutable
class CartProduct extends StatelessWidget {
  final CartModel cartItem;
  final int index;
  const CartProduct({Key? key, required this.cartItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchScreen(
          ProductDetailScreen(product: cartItem.product!, cartIndex: index)),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(radius),
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
              width: 100.sp,
              height: 100.sp,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: CustomNetworkImage(url: cartItem.product?.image ?? ''),
              ),
            ),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cartItem.product?.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.sp),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          PriceConverter.convertPrice(cartItem.price),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      QuantityWidget(
                        quantity: cartItem.quantity ?? 0,
                        onAdd: () => CartController.to.setQuantity(
                          isIncrement: true,
                          index: index,
                        ),
                        onRemove: () => CartController.to.setQuantity(
                          isIncrement: false,
                          index: index,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
