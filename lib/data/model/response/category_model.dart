import 'package:umash_user/controller/splash_controller.dart';

class CategoryModel {
  int? id;
  String? name;
  int? parentId;
  int? position;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? bannerImage;

  CategoryModel({
    this.id,
    this.name,
    this.parentId,
    this.position,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.bannerImage,
  });

  // from json
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"] ?? 0,
        position: json["position"] ?? 0,
        status: json["status"] ?? 0,
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        image: json["image"] == null
            ? null
            : "${SplashController.to.configModel!.baseUrls!.categoryImageUrl!}/${json["image"]}",
        bannerImage: json["banner_image"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "position": position,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image": image,
        "banner_image": bannerImage,
      };
}
