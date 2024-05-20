class OrderModel {
  int? id;
  double? orderAmount;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;
  int? detailsCount;
  String? orderType;
  String? deliveryTime;
  String? deliveryDate;

  OrderModel({
    this.id,
    this.orderAmount,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
    this.detailsCount,
    this.orderType,
    this.deliveryTime,
    this.deliveryDate,
  });

  // from json
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        orderAmount: json['order_amount'].toDouble(),
        paymentStatus: json['payment_status'],
        orderStatus:
            json['order_status'] == 'cooking' || json['order_status'] == 'done'
                ? 'processing'
                : json['order_status'],
        paymentMethod: json['payment_method'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        detailsCount: json['details_count'],
        orderType: json['order_type'],
        deliveryTime: json['delivery_time'],
        deliveryDate: json['delivery_date'],
      );
}
