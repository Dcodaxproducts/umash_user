import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/icons.dart';
import 'package:umash_user/controller/wishlist_controller.dart';
import 'package:umash_user/utils/style.dart';
import '../../../helper/navigation.dart';
import '../home/widgets/product_view_horizontal.dart';
import '../notification/notification_screen.dart';
import '../settings/settings.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: pagePadding,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcon(
                      icon: Iconsax.category,
                      onTap: () => launchScreen(const SettingScreen()),
                    ),
                    Text(
                      'Home',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    CustomIcon(
                      icon: Iconsax.notification,
                      onTap: () => launchScreen(const NotificationScreen()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: GetBuilder<WishListController>(builder: (con) {
            return GridView.builder(
              padding: pagePadding,
              itemCount: con.wishList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0.sp,
                crossAxisSpacing: 16.sp,
                mainAxisSpacing: 16.sp,
              ),
              itemBuilder: (context, index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: FoodWidgetHorizontal(
                    favourite: index.isEven,
                    category: true,
                    product: con.wishList[index],
                  ),
                );
              },
            );
          }))
        ],
      ),
    );
  }
}
