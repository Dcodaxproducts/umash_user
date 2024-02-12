import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFBB2525);
const Color secondaryColor = Color(0xFFE9FC58);
const Color backgroundColorDark = Color(0xFF19181F);
const Color backgroundColorLight = Color(0xFFFFFFFF);
Color cardColorDark = cardColorLight;
Color cardColorLight = secondaryColor.withOpacity(0.3);
const Color chatActionColorLight = Color(0xFFECECEC);
const Color chatActionColorDark = Color(0xFF2C2C2C);
LinearGradient primaryGradient = const LinearGradient(
  colors: [
    primaryColor,
    secondaryColor,
  ],
  stops: [0.2, 1.0],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);
