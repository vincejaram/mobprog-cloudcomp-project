import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'config/app_config.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/services/api_auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadThemePreference();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authService: ApiAuthService()),
        ),
      ],
      child: const BuddySystemApp(),
    ),
  );
}
