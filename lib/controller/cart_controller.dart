import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/data/model/body/cart_model.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/data/repository/cart_repo.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/view/base/confirmation_dialog.dart';
import 'coupon_controller.dart';
import 'order_controller.dart';
import 'splash_controller.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  static CartController get to => Get.find<CartController>();

  List<CartModel> _cartList = [];
  bool _isCartUpdate = false;

  List<CartModel> get cartList => _cartList;
  bool get isCartUpdate => _isCartUpdate;

  // calculations
  double get itemsPrice {
    double price = 0.0;
    for (var cart in _cartList) {
      price += cart.price! * cart.quantity!;
    }
    return price;
  }

  double get taxAmount {
    if (!SplashController.to.configModel!.taxEnabled) {
      return 0.0;
    } else {
      double taxPercentage = SplashController.to.configModel!.taxPercentage!;
      return subtotalAmount * taxPercentage / 100;
    }
  }

  double get addOnsAmount {
    double addOns = 0.0;
    for (var cart in _cartList) {
      for (var item in cart.addOnIds!) {
        var addon = cart.product!.addOns!.firstWhere((e) => e.id == item.id);
        addOns += addon.price! * item.quantity;
      }
    }
    return addOns;
  }

  double get discountAmount {
    double discount = 0.0;
    for (var cart in _cartList) {
      discount += cart.discountAmount! * cart.quantity!;
    }
    return discount;
  }

  double get subtotalAmount {
    double subtotal = 0.0;
    subtotal = itemsPrice + addOnsAmount - discountAmount;

    return subtotal;
  }

  double get totalAmount {
    double total = 0.0;
    total = subtotalAmount -
        (CouponController.to.discount ?? 0.0) +
        taxAmount +
        OrderController.to.deliveryFee;
    return total;
  }

  double get cartTotal {
    return itemsPrice + addOnsAmount;
  }

  void getCartData() {
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
    update();
  }

  void addToCart(CartModel cartModel, int? index) {
    if (index != null) {
      _cartList.replaceRange(index, index + 1, [cartModel]);
    } else {
      _cartList.add(cartModel);
    }
    cartRepo.addToCartList(_cartList);

    showToast(
      index == null ? 'Added in cart' : 'Updated in cart',
      success: true,
    );
    update();
    pop();
  }

  void setQuantity({
    required bool isIncrement,
    required int index,
  }) {
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity! + 1;
    } else {
      if (_cartList[index].quantity == 1) {
        showDialog(
          context: Get.context!,
          builder: (_) => ConfirmationDialog(
            title: "Remove from Cart?",
            subtitle: 'Are you sure you want to remove this item from cart?',
            actionText: 'Remove',
            onAccept: () {
              pop();
              removeFromCart(index);
            },
          ),
        );
      } else {
        _cartList[index].quantity = _cartList[index].quantity! - 1;
      }
    }
    cartRepo.addToCartList(_cartList);

    update();
  }

  void removeFromCart(int index) {
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    update();
  }

  void removeAddOn(int index, int id) {
    _cartList[index].addOnIds!.removeWhere((e) => e.id == id);
    cartRepo.addToCartList(_cartList);
    update();
  }

  void clearCartList() {
    _cartList = [];
    cartRepo.addToCartList(_cartList);
    update();
  }

  int isExistInCart(int? productID, int? cartIndex) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].product!.id == productID) {
        if ((index == cartIndex)) {
          return -1;
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  int getCartIndex(Product product) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].product!.id == product.id) {
        return index;
      }
    }
    return -1;
  }

  setCartUpdate(bool isUpdate) {
    _isCartUpdate = isUpdate;
    if (_isCartUpdate) {
      update();
    }
  }
}
