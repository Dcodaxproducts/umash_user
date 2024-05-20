// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/data/model/response/address_model.dart';
import 'package:umash_user/utils/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getAllAddress() async =>
      await apiClient.getData(AppConstants.addressListUri);

  Future<Response?> removeAddressByID(int? id) async =>
      await apiClient.postData(
        '${AppConstants.removeAddressUri}$id',
        {"_method": "delete"},
      );

  Future<Response?> addAddress(AddressModel addressModel) async =>
      await apiClient.postData(
        AppConstants.addAddressUri,
        addressModel.toJson(),
      );

  Future<Response?> updateAddress(AddressModel addressModel) async =>
      await apiClient.postData(
        '${AppConstants.updateAddressUri}${addressModel.id}',
        addressModel.toJson(),
      );

  Future<Response?> getAddressFromGeocode(LatLng latLng) async =>
      await apiClient.getData(
        '${AppConstants.geocodeUri}?lat=${latLng.latitude}&lng=${latLng.longitude}',
        dismis: false,
      );

  Future<Response?> searchLocation(String text) async => await apiClient
      .getData('${AppConstants.searchLocationUri}?search_text=$text');

  Future<Response?> getPlaceDetails(String? placeID) async => await apiClient
      .getData('${AppConstants.placeDetailsUri}?placeid=$placeID');

  Future<Response?> getDistanceInMeter(
          LatLng originLatLng, LatLng destinationLatLng) async =>
      await apiClient.getData(
        '${AppConstants.distanceMatrixUri}'
        '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
        '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}',
      );

  Future<void> saveUserAddress(LocalAdress address) async {
    String userAddress = jsonEncode(address);
    try {
      await sharedPreferences.setString(AppConstants.USER_ADDRESS, userAddress);

      // update header to save branch id
      String? token = sharedPreferences.getString(AppConstants.TOKEN);
      String? languageCode =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
      apiClient.updateHeader(
        token ?? '',
        languageCode,
        branchId: address.branchId,
      );
    } catch (e) {
      rethrow;
    }
  }

  LocalAdress? getUserAddress() {
    String? address = sharedPreferences.getString(AppConstants.USER_ADDRESS);
    if (address != null) {
      LocalAdress useraddress = LocalAdress.fromJson(jsonDecode(address));
      // update header to save branch id
      String? token = sharedPreferences.getString(AppConstants.TOKEN);

      String? languageCode =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
      apiClient.updateHeader(
        token ?? '',
        languageCode,
        branchId: useraddress.branchId,
      );
      return useraddress;
    }
    return null;
  }

  Future<Response?> getNearestBranch(LatLng latLng) async =>
      await apiClient.postData(AppConstants.NEAREST_BRANCH, {
        "latitude": latLng.latitude,
        "longitude": latLng.longitude,
      });
}
