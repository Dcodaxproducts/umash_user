import 'package:umash_user/controller/splash_controller.dart';

class BannerModel {
  int? id;
  String? title;
  String? image;
  int? productId;
  String? createdAt;
  String? updatedAt;
  int? categoryId;

  BannerModel({
    this.id,
    this.title,
    this.image,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  // from json
  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        title: json["title"],
        image: json["image"] == null
            ? null
            : '${SplashController.to.configModel!.baseUrls!.bannerImageUrl}/${json["image"]}',
        productId: json["product_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        categoryId: json["category_id"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "product_id": productId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category_id": categoryId,
      };
}
