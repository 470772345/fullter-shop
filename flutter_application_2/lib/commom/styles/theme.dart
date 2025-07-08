import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
  ),
  dividerColor: AppColors.divider,
  // 可继续配置 textTheme、iconTheme 等
);

final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppDarkColors.primary,
  scaffoldBackgroundColor: AppDarkColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppDarkColors.primary,
    foregroundColor: AppDarkColors.textInverse,
  ),
  dividerColor: AppDarkColors.divider,
  // 可继续配置 textTheme、iconTheme 等
);

// 在 main.dart 里这样用：
// MaterialApp(
//   theme: appTheme,
//   darkTheme: appDarkTheme,
//   themeMode: ThemeMode.system, // 跟随系统
// ) 