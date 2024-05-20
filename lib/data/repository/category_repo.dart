import 'package:http/http.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/utils/app_constants.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response?> getCategoryList() async =>
      await apiClient.getData(AppConstants.CATEGORY_LIST_URI);

  Future<Response?> getSubCategoryList(String parentID) async =>
      await apiClient.getData(
        '${AppConstants.SUB_CATEGORY_LIST_URI}$parentID',
      );

  Future<Response?> getCategoryProductList(
          String? categoryID, String type) async =>
      await apiClient.getData(
          '${AppConstants.CATEGORY_PRODUCT_LIST_URI}$categoryID?product_type=$type');
}
