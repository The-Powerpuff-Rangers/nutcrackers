import 'package:flutter/material.dart';
import 'package:frontend/utils/hex_color.dart';

class AppColors {
  AppColors._();

  // Light Mode
  static Color youWhite = '#F9F8F9'.toColor();
  static Color youFadedWhite = '#EBEBEC'.toColor();
  static Color youBlack = '#1C1C1E'.toColor();
  static Color youGreen = '#25D366'.toColor();
  static Color darkGreen = '#184329'.toColor();
  static Color youGrey = '#929292'.toColor();
  static Color searchGrey = '#767680'.toColor();
  static Color bubbleGrey = '#313D35'.toColor();
  static Color youRed = '#FF5252'.toColor();
  static Color pistachioGreen = '#93C572'.toColor();

  static Color grey = '#8F8E92'.toColor();
  static Color grey2 = '#AEAFB3'.toColor();
  static Color grey3 = '#C7C7CC'.toColor();
  static Color grey4 = '#D1D1D6'.toColor();
  static Color grey5 = '#E4E4EA'.toColor();
  static Color grey6 = '#F3F3F7'.toColor();

  static Color buttonRed = const Color(0xFFFE3D2E);
  static Color buttonGreen = const Color.fromARGB(255, 17, 163, 73);

  /// Dark Mode colors
  static Color youDimmedBlack = '#191919'.toColor();
  // #1A1A1A -- For reference
  static Color youDarkDimmedBlack = '#212122'.toColor();

  /// Settings colors
  ///
  /// Light Mode
  static Color whiteSmoke = '#F5F5F5'.toColor();

  ///
  /// Dark Mode
  static Color richGray = '#1F2022'.toColor();

  /// Shimmer Colors [Light Mode]
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;

  /// Shimmer Colors [Dark Mode]
  static Color shimmerDarkBaseColor = Colors.grey.shade700;
  static Color shimmerDarkHighlightColor = Colors.grey.shade600;
}
