import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/controller/spash_controller.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/images.dart';
import 'package:umash_user/view/base/animations/animated_widget.dart';
import 'package:umash_user/view/screens/welcome/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;
  SplashController get _splashController => SplashController.find;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged?.cancel();
  }

  init() {
    bool firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        showToast(
          isNotConnected ? 'No Connection' : 'Connected',
          success: !isNotConnected,
        );
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _splashController.initData();
    _route();
  }

  void _route() {
    Timer(const Duration(seconds: 3), () {
      launchScreen(const WelcomeScreen(), pushAndRemove: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: secondaryColor,
        child: Center(
          child: CustomAnimatedWidget(
            child: Image.asset(
              Images.logo,
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
