import 'package:notes_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class ApptColorScheme {
  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primary,
    onPrimary: AppColor.white,
    // primaryContainer: Color(0xFFF0DBFF),
    // onPrimaryContainer: Color(0xFF2C0051),
    secondary: AppColor.secondary,
    onSecondary: AppColor.white,
    // secondaryContainer: Color(0xFFEDDDF6),
    // onSecondaryContainer: Color(0xFF211829),
    // tertiary: Color(0xFF805157),
    // onTertiary: Color(0xFFFFFFFF),
    // tertiaryContainer: Color(0xFFFFD9DC),
    // onTertiaryContainer: Color(0xFF321016),
    error: Colors.red,
    onError: Colors.red,
    // errorContainer: Color(0xFFFFDAD6),
    // onErrorContainer: Color(0xFF410002),
    outline: AppColor.primary,
    outlineVariant: AppColor.primary,
    surface: Color(0xFFFEF7FC),
    onSurface: Color(0xFF1D1B1E),
    // onSurfaceVariant: Color(0xFF4A454E),
    // inverseSurface: Color(0xFF322F33),
    // onInverseSurface: Color(0xFFF6EFF4),
    // inversePrimary: Color(0xFFDDB8FF),
    shadow: Color(0xFF000000),
    // surfaceTint: Color(0xFF7D3EB9),
    // scrim: Color(0xFF000000),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF1D1B1E),
  );

  static const dark = ColorScheme(
    brightness: Brightness.light,
    primary: AppColor.primary,
    onPrimary: AppColor.white,
    // primaryContainer: Color(0xFFF0DBFF),
    // onPrimaryContainer: Color(0xFF2C0051),
    secondary: AppColor.secondary,
    onSecondary: AppColor.white,
    // secondaryContainer: Color(0xFFEDDDF6),
    // onSecondaryContainer: Color(0xFF211829),
    // tertiary: Color(0xFF805157),
    // onTertiary: Color(0xFFFFFFFF),
    // tertiaryContainer: Color(0xFFFFD9DC),
    // onTertiaryContainer: Color(0xFF321016),
    error: Colors.red,
    onError: Colors.red,
    // errorContainer: Color(0xFFFFDAD6),
    // onErrorContainer: Color(0xFF410002),
    outline: AppColor.primary,
    outlineVariant: AppColor.primary,
    surface: Color(0xFFFEF7FC),
    onSurface: Color(0xFF1D1B1E),
    // onSurfaceVariant: Color(0xFF4A454E),
    // inverseSurface: Color(0xFF322F33),
    // onInverseSurface: Color(0xFFF6EFF4),
    // inversePrimary: Color(0xFFDDB8FF),
    shadow: Color(0xFF000000),
    // surfaceTint: Color(0xFF7D3EB9),
    // scrim: Color(0xFF000000),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF1D1B1E),
  );
}
