import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/controller/category_controller.dart';
import 'package:umash_user/controller/coupon_controller.dart';
import 'package:umash_user/controller/localization_controller.dart';
import 'package:umash_user/controller/order_controller.dart';
import 'package:umash_user/controller/product_controller.dart';
import 'package:umash_user/controller/splash_controller.dart';
import 'package:umash_user/controller/theme_controller.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/data/model/language.dart';
import 'package:umash_user/data/repository/auth_repo.dart';
import 'package:umash_user/data/repository/cart_repo.dart';
import 'package:umash_user/data/repository/category_repo.dart';
import 'package:umash_user/data/repository/coupon_repo.dart';
import 'package:umash_user/data/repository/language_repo.dart';
import 'package:umash_user/data/repository/order_repo.dart';
import 'package:umash_user/data/repository/product_repo.dart';
import 'package:umash_user/data/repository/splash_repo.dart';
import 'package:umash_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.CONFIG_URI, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(
      () => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => CouponRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => CouponController(couponRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
