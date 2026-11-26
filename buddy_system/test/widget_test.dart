import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:buddy_system/app.dart';
import 'package:buddy_system/config/app_config.dart';
import 'package:buddy_system/features/auth/providers/auth_provider.dart';
import 'package:buddy_system/features/auth/services/api_auth_service.dart';

void main() {
  testWidgets('App loads Login screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(
            create: (_) => AuthProvider(authService: ApiAuthService()),
          ),
        ],
        child: const BuddySystemApp(),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
