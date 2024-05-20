class AddressModel {
  int? id;
  String addressType;
  String contactPersonNumber;
  String address;
  String latitude;
  String longitude;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? method;
  String contactPersonName;
  String? streetNumber;
  String? floorNumber;
  String? houseNumber;

  AddressModel({
    this.id,
    required this.addressType,
    required this.contactPersonNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.method,
    required this.contactPersonName,
    this.houseNumber,
    this.floorNumber,
    this.streetNumber,
  });

  // from json
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as int?,
        addressType: json['address_type'] as String,
        contactPersonNumber: json['contact_person_number'] as String,
        address: json['address'] as String,
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        userId: json['user_id'] as int?,
        method: json['_method'] as String?,
        contactPersonName: json['contact_person_name'] as String,
        streetNumber: json['road'] as String?,
        floorNumber: json['floor'] as String?,
        houseNumber: json['house'] as String?,
      );

  AddressModel copyWith({
    int? id,
    String? addressType,
    String? contactPersonNumber,
    String? address,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    int? userId,
    String? method,
    String? contactPersonName,
    String? streetNumber,
    String? floorNumber,
    String? houseNumber,
  }) {
    return AddressModel(
      id: id ?? this.id,
      addressType: addressType ?? this.addressType,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      method: method ?? this.method,
      contactPersonName: contactPersonName ?? this.contactPersonName,
      streetNumber: streetNumber ?? this.streetNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      houseNumber: houseNumber ?? this.houseNumber,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'address_type': addressType,
        'contact_person_number': contactPersonNumber,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user_id': userId,
        '_method': method,
        'contact_person_name': contactPersonName,
        'road': streetNumber,
        'floor': floorNumber,
        'house': houseNumber,
      };
}

class LocalAdress {
  double latitude;
  double longitude;
  String address;
  String city;
  int? branchId;

  LocalAdress({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    this.branchId,
  });

  factory LocalAdress.fromJson(Map<String, dynamic> json) => LocalAdress(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
        address: json['address'] as String,
        city: json['city'] as String,
        branchId: json['branch_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'city': city,
        'branch_id': branchId,
      };
}
