import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import '../model/response/userinfo_model.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getUserInfo() async =>
      await apiClient.getData(AppConstants.CUSTOMER_INFO_URI);

  Future<Response?> updateProfile(
      {UserInfoModel? userInfoModel, String? password, XFile? image}) async {
    if (userInfoModel != null) {
      Map<String, String> body = {
        'f_name': userInfoModel.fName!,
        'l_name': userInfoModel.lName!,
      };
      return await apiClient.postData(
        AppConstants.UPDATE_PROFILE_URI,
        body,
      );
    } else {
      return await apiClient.postMultipartData(
        AppConstants.UPDATE_PROFILE_URI,
        [MultipartBody('image', image!)],
      );
    }
  }
}
