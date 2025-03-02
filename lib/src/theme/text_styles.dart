import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String _fontFamily = 'Ubuntu';
  
  static const TextStyle h1 = TextStyle(
    fontSize: 36,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500, // Medium weight
    color: AppColors.primaryText,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 28,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500, // Medium weight
    color: AppColors.primaryText,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 24,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  static const TextStyle h6 = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500, // Medium weight
    color: AppColors.primaryText,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500, // Medium weight
    color: AppColors.secondaryText,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500, // Medium weight
    letterSpacing: 1.25,
    color: Colors.white,
  );
}
