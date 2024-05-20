import 'package:umash_user/controller/splash_controller.dart';

class ProductModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Product>? products;

  ProductModel({
    this.limit,
    this.offset,
    this.products,
    this.totalSize,
  });

  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        limit: json["limit"].toString(),
        offset: json["offset"].toString(),
        totalSize: json["total_size"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  // to json
  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "total_size": totalSize,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? name;
  String? description;
  String? image;
  double? price;
  List<Variation>? variations;
  List<AddOns>? addOns;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<CategoryId>? categoryIds;
  double? discount;
  String? discountType;
  String? taxType;
  int? setMenu;
  List<Rating>? rating;
  BranchProduct? branchProduct;
  ReceipeMaker? receipeMaker;
  List<Tag>? tags;
  String? cookingTime;

  Product({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.variations,
    this.addOns,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryIds,
    this.discount,
    this.discountType,
    this.taxType,
    this.setMenu,
    this.rating,
    this.branchProduct,
    this.receipeMaker,
    this.tags,
    this.cookingTime,
  });

  // from json
  factory Product.fromJson(Map<String, dynamic> json) {
    double price = double.parse(json["price"].toString());
    String discountType = json["discount_type"];
    double discount = double.parse(json["discount"].toString());
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"] == null
          ? null
          : '${SplashController.to.configModel!.baseUrls!.productImageUrl!}/${json["image"]}',
      price: price,
      variations: json["variations"] == null
          ? []
          : List<Variation>.from(
              json["variations"].map((x) => Variation.fromJson(x))),
      addOns: json["add_ons"] == null
          ? []
          : List<AddOns>.from(json["add_ons"].map((x) => AddOns.fromJson(x))),
      availableTimeStarts: json["available_time_starts"],
      availableTimeEnds: json["available_time_ends"],
      status: json["status"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      categoryIds: json["category_ids"] == null
          ? []
          : List<CategoryId>.from(
              json["category_ids"].map((x) => CategoryId.fromJson(x))),
      discount: discount,
      discountType: discountType,
      taxType: json["tax_type"],
      setMenu: json["set_menu"],
      rating: json["rating"] == null
          ? null
          : List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
      branchProduct: json["branch_product"] == null
          ? null
          : BranchProduct.fromJson(json["branch_product"]),
      receipeMaker: json["recipe_maker"] == null
          ? null
          : ReceipeMaker.fromJson(json["recipe_maker"]),
      tags: json["tags"] == null
          ? []
          : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      cookingTime: json["cooking_time"],
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
        "add_ons": List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "available_time_starts": availableTimeStarts,
        "available_time_ends": availableTimeEnds,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category_ids": List<dynamic>.from(categoryIds!.map((x) => x.toJson())),
        "discount": discount,
        "discount_type": discountType,
        "tax_type": taxType,
        "set_menu": setMenu,
        "rating": rating == null
            ? null
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
        "branch_product": branchProduct?.toJson(),
        "recipe_maker": receipeMaker?.toJson(),
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class BranchProduct {
  int? id;
  int? productId;
  int? branchId;
  double? price;
  bool? isAvailable;
  List<Variation>? variations;
  double? discount;
  String? discountType;

  BranchProduct({
    this.id,
    this.productId,
    this.branchId,
    this.isAvailable,
    this.variations,
    this.price,
    this.discount,
    this.discountType,
  });

  // from json
  factory BranchProduct.fromJson(Map<String, dynamic> json) => BranchProduct(
        id: json["id"],
        productId: json["product_id"],
        branchId: json["branch_id"],
        price: double.parse(json["price"].toString()),
        isAvailable: json["is_available"] == 1 ? true : false,
        variations: List<Variation>.from(
            json["variations"].map((x) => Variation.fromJson(x))),
        discount: double.parse(json["discount"].toString()),
        discountType: json["discount_type"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "branch_id": branchId,
        "price": price,
        "is_available": isAvailable,
        "variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
        "discount": discount,
        "discount_type": discountType,
      };
}

class VariationValue {
  String? label;
  double? optionPrice;

  VariationValue({this.label, this.optionPrice});

  // from json
  factory VariationValue.fromJson(Map<String, dynamic> json) => VariationValue(
        label: json["label"],
        optionPrice: double.parse(json["optionPrice"].toString()),
      );

  // to json
  Map<String, dynamic> toJson() => {
        "label": label,
        "optionPrice": optionPrice,
      };
}

class Variation {
  String? name;
  int? min;
  int? max;
  bool? isRequired;
  List<VariationValue>? variationValues;

  Variation({
    this.name,
    this.min,
    this.max,
    this.isRequired,
    this.variationValues,
  });

  // from json
  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        name: json["name"],
        min: int.parse(json["min"].toString()),
        max: int.parse(json["max"].toString()),
        isRequired: json["required"] is String
            ? (json["required"] == 'off' ? false : true)
            : json["required"],
        variationValues: json["values"] == null
            ? []
            : List<VariationValue>.from(
                json["values"].map((x) => VariationValue.fromJson(x))),
      );

  // to json
  Map<String, dynamic> toJson() => {
        "name": name,
        "min": min,
        "max": max,
        "required": isRequired,
        "values": List<dynamic>.from(variationValues!.map((x) => x.toJson())),
      };
}

class AddOns {
  int? id;
  String? name;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? image;

  AddOns({
    this.id,
    this.name,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  // from json
  factory AddOns.fromJson(Map<String, dynamic> json) => AddOns(
        id: json["id"],
        name: json["name"],
        price: double.parse(json["price"].toString()),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        image: json["image"] == null
            ? null
            : '${SplashController.to.configModel!.baseUrls!.addonsUrl!}/${json["image"]}',
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class CategoryId {
  String? id;

  CategoryId({this.id});

  // from json
  factory CategoryId.fromJson(Map<String, dynamic> json) =>
      CategoryId(id: json["id"]);

  // to json
  Map<String, dynamic> toJson() => {"id": id};
}

class ChoiceOption {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOption({
    this.name,
    this.title,
    this.options,
  });

  // from json
  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
        name: json["name"],
        title: json["title"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  // to json
  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "options": List<dynamic>.from(options!.map((x) => x)),
      };
}

class Rating {
  String? average;
  int? productId;

  Rating({
    this.average,
    this.productId,
  });

  // factory
  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json["average"],
        productId: json["product_id"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "average": average,
        "product_id": productId,
      };
}

class ReceipeMaker {
  int? id;
  String? fname;
  String? lname;
  String? image;

  ReceipeMaker({
    this.id,
    this.fname,
    this.lname,
    this.image,
  });

  // from json
  factory ReceipeMaker.fromJson(Map<String, dynamic> json) => ReceipeMaker(
        id: json["id"],
        fname: json["f_name"],
        lname: json["l_name"],
        image: json["image"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "lname": lname,
        "image": image,
      };
}

class Tag {
  int? id;
  String? tag;

  Tag({
    this.id,
    this.tag,
  });

  // from json
  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        tag: json["tag"],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
      };
}
