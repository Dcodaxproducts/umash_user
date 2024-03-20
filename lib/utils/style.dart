// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

EdgeInsets pagePadding = const EdgeInsets.all(16);
const double radius = 8;

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
