class ConfigModel {
  String? privacyPolicy;
  String? termsAndCondition;
  String? email;
  String? phone;
  String? address;
  double? latitude;
  double? longitude;
  bool facebook;
  bool google;
  bool apple;
  Currency? currency;

  ConfigModel({
    this.privacyPolicy,
    this.termsAndCondition,
    this.email,
    this.phone,
    this.address,
    this.latitude,
    this.longitude,
    required this.facebook,
    required this.google,
    required this.apple,
    this.currency,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        privacyPolicy: json["privacy_policy"],
        termsAndCondition: json["terms_condition"],
        email: json["contact_email"],
        phone: json["contact_number"],
        address: json["address"],
        latitude: json["lat"]?.toDouble(),
        longitude: json["lng"]?.toDouble(),
        facebook: json["facebook_login"] == 0 ? false : true,
        google: json["google_login"] == 0 ? false : true,
        apple: json["apple_login"] == 0 ? false : true,
        currency: Currency.fromJson(json["currency_setting"]),
      );
}

class Currency {
  String? name;
  String? symbol;
  String? code;
  String? position;

  Currency({
    this.name,
    this.symbol,
    this.code,
    this.position,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
        code: json["code"],
        position: json["position"],
      );
}
