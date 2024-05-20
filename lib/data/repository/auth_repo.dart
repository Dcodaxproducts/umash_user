import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/data/model/body/social_login_model.dart';
import 'package:umash_user/data/model/response/signup_model.dart';
import 'package:umash_user/utils/app_constants.dart';

class AuthRepo {
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response?> registration(SignUpModel signUpModel) async =>
      await apiClient.postData(
        AppConstants.REGISTER_URI,
        signUpModel.toJson(),
      );

  Future<Response?> login(
          {required String email, required String password}) async =>
      await apiClient.postData(
        AppConstants.LOGIN_URI,
        {"email": email, "password": password},
      );

  Future<Response?> updateToken() async {
    try {
      String deviceToken;
      await FirebaseMessaging.instance.requestPermission();
      deviceToken = await _getDeviceToken();
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      return await apiClient.postData(
        AppConstants.TOKEN_URI,
        {"_method": "put", "cm_firebase_token": deviceToken},
      );
    } catch (e) {
      return showToast('Failed to update token');
    }
  }

  // for forgot password
  Future<Response?> forgetPassword(String email) async =>
      await apiClient.postData(
        AppConstants.FORGET_PASSWORD_URI,
        {
          "email_or_phone": email,
          "email": email,
        },
      );

  Future<Response?> verifyToken(String email, String token) async {
    Map<String, dynamic> body = {
      "email_or_phone": email,
      "email": email,
      "reset_token": token,
    };
    debugPrint(body.toString());
    return await apiClient.postData(
      AppConstants.VERIFY_TOKEN_URI,
      body,
    );
  }

  Future<Response?> resetPassword(String mail, String resetToken,
      String password, String confirmPassword) async {
    Map<String, dynamic> body = {
      "_method": "put",
      "reset_token": resetToken,
      "password": password,
      "confirm_password": confirmPassword,
      "email_or_phone": mail,
      "email": mail
    };
    debugPrint(body.toString());
    return await apiClient.postData(
      AppConstants.RESET_PASSWORD_URI,
      body,
    );
  }

  // for verify email number
  Future<Response?> checkEmail(String email) async =>
      await apiClient.postData(AppConstants.CHECK_EMAIL_URI, {"email": email});

  Future<Response?> verifyEmail(String email, String token) async =>
      await apiClient.postData(
          AppConstants.VERIFY_EMAIL_URI, {"email": email, "token": token});

  //verify phone number
  Future<Response?> checkPhone(String phone) async => await apiClient.postData(
        AppConstants.CHECK_PHONE_URI + phone,
        {"phone": phone},
      );

  Future<Response?> verifyPhone(String phone, String token) async =>
      await apiClient.postData(AppConstants.VERIFY_PHONE_URI,
          {"phone": phone.trim(), "token": token});

  // for  user token
  Future<void> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(
        token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
    await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() =>
      sharedPreferences.getString(AppConstants.TOKEN) ?? "";

  bool get isLoggedIn => sharedPreferences.containsKey(AppConstants.TOKEN);

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.CART_LIST);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    await sharedPreferences.remove(AppConstants.SEARCH_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      rethrow;
    }
  }

  String getUserEmail() =>
      sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";

  String getUserPassword() =>
      sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<Response?> deleteUser() async =>
      await apiClient.deleteData(AppConstants.CUSTOMER_REMOVE);

  Future<Response?> socialLogin(SocialLoginModel socialLogin) async =>
      await apiClient.postData(
        AppConstants.socialLogin,
        socialLogin.toJson(),
      );

  Future<String> _getDeviceToken() async {
    String? deviceToken;
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      showToast('Failed to get token');
    }
    debugPrint('--------Device Token---------- $deviceToken');
    return deviceToken ?? '';
  }
}
