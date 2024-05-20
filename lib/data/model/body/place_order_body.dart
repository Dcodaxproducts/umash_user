class PlaceOrderBody {
  List<Cart>? cart;
  double? couponDiscountAmount;
  String? couponDiscountTitle;
  double? orderAmount;
  String? orderType;
  int? deliveryAddressId;
  String? paymentMethod;
  String? orderNote;
  String? couponCode;
  String? deliveryTime;
  String? deliveryDate;
  int? branchId;
  double? distance;
  String? transactionReference;

  PlaceOrderBody copyWith(
      {String? paymentMethod, String? transactionReference}) {
    this.paymentMethod = paymentMethod;
    this.transactionReference = transactionReference;
    return this;
  }

  PlaceOrderBody({
    required this.cart,
    required this.couponDiscountAmount,
    required this.couponDiscountTitle,
    required this.orderAmount,
    required this.orderType,
    required this.deliveryAddressId,
    required this.paymentMethod,
    required this.orderNote,
    required this.couponCode,
    required this.deliveryTime,
    required this.deliveryDate,
    required this.branchId,
    required this.distance,
    this.transactionReference,
  });

  // from  json
  factory PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    return PlaceOrderBody(
      cart: json['cart'] != null
          ? (json['cart'] as List).map((i) => Cart.fromJson(i)).toList()
          : null,
      couponDiscountAmount: json['coupon_discount_amount'],
      couponDiscountTitle: json['coupon_discount_title'],
      orderAmount: json['order_amount'],
      orderType: json['order_type'],
      deliveryAddressId: json['delivery_address_id'],
      paymentMethod: json['payment_method'],
      orderNote: json['order_note'],
      couponCode: json['coupon_code'],
      deliveryTime: json['delivery_time'],
      deliveryDate: json['delivery_date'],
      branchId: json['branch_id'],
      distance: json['distance'],
      transactionReference: json['transaction_reference'],
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        "cart": cart!.map((v) => v.toJson()).toList(),
        "coupon_discount_amount": couponDiscountAmount,
        "coupon_discount_title": couponDiscountTitle,
        "order_amount": orderAmount,
        "order_type": orderType,
        "delivery_address_id": deliveryAddressId,
        "payment_method": paymentMethod,
        "order_note": orderNote,
        "coupon_code": couponCode,
        "delivery_time": deliveryTime,
        "delivery_date": deliveryDate,
        "branch_id": branchId,
        "distance": distance,
        "transaction_reference": transactionReference,
      };
}

class Cart {
  String? productId;
  String? price;
  List<OrderVariation>? variation;
  double? discountAmount;
  int? quantity;
  double? taxAmount;
  List<int?>? addOnIds;
  List<int?>? addOnQtys;

  Cart({
    required this.productId,
    required this.price,
    required this.variation,
    required this.discountAmount,
    required this.quantity,
    required this.taxAmount,
    required this.addOnIds,
    required this.addOnQtys,
  });

  // from json
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json['product_id'],
        price: json['price'],
        variation: json['variations'] != null
            ? (json['variations'] as List)
                .map((i) => OrderVariation.fromJson(i))
                .toList()
            : null,
        discountAmount: json['discount_amount'],
        quantity: json['quantity'],
        taxAmount: json['tax_amount'],
        addOnIds: json['add_on_ids'] != null
            ? List<int>.from(json['add_on_ids'])
            : null,
        addOnQtys: json['add_on_qtys'] != null
            ? List<int>.from(json['add_on_qtys'])
            : null,
      );

  // to json
  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "price": price,
        "variations": variation!.map((v) => v.toJson()).toList(),
        "discount_amount": discountAmount,
        "quantity": quantity,
        "tax_amount": taxAmount,
        "add_on_ids": addOnIds,
        "add_on_qtys": addOnQtys,
      };
}

class OrderVariation {
  String? name;
  OrderVariationValue? values;

  OrderVariation({this.name, this.values});

  OrderVariation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    values = json['values'] != null
        ? OrderVariationValue.fromJson(json['values'])
        : null;
  }

  // to json
  Map<String, dynamic> toJson() => {
        "name": name,
        "values": values!.toJson(),
      };
}

class OrderVariationValue {
  List<String?>? label;

  OrderVariationValue({this.label});

  OrderVariationValue.fromJson(Map<String, dynamic> json) {
    label = json['label'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    return data;
  }
}
