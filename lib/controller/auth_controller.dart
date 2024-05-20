import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/data/model/body/social_login_model.dart';
import 'package:umash_user/data/model/response/response_model.dart';
import 'package:umash_user/data/model/response/signup_model.dart';
import 'package:umash_user/data/repository/auth_repo.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/view/screens/auth/login.dart';
import 'splash_controller.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  // instance
  static AuthController get to => Get.find<AuthController>();

  String _verificationCode = '';
  bool _isEnableVerificationCode = false;
  bool _isActiveRememberMe = false;

  String get getUserEmail => authRepo.getUserEmail();
  String get getUserPassword => authRepo.getUserPassword();
  String get verificationCode => _verificationCode;
  bool get isEnableVerificationCode => _isEnableVerificationCode;
  bool get isLoggedIn => authRepo.isLoggedIn;
  bool get isActiveRememberMe => _isActiveRememberMe;

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  Future<ResponseModel> registration(SignUpModel signUpModel) async {
    showLoading();
    http.Response? response = await authRepo.registration(signUpModel);
    ResponseModel responseModel;
    if (response != null) {
      Map<String, dynamic> map = jsonDecode(response.body);
      String? token;
      try {
        token = map["token"];
      } catch (e) {
        login(signUpModel.email, signUpModel.password);
      }
      authRepo.saveUserToken(token!);
      await authRepo.updateToken();
      responseModel = successResponse.copyWith(message: map["verification"]);
    } else {
      responseModel = failedResponse;
    }

    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    showLoading();
    http.Response? response =
        await authRepo.login(email: email, password: password);
    ResponseModel responseModel;
    if (response != null) {
      Map map = jsonDecode(response.body);
      String token = map["token"];
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      responseModel = successResponse.copyWith(message: map["verification"]);
    } else {
      responseModel = failedResponse;
    }

    return responseModel;
  }

  Future<ResponseModel> forgetPassword(String email) async {
    showLoading();
    http.Response? response = await authRepo.forgetPassword(email);
    ResponseModel responseModel;
    if (response != null) {
      Map<String, dynamic> body = jsonDecode(response.body);
      responseModel = successResponse.copyWith(message: body["message"]);
    } else {
      responseModel = failedResponse;
    }
    return responseModel;
  }

  Future<void> updateToken() async => await authRepo.updateToken();

  Future<ResponseModel> verifyToken(String email) async {
    showLoading();
    http.Response? response =
        await authRepo.verifyToken(email, _verificationCode);

    ResponseModel responseModel;
    if (response != null) {
      responseModel = successResponse;
    } else {
      responseModel = failedResponse;
    }

    return responseModel;
  }

  Future<ResponseModel> resetPassword(String mail, String resetToken,
      String password, String confirmPassword) async {
    showLoading();
    http.Response? response = await authRepo.resetPassword(
        mail, resetToken, password, confirmPassword);
    ResponseModel responseModel;
    if (response != null) {
      responseModel = successResponse;
    } else {
      responseModel = failedResponse;
    }

    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email) async {
    showLoading();

    http.Response? response =
        await authRepo.verifyEmail(email, _verificationCode);
    ResponseModel responseModel;
    if (response != null) {
      responseModel = successResponse;
    } else {
      responseModel = failedResponse;
    }

    return responseModel;
  }

  updateVerificationCode(String query) {
    if (query.length == 4) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    update();
  }

  Future<bool> clearSharedData() async {
    showLoading();
    bool isSuccess = await authRepo.clearSharedData();
    dismiss();
    return isSuccess;
  }

  Future deleteUser() async {
    showLoading();
    http.Response? response = await authRepo.deleteUser();
    if (response != null) {
      SplashController.to.removeSharedData();
      showToast('your_account_remove_successfully'.tr);
      launchScreen(const LoginScreen(), pushAndRemove: true);
    } else {
      pop();
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  Future<GoogleSignInAuthentication> googleLogin() async {
    GoogleSignInAuthentication auth;
    googleAccount = await _googleSignIn.signIn();
    auth = await googleAccount!.authentication;
    return auth;
  }

  Future socialLogin(SocialLoginModel socialLogin, Function callback) async {
    showLoading();
    http.Response? response = await authRepo.socialLogin(socialLogin);
    if (response != null) {
      Map map = jsonDecode(response.body);
      String? token = '';
      try {
        token = map['token'];
      } catch (e) {
        debugPrint('error ===> $e');
      }
      if (token != null) {
        authRepo.saveUserToken(token);
        await authRepo.updateToken();
      }

      callback(true, token);
      update();
    } else {
      callback(false, '');
      update();
    }
  }

  Future<void> socialLogout() async {
    // DashboardController.to.selectedIndex = 0;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    googleSignIn.disconnect();
    await FacebookAuth.instance.logOut();
    // ProfileController.to.removeUser();
    // DashboardController.to.selectedIndex = 0;
    clearSharedData();
    launchScreen(const LoginScreen(), pushAndRemove: true);
  }
}
