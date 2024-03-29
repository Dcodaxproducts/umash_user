import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:umash_user/controller/localization_controller.dart';
import 'package:umash_user/controller/spash_controller.dart';
import 'package:umash_user/controller/theme_controller.dart';
import 'package:umash_user/data/model/language.dart';
import 'package:umash_user/data/repository/language_repo.dart';
import 'package:umash_user/data/repository/splash_repo.dart';
import 'package:umash_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // Repository

  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));

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
