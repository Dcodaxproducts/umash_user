import 'package:umash_user/common/snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  static void checkConnectivity(GlobalKey<ScaffoldMessengerState> globalKey) {
    bool firstTime = true;
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : globalKey.currentState?.hideCurrentSnackBar();
        showToast(
          isNotConnected ? 'no_connection' : 'connected',
          success: !isNotConnected,
        );
      }
      firstTime = false;
    });
  }
}
