import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/data/model/payment_method.dart';
import 'package:umash_user/data/model/response/config_model.dart';
import 'package:umash_user/data/model/response/policy_model.dart';
import 'package:umash_user/data/repository/splash_repo.dart';
import 'package:umash_user/helper/date_converter.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  // instance
  static SplashController get to => Get.find<SplashController>();

  ConfigModel? _configModel;
  final DateTime _currentTime = DateTime.now();
  PolicyModel? _policyModel;

  ConfigModel? get configModel => _configModel;
  DateTime get currentTime => _currentTime;
  PolicyModel? get policyModel => _policyModel;

  set configModel(ConfigModel? configModel) {
    _configModel = configModel;
    update();
  }

  set policyModel(PolicyModel? policyModel) {
    _policyModel = policyModel;
    update();
  }

  Future<bool> initConfig() async {
    http.Response? response = await splashRepo.getConfig();
    bool isSuccess;
    initSharedData();
    if (response != null) {
      var body = jsonDecode(response.body);
      _configModel = ConfigModel.fromJson(body);
      isSuccess = true;

      // set payment method
      if (_configModel!.cashOnDelivery == 'false') {
        paymentMethodList.removeWhere((e) => e.value == 'cash_on_delivery');
      }
      if (_configModel!.digitalPayment == 'false') {
        paymentMethodList.removeWhere((e) => e.value == 'digital_payment');
      }
      if (!_configModel!.walletPayment!) {
        paymentMethodList.removeWhere((e) => e.value == 'wallet_payment');
      }
      update();
    } else {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<bool> initSharedData() => splashRepo.initSharedData();

  Future<bool> removeSharedData() => splashRepo.removeSharedData();

  Future<bool> getPolicyPage() async {
    http.Response? response = await splashRepo.getPolicyPage();
    bool isSuccess;
    if (response != null) {
      _policyModel = PolicyModel.fromJson(jsonDecode(response.body));
      isSuccess = true;
      update();
    } else {
      isSuccess = false;
    }
    return isSuccess;
  }

  Future<void> saveFirstTime() async => await splashRepo.saveFirstTime();

  bool get getFirstTime => splashRepo.getFirstTime();

  bool isRestaurantClosed(bool today) {
    DateTime date = DateTime.now();
    if (!today) {
      date = date.add(const Duration(days: 1));
    }
    int weekday = date.weekday;
    if (weekday == 7) {
      weekday = 0;
    }
    for (int index = 0;
        index < _configModel!.restaurantScheduleTime!.length;
        index++) {
      if (weekday.toString() ==
          _configModel!.restaurantScheduleTime![index].day) {
        return false;
      }
    }
    return true;
  }

  bool isRestaurantOpenNow() {
    if (isRestaurantClosed(true)) {
      return false;
    }
    int weekday = DateTime.now().weekday;
    if (weekday == 7) {
      weekday = 0;
    }
    for (int index = 0;
        index < _configModel!.restaurantScheduleTime!.length;
        index++) {
      if (weekday.toString() ==
              _configModel!.restaurantScheduleTime![index].day &&
          DateConverter.isAvailable(
            _configModel!.restaurantScheduleTime![index].openingTime,
            _configModel!.restaurantScheduleTime![index].closingTime,
          )) {
        return true;
      }
    }
    return false;
  }
}
