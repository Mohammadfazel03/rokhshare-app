import 'package:flutter/material.dart';
import 'package:rokhshare/gen/fonts.gen.dart';

class Themes {
  static final light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromRGBO(232, 171, 1, 1),
        surfaceTint: Color(0xffE8AA01),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xfffff0c7),
        onPrimaryContainer: Color(0xffC08D01),
        // secondary: Color(0xff106b57),
        secondary: Color(0xff204183),
        onSecondary: Color(0xffffffff),
        // secondaryContainer: Color(0xffa2f2d9),
        secondaryContainer: Color(0xffdee7f7),
        // onSecondaryContainer: Color(0xff002019),
        onSecondaryContainer: Color(0xff081021),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        surface: Color(0xfffaf8ff),
        onSurface: Color(0xff1a1b21),
        onSurfaceVariant: Color(0xff45464f),
        outline: Color(0xff757780),
        outlineVariant: Color(0xffc5c6d0),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff2f3036),
        surfaceDim: Color(0xffdad9e0),
        surfaceBright: Color(0xfffaf8ff),
        surfaceContainerLowest: Color(0xffffffff),
        surfaceContainerLow: Color(0xfff4f3fa),
        surfaceContainer: Color(0xffeeedf4),
        surfaceContainerHigh: Color(0xffe8e7ef),
        surfaceContainerHighest: Color(0xffe2e2e9),
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 57),
          displayMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 45),
          displaySmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 36),
          headlineLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 32),
          headlineMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 28),
          headlineSmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 24),
          titleLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 22),
          titleMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 16),
          titleSmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          bodyLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 16),
          bodyMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 14),
          bodySmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 12),
          labelLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          labelMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 12),
          labelSmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 11)));

  static final dark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffffd8aa),
        surfaceTint: Color(0xffffd8aa),
        onPrimary: Color(0xffCA9401),
        primaryContainer: Color(0xffD39B01),
        onPrimaryContainer: Color(0xfffff0c7),
        // secondary: Color(0xff87d6bd),
        secondary: Color(0xffadc4eb),
        // onSecondary: Color(0xff00382c),
        onSecondary: Color(0xff0b152d),
        // secondaryContainer: Color(0xff005141),
        secondaryContainer: Color(0xff142952),
        // onSecondaryContainer: Color(0xffa2f2d9),
        onSecondaryContainer: Color(0xffdee7f7),
        error: Color(0xffffb4ab),
        onError: Color(0xff690005),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xffffdad6),
        surface: Color(0xff121318),
        onSurface: Color(0xffe2e2e9),
        onSurfaceVariant: Color(0xffc5c6d0),
        outline: Color(0xff8f909a),
        outlineVariant: Color(0xff45464f),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffe2e2e9),
        surfaceDim: Color(0xff121318),
        surfaceBright: Color(0xff38393f),
        surfaceContainerLowest: Color(0xff0d0e13),
        surfaceContainerLow: Color(0xff1a1b21),
        surfaceContainer: Color(0xff1e1f25),
        surfaceContainerHigh: Color(0xff282a2f),
        surfaceContainerHighest: Color(0xff33343a),
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 57),
          displayMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 45),
          displaySmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 36),
          headlineLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 32),
          headlineMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 28),
          headlineSmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 24),
          titleLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 22),
          titleMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 16),
          titleSmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          bodyLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 16),
          bodyMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 14),
          bodySmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w400,
              fontSize: 12),
          labelLarge: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 14),
          labelMedium: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 12),
          labelSmall: TextStyle(
              fontFamily: FontFamily.pinar,
              fontWeight: FontWeight.w500,
              fontSize: 11)));
}
