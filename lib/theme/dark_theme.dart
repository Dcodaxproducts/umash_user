import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData dark({Color color = primaryColor, BuildContext? context}) =>
    ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      primaryColor: color,
      secondaryHeaderColor: const Color(0xFF009f67),
      disabledColor: const Color(0xffa2a7ad),
      scaffoldBackgroundColor: backgroundColorDark,
      brightness: Brightness.dark,
      hintColor: const Color(0xFFbebebe),
      cardColor: cardColorDark,
      dividerColor: Colors.grey[800]!,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: color),
      ),
      colorScheme: ColorScheme.dark(primary: color, secondary: color).copyWith(
        background: const Color(0xFF1A1D1F),
        error: const Color(0xFFdd3135),
        outline: const Color(0xFF2C2C2C),
      ),
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context!).textTheme.copyWith(
              displayLarge: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              displayMedium: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              displaySmall: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              headlineMedium: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              bodyLarge: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              bodyMedium: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              bodySmall: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              titleMedium: TextStyle(
                fontSize: 10.sp,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
              titleSmall: TextStyle(
                fontSize: 8.sp,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
            ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 10,
        color: backgroundColorDark,
        surfaceTintColor: backgroundColorDark,
        shadowColor: backgroundColorDark,
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        centerTitle: true,
      ),
    );
