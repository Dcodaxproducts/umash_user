import 'package:umash_user/data/model/response/product_model.dart';

class CartModel {
  double? price;
  double? discountedPrice;
  List<Variation>? variation;
  double? discountAmount;
  int? quantity;
  List<AddOn>? addOnIds;
  Product? product;
  Tag? taste;

  CartModel({
    this.price,
    this.discountedPrice,
    this.variation,
    this.discountAmount,
    this.quantity,
    this.addOnIds,
    this.product,
    this.taste,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        price: json['price'].toDouble(),
        discountedPrice: json['discounted_price'].toDouble(),
        variation: json['variation'] != null
            ? (json['variation'] as List)
                .map((i) => Variation.fromJson(i))
                .toList()
            : null,
        discountAmount: json['discount_amount'] == null
            ? 0
            : json['discount_amount'].toDouble(),
        quantity: json['quantity'],
        addOnIds: json['add_on_ids'] != null
            ? (json['add_on_ids'] as List)
                .map((i) => AddOn.fromJson(i))
                .toList()
            : null,
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
        taste: json['taste'] != null ? Tag.fromJson(json['taste']) : null,
      );

  // to json
  Map<String, dynamic> toJson() => {
        'price': price,
        'discounted_price': discountedPrice,
        'variation': variation?.map((i) => i.toJson()).toList(),
        'discount_amount': discountAmount,
        'quantity': quantity,
        'add_on_ids': addOnIds?.map((i) => i.toJson()).toList(),
        'product': product?.toJson(),
        'taste': taste?.toJson(),
      };
}

class AddOn {
  int id;
  int quantity;

  AddOn({required this.id, required this.quantity});

  // from json
  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        id: json['id'],
        quantity: json['quantity'],
      );

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
      };
}
