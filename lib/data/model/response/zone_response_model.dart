class ZoneResponseModel {
  bool? isSuccess;
  List<int>? zoneIds;
  String? message;
  List<ZoneData>? zoneData;
  ZoneResponseModel(
    this.isSuccess,
    this.message,
    this.zoneIds,
    this.zoneData,
  );
}

class ZoneData {
  int id;
  int status;
  double? minimumShippingCharge;
  double? perKmShippingCharge;

  ZoneData({
    required this.id,
    required this.status,
    this.minimumShippingCharge,
    this.perKmShippingCharge,
  });

  factory ZoneData.fromJson(Map<String, dynamic> json) => ZoneData(
        id: json['id'],
        status: json['status'],
        minimumShippingCharge: json['minimum_shipping_charge']
            ?.json['minimum_shipping_charge']
            .toDouble(),
        perKmShippingCharge: json['per_km_shipping_charge']
            ?.json['per_km_shipping_charge']
            .toDouble(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    return data;
  }
}
