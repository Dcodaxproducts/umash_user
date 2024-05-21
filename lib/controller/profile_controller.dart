import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../common/snackbar.dart';
import '../data/model/response/response_model.dart';
import '../data/model/response/userinfo_model.dart';
import '../data/repository/profile_repo.dart';
import 'auth_controller.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileController({required this.profileRepo});

  static ProfileController get to => Get.find<ProfileController>();

  UserInfoModel? _userInfoModel;

  UserInfoModel? get userInfoModel => _userInfoModel;

  Future<void> getUserInfo() async {
    if (!AuthController.to.isLoggedIn) return;
    http.Response? response = await profileRepo.getUserInfo();
    if (response != null) {
      _userInfoModel = UserInfoModel.fromJson(jsonDecode(response.body));
    }
    update();
  }

  Future<ResponseModel> updateUserInfo(
      {UserInfoModel? updateUserModel, String? password, XFile? image}) async {
    showLoading();
    ResponseModel responseModel;
    http.Response? response = await profileRepo.updateProfile(
      userInfoModel: updateUserModel,
      password: password,
      image: image,
    );
    if (response != null) {
      _userInfoModel = UserInfoModel.fromJson(jsonDecode(response.body));
      responseModel = successResponse;
      if (image != null) {
        showToast('image_updated_successfully'.tr, success: true);
      } else {
        showToast('profile_updated_successfully'.tr, success: true);
      }
    } else {
      responseModel = failedResponse;
    }
    update();
    return responseModel;
  }

  removeUser() {
    _userInfoModel = null;
    update();
  }
}
