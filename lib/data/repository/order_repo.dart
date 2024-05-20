// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/data/model/body/place_order_body.dart';
import 'package:umash_user/utils/app_constants.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getOrderList() async =>
      await apiClient.getData(AppConstants.orderListUri);

  Future<Response?> cancelOrder(String orderID) async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderID;
    data['_method'] = 'put';
    return await apiClient.postData(
      AppConstants.orderCancelUri,
      data,
    );
  }

  Future<Response?> updatePaymentMethod(String orderID) async {
    Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderID;
    data['_method'] = 'put';
    data['payment_method'] = 'cash_on_delivery';
    return await apiClient.postData(
      AppConstants.updateMethodUri,
      data,
    );
  }

  Future<Response?> trackOrder(String? orderID) async =>
      await apiClient.getData('${AppConstants.trackUri}$orderID');

  Future<Response?> placeOrder(PlaceOrderBody orderBody) async =>
      await apiClient.postData(
        AppConstants.placeOrderUri,
        orderBody.toJson(),
      );

  Future<Response?> getDeliveryManData(int driverId, int orderId) async =>
      await apiClient.getData(
          '${AppConstants.lastLocationUri}$driverId&order_id=$orderId');

  Future<Uint8List?> downloadImage(String url) async =>
      await apiClient.downloadImage(url);
}
