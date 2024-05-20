// ignore_for_file: prefer_null_aware_operators

import 'package:umash_user/controller/splash_controller.dart';

class UserInfoModel {
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? image;
  int? isPhoneVerified;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? emailVerificationToken;
  String? phone;
  String? cmFirebaseToken;
  double? point;
  String? loginMedium;
  String? referCode;
  double? walletBalance;

  UserInfoModel({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.image,
    this.isPhoneVerified,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.emailVerificationToken,
    this.phone,
    this.point,
    this.cmFirebaseToken,
    this.loginMedium,
    this.referCode,
    this.walletBalance,
  });

  // from json
  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      fName: json['f_name'],
      lName: json['l_name'],
      email: json['email'],
      image: json['image'] != null
          ? '${SplashController.to.configModel!.baseUrls!.customerImageUrl!}/${json['image']}'
          : null,
      isPhoneVerified: json['is_phone_verified'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      emailVerificationToken: json['email_verification_token'],
      phone: json['phone'],
      point: json['point'] == null ? null : json['point'].toDouble(),
      cmFirebaseToken: json['cm_firebase_token'],
      loginMedium: json['login_medium'],
      referCode: json['refer_code'],
      walletBalance: json['wallet_balance'] != null
          ? double.parse(json['wallet_balance'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'image': image,
      'is_phone_verified': isPhoneVerified,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'email_verification_token': emailVerificationToken,
      'phone': phone,
      'point': point,
      'cm_firebase_token': cmFirebaseToken,
      'login_medium': loginMedium,
      'refer_code': referCode,
      'wallet_balance': walletBalance,
    };
  }

  // copy with
  UserInfoModel copyWith({
    int? id,
    String? fName,
    String? lName,
    String? email,
    String? image,
    int? isPhoneVerified,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? emailVerificationToken,
    String? phone,
    double? point,
    String? cmFirebaseToken,
    String? loginMedium,
    String? referCode,
    double? walletBalance,
  }) {
    return UserInfoModel(
      id: id ?? this.id,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      email: email ?? this.email,
      image: image ?? this.image,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emailVerificationToken:
          emailVerificationToken ?? this.emailVerificationToken,
      phone: phone ?? this.phone,
      point: point ?? this.point,
      cmFirebaseToken: cmFirebaseToken ?? this.cmFirebaseToken,
      loginMedium: loginMedium ?? this.loginMedium,
      referCode: referCode ?? this.referCode,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }
}
