// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/data/model/response/config_model.dart';
import 'package:umash_user/data/model/response/distance_model.dart';
import 'package:umash_user/data/repository/location_repo.dart';
import 'package:umash_user/view/base/permission_dialog.dart';
import '../data/model/response/address_model.dart';
import '../data/model/response/response_model.dart';
import '../helper/navigation.dart';
import '../theme/maps.dart';
import '../utils/app_constants.dart';
import 'auth_controller.dart';
import 'order_controller.dart';
import 'splash_controller.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});
  static LocationController get to => Get.find<LocationController>();

  int? _branchId;
  List<AddressModel> _addressList = [];

  int? get branchId => _branchId;
  List<AddressModel> get addressList => _addressList;

  set branchId(int? value) {
    _branchId = value;
    update();
  }

  void checkPermission(Function callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const PermissionDialog(),
      );
    } else {
      callback();
    }
  }

  void getCurrentPosition(Function(Position position) callback,
      {bool isLoading = false}) {
    checkPermission(() async {
      if (isLoading) {
        showLoading();
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (isLoading) {
        dismiss();
      }
      callback(position);
    });
  }

  Future<ResponseModel?> initAddressList({bool setLocation = false}) async {
    if (!AuthController.to.isLoggedIn) return null;
    ResponseModel? responseModel;
    http.Response? response = await locationRepo.getAllAddress();
    if (response != null) {
      _addressList = [];
      List<dynamic> addresses = jsonDecode(response.body);
      for (var address in addresses) {
        addressList.add(
          AddressModel.fromJson(address),
        );
      }
      if (setLocation) {
        OrderController.to.address = addressList.first;
      }
      responseModel = successResponse;
    }
    update();
    return responseModel;
  }

  // add new address
  Future<ResponseModel> addAddress(AddressModel addressModel,
      {bool setLocation = false}) async {
    showLoading();

    http.Response? response = await locationRepo.addAddress(addressModel);
    if (response != null) {
      initAddressList(setLocation: setLocation);
      showToast('Address added successfully', success: true);
      return successResponse;
    } else {
      return failedResponse;
    }
  }

  // for address update screen
  Future<ResponseModel> updateAddress(
      {required AddressModel addressModel}) async {
    showLoading();

    http.Response? response = await locationRepo.updateAddress(addressModel);
    ResponseModel responseModel;
    if (response != null) {
      initAddressList();
      showToast('address_updated_successfully'.tr, success: true);
      responseModel = successResponse;
    } else {
      responseModel = failedResponse.copyWith(
        message: getError(jsonDecode(response!.body)),
      );
    }
    update();
    return responseModel;
  }

  // delete usser address
  void deleteUserAddressByID(int? id) async {
    showLoading();
    http.Response? response = await locationRepo.removeAddressByID(id);
    if (response != null) {
      addressList.removeWhere((address) => address.id == id);
      showToast('address_deleted_successfully'.tr, success: true);
    }
    update();
  }

  int inServiceArea(LatLng latlng) {
    List<Branches?> branches = SplashController.to.configModel!.branches!;

    bool isAvailable = branches.length == 1 &&
        (branches[0]!.latitude == null || branches[0]!.latitude!.isEmpty);

    int branchId = -1;
    if (!isAvailable) {
      for (Branches? branch in branches) {
        double distance = Geolocator.distanceBetween(
              double.parse(branch!.latitude!),
              double.parse(branch.longitude!),
              latlng.latitude,
              latlng.longitude,
            ) /
            1000;
        if (distance < branch.coverage!) {
          isAvailable = true;
          branchId = branch.id!;
          break;
        }
      }
    }
    if (isAvailable) {
      _branchId = branchId;
      return branchId;
    } else {
      showToast('service_not_available'.tr);
      return branchId;
    }
  }

  pickLocation(Function(LatLng latLng, PickResult result) onPick) =>
      launchScreen(PlacePicker(
        useCurrentLocation: true,
        selectInitialPosition: true,
        apiKey: AppConstants.API_KEY,
        initialPosition: const LatLng(31.5204, 74.3587),
        onMapCreated: (controller) {
          controller.setMapStyle(MAPS_THEME);
        },
        onPlacePicked: (result) {
          pop();
          LatLng latlng = LatLng(
            result.geometry!.location.lat,
            result.geometry!.location.lng,
          );
          onPick(latlng, result);
        },
      ));

  Future<String> getFormattedAddress(LatLng latLng) async {
    http.Response? response = await locationRepo.getAddressFromGeocode(latLng);
    if (response != null) {
      Map map = jsonDecode(response.body);
      return map['results'][0]['formatted_address'].toString();
    } else {
      return '';
    }
  }

  Future<double?> getDistanceInMeter(LatLng originLatLng) async {
    double distance = -1;
    Branches branch = SplashController.to.configModel!.branches!
        .where((e) => e.id == _branchId)
        .first;
    LatLng destinationLatLng = LatLng(
      double.parse(branch.latitude!),
      double.parse(branch.longitude!),
    );
    http.Response? response =
        await locationRepo.getDistanceInMeter(originLatLng, destinationLatLng);
    try {
      if (response != null) {
        distance = DistanceModel.fromJson(jsonDecode(response.body))
                .rows![0]
                .elements![0]
                .distance!
                .value! /
            1000;
      } else {
        distance = getDistanceBetween(originLatLng, destinationLatLng) / 1000;
      }
    } catch (e) {
      distance = getDistanceBetween(originLatLng, destinationLatLng) / 1000;
    }
    return distance;
  }

  double getDistanceBetween(LatLng startLatLng, LatLng endLatLng) {
    return Geolocator.distanceBetween(
      startLatLng.latitude,
      startLatLng.longitude,
      endLatLng.latitude,
      endLatLng.longitude,
    );
  }
}
