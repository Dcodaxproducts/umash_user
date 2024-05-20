import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umash_user/controller/splash_controller.dart';
import 'package:umash_user/data/model/body/cart_model.dart';
import 'package:umash_user/utils/app_constants.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<CartModel> getCartList() {
    List<String>? carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    }
    List<CartModel> cartList = [];
    for (var cart in carts!) {
      CartModel cartModel = CartModel.fromJson(jsonDecode(cart));
      cartModel.product!.image =
          '${SplashController.to.configModel!.baseUrls!.productImageUrl}/${cartModel.product!.image!.split('/').last}';
      cartList.add(cartModel);
    }
    return cartList;
  }

  void addToCartList(List<CartModel?> cartProductList) {
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      carts.add(jsonEncode(cartModel));
    }
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }
}
