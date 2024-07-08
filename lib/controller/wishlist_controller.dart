import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../common/snackbar.dart';
import '../data/model/response/product_model.dart';
import '../data/repository/wishlist_repo.dart';
import 'auth_controller.dart';

class WishListController extends GetxController implements GetxService {
  final WishListRepo wishListRepo;
  WishListController({required this.wishListRepo});
  static WishListController get to => Get.find<WishListController>();

  List<Product> _wishList = [];
  List<int?> _wishIdList = [];

  List<Product> get wishList => _wishList;
  List<int?> get wishIdList => _wishIdList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    update();
  }

  void addToWishList(Product product) async {
    _wishList.add(product);
    _wishIdList.add(product.id);
    update();
    http.Response? response = await wishListRepo.addWishList(product.id);
    if (response != null) {
      showToast('Added to wishlist'.tr, success: true);
    } else {
      _wishList.remove(product);
      _wishIdList.remove(product.id);
    }
    update();
  }

  void removeFromWishList(Product product) async {
    _wishList.removeAt(_wishIdList.indexOf(product.id));
    _wishIdList.remove(product.id);
    update();
    http.Response? response = await wishListRepo.removeWishList(product.id);
    if (response != null) {
      showToast('Deleted from wishlist'.tr, success: true);
    } else {
      _wishList.add(product);
      _wishIdList.add(product.id);
    }
    update();
  }

  Future<void> initWishList() async {
    if (!AuthController.to.isLoggedIn) return;
    _wishList = [];
    _wishIdList = [];
    isLoading = true;
    http.Response? response = await wishListRepo.getWishList();
    if (response != null) {
      _wishList = [];
      _wishIdList = [];
      _wishList
          .addAll(ProductModel.fromJson(jsonDecode(response.body)).products!);
      for (int i = 0; i < _wishList.length; i++) {
        _wishIdList.add(_wishList[i].id);
      }
    }
    isLoading = false;
  }
}
