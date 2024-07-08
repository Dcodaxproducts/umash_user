import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/controller/category_controller.dart';
import 'package:umash_user/controller/location_controller.dart';
import 'package:umash_user/controller/product_controller.dart';
import 'package:umash_user/controller/wishlist_controller.dart';
import 'package:umash_user/view/base/confirmation_dialog.dart';
import 'package:umash_user/view/screens/cart/cart.dart';
import 'package:umash_user/view/screens/home/home.dart';
import 'package:umash_user/view/screens/profile/profile.dart';
import 'package:umash_user/view/screens/wishlist/wishlist.dart';
import '../../../controller/profile_controller.dart';
import '../order/order.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static Future<dynamic> loadData({bool reload = true}) async {
    if (reload) {
      CartController.to.getCartData();
    }
    List<Future> futures = [
      CategoryController.to.getCategoryList(),
      ProductController.to.getLatestProductList(reload, '1'),
      ProductController.to.getPopularProductList(reload, '1'),
      // BannerController.to.getBannerList(reload),
    ];
    if (reload) {
      if (AuthController.to.isLoggedIn) {
        futures.add(ProfileController.to.getUserInfo());
        futures.add(LocationController.to.initAddressList());
        futures.add(WishListController.to.initWishList());
      }
    }
    return await Future.wait(futures);
  }

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    DashboardScreen.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else {
          showConfirmationDialog(
            title: 'Close App',
            subtitle: 'Are you sure you want to close the app?',
            actionText: 'Close',
            onAccept: () => exit(0),
          );
        }
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _screens[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          elevation: 32,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.heart),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: GetBuilder<CartController>(builder: (cart) {
                return cart.cartList.isEmpty
                    ? const Icon(Iconsax.shopping_bag)
                    : Stack(
                        children: [
                          const Icon(Iconsax.shopping_bag),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 7.sp,
                              backgroundColor: Colors.red,
                              child: Text(
                                cart.cartList.length.toString(),
                                style: TextStyle(fontSize: 8.sp),
                              ),
                            ),
                          ),
                        ],
                      );
              }),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.dcube),
              label: 'Orders',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: 'User',
            ),
          ],
        ),
      ),
    );
  }
}
