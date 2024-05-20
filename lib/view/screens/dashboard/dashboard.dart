import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/controller/category_controller.dart';
import 'package:umash_user/controller/product_controller.dart';
import 'package:umash_user/view/screens/cart/cart.dart';
import 'package:umash_user/view/screens/home/home.dart';
import 'package:umash_user/view/screens/orders/orders.dart';
import 'package:umash_user/view/screens/profile/profile.dart';

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
      // WishListController.to.initWishList(),
    ];
    if (reload) {
      if (AuthController.to.isLoggedIn) {
        // futures.add(ProfileController.to.getUserInfo());
        // futures.add(LocationController.to.initAddressList());
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
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    DashboardScreen.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.dcube),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
