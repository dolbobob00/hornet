import 'package:flutter/material.dart';

class AppColors {
  //figma

  // Primary colors
  static const primary = Color(0xFFA2B2FC);
  static const primaryBlack = Color(0xFF424242);
  static const primaryWhite = Color(0xFFFFFFFF);
  static const primaryRed = Color(
    0xFFE80606,
  );
  // Secondary colors
  static const secondaryRed = Color(
    0xFFC62020,
  );
  static const secondaryGradient = LinearGradient(
    colors: [
      Color(
        0xFFA2B2FC,
      ),
      Color(
        0xFFFFF1BE,
      ),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const secondaryRedGradient = LinearGradient(
    colors: [
      Color(0xFFFF1111),
      Color(
        0xFFBA0B20,
      ),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topLeft,
  );
  static const secondaryGradientInverse = LinearGradient(
    colors: [
      Color.fromRGBO(142, 152, 198, 1),
      Color(
        0xFFA2B2FC,
      ),
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topLeft,
  );
  static const secondaryGray = Color(
    0xFF9D9D9D,
  );
  static const transparent = Colors.transparent;

  //non figma

  // Accent colors
  static const accent = Color(0xFF424242);
  static const accentDark = Color(0xFFF50057);
  static const accentLight = Color(0xFFFF80AB);

  // Text colors
  static const primaryText = Color(0xFF212121);
  static const secondaryText = Color(0xFF757575);
  static const divider = Color(0xFFBDBDBD);

  // Status colors
  static const error = Color(0xFFD32F2F);
  static const warning = Color(0xFFFFA000);
  static const success = Color(0xFF388E3C);
  static const info = Color(0xFF1976D2);

  // Background colors
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFF5F5F5);
  static const cardBackground = Color(0xFFFFFFFF);
}
