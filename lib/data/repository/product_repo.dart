import 'package:http/http.dart';
import 'package:umash_user/data/api/api_client.dart';
import 'package:umash_user/data/model/body/review_body_model.dart';
import 'package:umash_user/utils/app_constants.dart';

class ProductRepo {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response?> getLatestProductList(String offset) async =>
      await apiClient.getData(
        '${AppConstants.latestProductUri}?limit=50&&offset=$offset',
      );

  Future<Response?> getPopularProductList(String offset, String type) async =>
      await apiClient.getData(
        '${AppConstants.popularProductUri}?limit=12&&offset=$offset&product_type=$type',
      );

  Future<Response?> submitReview(ReviewBody reviewBody) async =>
      await apiClient.postData(
        AppConstants.reviewUri,
        reviewBody.toJson(),
      );

  Future<Response?> submitDeliveryManReview(ReviewBody reviewBody) async =>
      await apiClient.postData(
        AppConstants.deliverManReviewUri,
        reviewBody.toJson(),
      );
}
