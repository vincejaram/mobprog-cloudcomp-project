import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/signup_screen.dart';
// import 'features/dashboard/screens/home_screen.dart';
import 'features/settings/screens/theme_settings_screen.dart';

class BuddySystemApp extends StatelessWidget {
  const BuddySystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'BuddySystem',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeProvider.themeMode,
      themeAnimationDuration: const Duration(milliseconds: 250),
      themeAnimationCurve: Curves.easeInOut,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignUpScreen(),
        AppRoutes.home: (_) => const Scaffold(
          body: Center(child: Text('Home Screen COming Sooooon~')),
        ),
        AppRoutes.themeSettings: (_) => const ThemeSettingsScreen(),
      },
    );
  }
}
