import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData light({Color color = primaryColor, BuildContext? context}) =>
    ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      primaryColor: color,
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      scaffoldBackgroundColor: backgroundColorLight,
      brightness: Brightness.light,
      hintColor: const Color(0xFF7B8395),
      cardColor: cardColorLight, // 0xFFF6F6F6
      dividerColor: Colors.grey[300]!, //0xFFE8E8E8
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color).copyWith(
          background: const Color(0xFFFFFFFF),
          error: const Color(0xFFdd3135),
          outline: const Color(0xFFF4F4F4)),
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context!).textTheme.copyWith(
              displayLarge: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              displayMedium: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              displaySmall: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              headlineMedium: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              bodyLarge: const TextStyle(
                fontSize: 16,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              bodyMedium: const TextStyle(
                fontSize: 14,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              bodySmall: const TextStyle(
                fontSize: 12,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              titleMedium: const TextStyle(
                fontSize: 10,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
              titleSmall: const TextStyle(
                fontSize: 8,
                color: Color(0XFF364141),
                fontFamily: 'Nunito',
              ),
            ),
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        color: backgroundColorLight,
        surfaceTintColor: backgroundColorLight,
        shadowColor: backgroundColorLight,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        titleTextStyle: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
