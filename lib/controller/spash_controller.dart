import 'package:umash_user/data/repository/splash_repo.dart';
import 'package:get/get.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  // instance
  static SplashController get find => Get.find<SplashController>();

  Future<bool> initSharedData() => splashRepo.initSharedData();

  initData() async {
    await initSharedData();
  }
}
