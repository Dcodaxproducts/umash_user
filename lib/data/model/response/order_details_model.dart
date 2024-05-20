import 'dart:convert';

import 'package:umash_user/controller/splash_controller.dart';

import 'product_model.dart';

class OrderDetailsModel {
  int? id;
  int? userId;
  double? orderAmount;
  num? couponDiscountAmount;
  String? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  num? totalTaxAmount;
  String? paymentMethod;
  String? transactionReference;
  int? deliveryAddressId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? checked;
  num? deliveryManId;
  double? deliveryCharge;
  String? orderNote;
  String? couponCode;
  String? orderType;
  int? branchId;
  DateTime? deliveryDate;
  String? deliveryTime;
  String? extraDiscount;
  DeliveryAddress? deliveryAddress;
  num? preparationTime;
  num? tableId;
  num? numberOfPeople;
  num? tableOrderId;
  String overallTax;
  List<Detail> details;
  DeliveryMan? deliveryMan;
  String? orderConfirmationImage;

  OrderDetailsModel({
    required this.id,
    required this.userId,
    required this.orderAmount,
    required this.couponDiscountAmount,
    required this.couponDiscountTitle,
    required this.paymentStatus,
    required this.orderStatus,
    required this.totalTaxAmount,
    required this.paymentMethod,
    required this.transactionReference,
    required this.deliveryAddressId,
    required this.createdAt,
    required this.updatedAt,
    required this.checked,
    required this.deliveryManId,
    required this.deliveryCharge,
    required this.orderNote,
    required this.couponCode,
    required this.orderType,
    required this.branchId,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.extraDiscount,
    required this.deliveryAddress,
    required this.preparationTime,
    required this.tableId,
    required this.numberOfPeople,
    required this.tableOrderId,
    required this.overallTax,
    required this.details,
    required this.deliveryMan,
    required this.orderConfirmationImage,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"],
        userId: json["user_id"],
        orderAmount: json["order_amount"]?.toDouble(),
        couponDiscountAmount: json["coupon_discount_amount"],
        couponDiscountTitle: json["coupon_discount_title"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        totalTaxAmount: json["total_tax_amount"],
        paymentMethod: json["payment_method"],
        transactionReference: json["transaction_reference"],
        deliveryAddressId: json["delivery_address_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        checked: json["checked"],
        deliveryManId: json["delivery_man_id"],
        deliveryCharge: json["delivery_charge"]?.toDouble(),
        orderNote: json["order_note"],
        couponCode: json["coupon_code"],
        orderType: json["order_type"],
        branchId: json["branch_id"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        deliveryTime: json["delivery_time"],
        extraDiscount: json["extra_discount"],
        deliveryAddress: json["delivery_address"] == null
            ? null
            : DeliveryAddress.fromJson(json["delivery_address"]),
        preparationTime: json["preparation_time"],
        tableId: json["table_id"],
        numberOfPeople: json["number_of_people"],
        tableOrderId: json["table_order_id"],
        overallTax: json["overall_tax"],
        details: json["details"] == null
            ? []
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        deliveryMan: json["delivery_man"] == null
            ? null
            : DeliveryMan.fromJson(json["delivery_man"]),
        orderConfirmationImage: json["order_confirmation_image"] == null
            ? null
            : "${SplashController.to.configModel!.baseUrls!.orderConfirmationImage}/${json["order_confirmation_image"]}",
      );
}

class DeliveryAddress {
  int id;
  String addressType;
  String contactPersonNumber;
  dynamic floor;
  dynamic house;
  dynamic road;
  String address;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  String contactPersonName;

  DeliveryAddress({
    required this.id,
    required this.addressType,
    required this.contactPersonNumber,
    required this.floor,
    required this.house,
    required this.road,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.contactPersonName,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["id"],
        addressType: json["address_type"],
        contactPersonNumber: json["contact_person_number"],
        floor: json["floor"],
        house: json["house"],
        road: json["road"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        contactPersonName: json["contact_person_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_type": addressType,
        "contact_person_number": contactPersonNumber,
        "floor": floor,
        "house": house,
        "road": road,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "contact_person_name": contactPersonName,
      };
}

class Detail {
  int id;
  int productId;
  int orderId;
  num price;
  Product product;
  List<Variation> variation;
  num discountOnProduct;
  String discountType;
  int quantity;
  num taxAmount;
  DateTime createdAt;
  DateTime updatedAt;
  List<int> addOnIds;
  List<int> addOnQtys;
  List<num> addOnTaxes;
  List<num> addOnPrices;
  num addOnTaxAmount;

  Detail({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.price,
    required this.product,
    required this.variation,
    required this.discountOnProduct,
    required this.discountType,
    required this.quantity,
    required this.taxAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.addOnIds,
    required this.addOnQtys,
    required this.addOnTaxes,
    required this.addOnPrices,
    required this.addOnTaxAmount,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        productId: json["product_id"],
        orderId: json["order_id"],
        price: json["price"],
        product: Product.fromJson(json["product_details"]),
        variation: List<Variation>.from(
            json["variation"].map((x) => Variation.fromJson(x))),
        discountOnProduct: json["discount_on_product"]?.toDouble(),
        discountType: json["discount_type"],
        quantity: json["quantity"],
        taxAmount: json["tax_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        addOnIds: List<int>.from(json["add_on_ids"].map((x) => x)),
        addOnQtys: List<int>.from(json["add_on_qtys"].map((x) => x)),
        addOnTaxes:
            List<num>.from(jsonDecode(json["add_on_taxes"]).map((x) => x)),
        addOnPrices:
            List<num>.from(jsonDecode(json["add_on_prices"]).map((x) => x)),
        addOnTaxAmount: json["add_on_tax_amount"],
      );
}

class DeliveryMan {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  List<Rating>? rating;

  DeliveryMan({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.image,
    this.rating,
  });

  // from json
  factory DeliveryMan.fromJson(Map<String, dynamic> json) => DeliveryMan(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        email: json["email"],
        image:
            '${SplashController.to.configModel!.baseUrls!.deliveryManImageUrl}/${json["image"]}',
        rating: json["rating"] == null
            ? []
            : List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
      );
}
