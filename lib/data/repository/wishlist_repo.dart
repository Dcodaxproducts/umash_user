import 'package:http/http.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class WishListRepo {
  final ApiClient apiClient;

  WishListRepo({required this.apiClient});

  Future<Response?> getWishList() async => await apiClient.getData(
        AppConstants.wishListGetUri,
      );

  Future<Response?> addWishList(int? productID) async => await apiClient
      .postData(AppConstants.addWishListUri, {'product_id': productID});

  Future<Response?> removeWishList(int? productID) async =>
      await apiClient.postData(
        AppConstants.removeWishListUri,
        {'product_id': productID, '_method': 'delete'},
      );
}
