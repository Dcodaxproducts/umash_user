import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/data/model/response/coupon_model.dart';
import 'package:umash_user/data/repository/coupon_repo.dart';

class CouponController extends GetxController implements GetxService {
  final CouponRepo couponRepo;
  CouponController({required this.couponRepo});
  static CouponController get to => Get.find<CouponController>();

  List<CouponModel>? _couponList;
  CouponModel? _coupon;
  double? _discount = 0.0;
  String? _code = '';
  bool _isLoading = false;

  CouponModel? get coupon => _coupon;
  double? get discount => _discount;
  String? get code => _code;
  bool get isLoading => _isLoading;
  List<CouponModel>? get couponList => _couponList;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> getCouponList() async {
    http.Response? response = await couponRepo.getCouponList();
    if (response != null) {
      _couponList = [];
      List<dynamic> data = jsonDecode(response.body);
      for (var category in data) {
        _couponList!.add(CouponModel.fromJson(category));
      }
      update();
    }
  }

  Future<double?> applyCoupon(String coupon, double order) async {
    isLoading = true;
    http.Response? response = await couponRepo.applyCoupon(coupon);
    if (response != null) {
      _coupon = CouponModel.fromJson(jsonDecode(response.body));
      _code = _coupon!.code;
      if (_coupon!.minPurchase != null && _coupon!.minPurchase! <= order) {
        if (_coupon!.discountType == 'percent') {
          if (_coupon!.maxDiscount != null && _coupon!.maxDiscount != 0) {
            _discount =
                (_coupon!.discount! * order / 100) < _coupon!.maxDiscount!
                    ? (_coupon!.discount! * order / 100)
                    : _coupon!.maxDiscount;
          } else {
            _discount = _coupon!.discount! * order / 100;
          }
        } else {
          if (_coupon!.maxDiscount != null) {
            _discount = _coupon!.discount;
          }
          _discount = _coupon!.discount;
        }
      } else {
        _discount = 0.0;
      }
    } else {
      _discount = 0.0;
    }
    isLoading = false;
    return _discount;
  }

  void removeCouponData(bool notify) {
    _coupon = null;
    _isLoading = false;
    _discount = 0.0;
    _code = '';
    if (notify) {
      update();
    }
  }
}
