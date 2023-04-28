import 'package:flutter/services.dart';

import 'app_colors.dart';

class NutCrackerTheme {
  // Status Bar and NavBar Color Dark
  static final appUiOverlayStyleDark = SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.youDimmedBlack,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: AppColors.youDimmedBlack);

  // Status Bar and NavBar Color Light
  static final appUiOverlayStyleLight = SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.youWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.youWhite);
}
