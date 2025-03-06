import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_color_scheme.dart';
import 'package:notes_app/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      textTheme: AppTextStyle.lightTextTheme,
      primaryColor: AppColor.primary,
      colorScheme: ApptColorScheme.light,
      scaffoldBackgroundColor: AppColor.black[50],
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColor.primary,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      textTheme: AppTextStyle.darkTextTheme,
      primaryColor: AppColor.primary,
      colorScheme: ApptColorScheme.dark,
      scaffoldBackgroundColor: AppColor.primary,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColor.primary,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      useMaterial3: true,
    );
  }
}
