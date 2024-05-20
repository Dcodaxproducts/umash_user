class ReviewBody {
  String? productId;
  String? deliveryManId;
  String? comment;
  String? rating;
  String? orderId;

  ReviewBody({
    this.productId,
    this.deliveryManId,
    this.comment,
    this.rating,
    this.orderId,
  });

  // from json
  factory ReviewBody.fromJson(Map<String, dynamic> json) => ReviewBody(
        productId: json['product_id'],
        deliveryManId: json['delivery_man_id'],
        comment: json['comment'],
        rating: json['rating'],
        orderId: json['order_id'],
      );

  // to json
  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "delivery_man_id": deliveryManId,
        "comment": comment,
        "rating": rating,
        "order_id": orderId,
      };
}
