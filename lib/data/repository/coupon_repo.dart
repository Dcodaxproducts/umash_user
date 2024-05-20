import 'package:http/http.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/utils/app_constants.dart';

class CouponRepo {
  final ApiClient apiClient;
  CouponRepo({required this.apiClient});

  Future<Response?> getCouponList() async =>
      await apiClient.getData(AppConstants.couponUri);

  Future<Response?> applyCoupon(String couponCode) async =>
      await apiClient.getData('${AppConstants.couponApplyUri}$couponCode');
}
