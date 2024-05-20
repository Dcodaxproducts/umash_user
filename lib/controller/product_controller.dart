import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/data/model/body/review_body_model.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/data/repository/product_repo.dart';
import 'package:umash_user/helper/navigation.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});
  static ProductController get to => Get.find<ProductController>();

  // Latest products
  List<Product>? _popularProductList;
  List<Product>? _latestProductList;
  bool _isLoading = false;
  bool _bottomLoading = false;
  int? _popularPageSize;
  int? _latestPageSize;
  List<String> _offsetList = [];
  final bool _seeMoreButtonVisible = true;
  int _latestOffset = 1;
  int popularOffset = 1;
  Product? _product;

  List<Product>? get popularProductList => _popularProductList;
  List<Product>? get latestProductList => _latestProductList;
  bool get isLoading => _isLoading;
  bool get bottomLoading => _bottomLoading;
  int? get popularPageSize => _popularPageSize;
  int? get latestPageSize => _latestPageSize;
  bool get seeMoreButtonVisible => _seeMoreButtonVisible;
  int get latestOffset => _latestOffset;
  Product? get product => _product;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  set bottomLoading(bool value) {
    _bottomLoading = value;
    update();
  }

  set latestOffset(int value) {
    _latestOffset = value;
    update();
  }

  set product(Product? value) {
    _product = value;
    update();
  }

  Future<void> getLatestProductList(bool reload, String offset) async {
    if (reload || offset == '1' || _latestProductList == null) {
      latestOffset = 1;
      _offsetList = [];
      _latestProductList = null;
    }
    if (!_offsetList.contains(offset)) {
      _offsetList = [];
      _offsetList.add(offset);
      http.Response? response = await productRepo.getLatestProductList(offset);
      if (response != null) {
        if (reload || offset == '1' || _latestProductList == null) {
          _latestProductList = [];
        }
        var data = jsonDecode(response.body);
        _latestProductList!.addAll(ProductModel.fromJson(data).products!);
        _latestPageSize = ProductModel.fromJson(data).totalSize;
      } else {
        _latestProductList = [];
      }
    }
    bottomLoading = false;
  }

  Future<void> getPopularProductList(bool reload, String offset,
      {String type = 'all'}) async {
    if (reload || offset == '1') {
      popularOffset = 1;
      _offsetList = [];
      _popularProductList = null;
    }
    isLoading = true;

    if (!_offsetList.contains(offset)) {
      _offsetList = [];
      _offsetList.add(offset);
      http.Response? response =
          await productRepo.getPopularProductList(offset, type);

      if (response != null) {
        if (reload || offset == '1') {
          _popularProductList = [];
        }
        var data = jsonDecode(response.body);
        _popularProductList!.addAll(ProductModel.fromJson(data).products!);
        _popularPageSize = ProductModel.fromJson(data).totalSize;
      } else {
        _popularProductList = [];
      }
    }
    isLoading = false;
  }

  bool isPopular(int productId) {
    if (_popularProductList != null) {
      for (int i = 0; i < _popularProductList!.length; i++) {
        if (_popularProductList![i].id == productId) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> submitReview(ReviewBody reviewBody) async {
    showLoading();
    http.Response? response = await productRepo.submitReview(reviewBody);
    if (response != null) {
      dismiss();
      pop();
      showToast('review_submitted_successfully'.tr, success: true);
    } else {
      dismiss();
    }
  }
}
