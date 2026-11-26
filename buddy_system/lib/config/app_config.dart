import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  AppColors._();

  // Palette natin itech
  static const Color primary = Color(0xFF1B6E6E);
  static const Color primaryDark = Color(0xFF2A9D8F);
  static const Color secondary = Color(0xFF68C3A3);
  static const Color accent = Color(0xFFF4A28C);
  static const Color success = Color(0xFF4CB97A);
  static const Color warning = Color(0xFFF6C667);
  static const Color error = Color(0xFFE06C65);

  // Mga soft pastel tints for habit/mood cards
  static const Color pastelMint = Color(0xFFE6F6F1);
  static const Color pastelLavender = Color(0xFFF0ECFC);
  static const Color pastelPeach = Color(0xFFFDEEE8);
  static const Color pastelYellow = Color(0xFFFFF6DC);

  // Dark Mode
  static const Color darkBg = Color(0xFF0F1A1D);
  static const Color darkSurface = Color(0xFF17262A);
  static const Color darkSurfaceVariant = Color(0xFF203439);
  static const Color darkBorder = Color(0xFF2B4349);
  static const Color darkTextPrim = Color(0xFFF2F7F6);
  static const Color darkTextSec = Color(0xFF9EB3B8);

  // Light Mode
  static const Color lightBg = Color(0xFFFAF9F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F4F2);
  static const Color lightBorder = Color(0xFFE3E8E5);
  static const Color lightTextPrim = Color(0xFF172B36);
  static const Color lightTextSec = Color(0xFF6B7B85);
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;

  static const double radius = 12.0;
}

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String themeSettings = '/theme-settings';
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    // final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
    //   ThemeData.light().textTheme,
    // );
    final baseTextTheme = ThemeData.light().textTheme;
    final fontFamily = GoogleFonts.plusJakartaSans().fontFamily;

    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.lightTextPrim,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrim,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      outline: AppColors.lightBorder,
      error: AppColors.error,
      onError: Colors.white,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBg,
      textTheme: baseTextTheme.apply(
        fontFamily: fontFamily,
        bodyColor: AppColors.lightTextPrim,
        displayColor: AppColors.lightTextPrim,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightTextPrim,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextPrim,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          side: BorderSide(color: AppColors.lightBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 16,
        ),
        hintStyle: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.lightTextSec,
        ),
        labelStyle: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.lightTextSec,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: const BorderSide(color: AppColors.error, width: 1.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 54),
          shape: shape,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.lightBg, width: 1.5),
          minimumSize: const Size(double.infinity, 54),
          shape: shape,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: AppColors.lightTextSec, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.transparent;
        }),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: shape,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
      ),
    );
  }

  static ThemeData get dark {
    // final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
    //   ThemeData.dark().textTheme,
    // );
    final baseTextTheme = ThemeData.dark().textTheme;
    final fontFamily = GoogleFonts.plusJakartaSans().fontFamily;

    const colorScheme = ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.darkBg,
      tertiary: AppColors.accent,
      onTertiary: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrim,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      outline: AppColors.darkBorder,
      error: AppColors.error,
      onError: Colors.white,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: AppColors.darkBg,
      textTheme: baseTextTheme.apply(
        fontFamily: fontFamily,
        bodyColor: AppColors.darkTextPrim,
        displayColor: AppColors.darkTextPrim,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightTextPrim,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: baseTextTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextPrim,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          side: BorderSide(color: AppColors.lightBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 16,
        ),
        hintStyle: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.lightTextSec,
        ),
        labelStyle: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.lightTextSec,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide(color: AppColors.lightBg),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide(color: AppColors.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide(color: AppColors.error, width: 1.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 54),
          shape: shape,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.lightBg, width: 1.5),
          minimumSize: const Size(double.infinity, 54),
          shape: shape,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        side: BorderSide(color: AppColors.lightTextSec, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.transparent;
        }),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: shape,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  static const String _themePrefKey = 'buddystsem_theme_mode';

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString(_themePrefKey);
    _themeMode = _stringToThemeMode(savedValue);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePrefKey, _themeModeToString(mode));
  }

  String get currentThemeLabel {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  static ThemeMode _stringToThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  static String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
