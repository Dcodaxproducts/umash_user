class CouponModel {
  int? id;
  String? title;
  String? code;
  String? startDate;
  String? expireDate;
  double? minPurchase;
  double? maxDiscount;
  double? discount;
  String? discountType;
  int? status;
  String? createdAt;
  String? updatedAt;

  CouponModel({
    this.id,
    this.title,
    this.code,
    this.startDate,
    this.expireDate,
    this.minPurchase,
    this.maxDiscount,
    this.discount,
    this.discountType,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // from json
  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        code: json['code'] as String?,
        startDate: json['start_date'] as String?,
        expireDate: json['expire_date'] as String?,
        minPurchase: json['min_purchase'].toDouble(),
        maxDiscount: json['max_discount'].toDouble(),
        discount: json['discount'].toDouble(),
        discountType: json['discount_type'] as String?,
        status: json['status'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'code': code,
        'start_date': startDate,
        'expire_date': expireDate,
        'min_purchase': minPurchase,
        'max_discount': maxDiscount,
        'discount': discount,
        'discount_type': discountType,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
