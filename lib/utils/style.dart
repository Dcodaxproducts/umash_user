// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

EdgeInsets get pagePadding => EdgeInsets.all(16.sp);
double get radius => 8.sp;

class FontStyles {
  // title
  static TextStyle get titleLarge =>
      Theme.of(Get.context!).textTheme.titleLarge!;

  static TextStyle get titleMedium =>
      Theme.of(Get.context!).textTheme.titleMedium!;

  static TextStyle get titleSmall =>
      Theme.of(Get.context!).textTheme.titleSmall!;

  static TextStyle get bodySmall => Theme.of(Get.context!).textTheme.bodySmall!;

  static TextStyle get bodyExtraSmall =>
      Theme.of(Get.context!).textTheme.bodySmall!.copyWith(
          fontSize: Theme.of(Get.context!).textTheme.bodySmall!.fontSize! - 2);
}
