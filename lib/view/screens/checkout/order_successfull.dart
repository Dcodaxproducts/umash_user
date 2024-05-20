import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/loading/ripple.dart';

class OrderSuccessScreen extends StatefulWidget {
  final String orderId;
  const OrderSuccessScreen({required this.orderId, super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          IconButton(
            onPressed: pop,
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: Padding(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RipplesAnimation(
              size: 40.sp,
              color: primaryColor,
              child: Icon(
                Icons.check,
                size: 30.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.sp),
            Text(
              'Order Placed',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10.sp),
            Text(
              'Your Order #${widget.orderId} has been placed successfully. You can see the status of your order in the order history section.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.sp),
            const SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: 'Continue Shopping',
                onPressed: pop,
              ),
            )
          ],
        ),
      ),
    );
  }
}
