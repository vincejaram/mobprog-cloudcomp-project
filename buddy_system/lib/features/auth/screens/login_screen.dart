import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_branding.dart';
import '../../../core/widgets/app_feedback.dart';
import '../../../core/widgets/app_inputs.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedUsername();
  }

  Future<void> _loadRememberedUsername() async {
    final authProvider = context.read<AuthProvider>();
    final savedUsername = await authProvider.loadRememberedUsername();
    if (!mounted) return;
    if (savedUsername != null && savedUsername.isNotEmpty) {
      setState(() {
        _usernameController.text = savedUsername;
        _rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    final authProvider = context.read<AuthProvider>();
    authProvider.clearError();

    if (!_formKey.currentState!.validate()) return;

    final result = await authProvider.login(
      username: _usernameController.text,
      password: _passwordController.text,
      rememberMe: _rememberMe,
    );

    if (!mounted) return;

    if (result.success) {
      AppSnackBar.showSuccess(context, result.message);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = context.watch<AuthProvider>();
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton.outlined(
                      tooltip: 'Theme Settings',
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.themeSettings);
                      },
                      icon: Icon(
                        isDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const AppLogo(size: 150, showText: true, showTagline: true),
                  const SizedBox(height: AppSpacing.xl),
                  ThemeAwareCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (authProvider.errorMessage != null) ...[
                            StatusBanner(
                              message: authProvider.errorMessage!,
                              isError: true,
                            ),
                            const SizedBox(height: AppSpacing.md),
                          ],
                          CustomTextField(
                            controller: _usernameController,
                            label: 'Username',
                            prefixIcon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateUsername,
                            enabled: !authProvider.isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          PasswordField(
                            controller: _passwordController,
                            validator: Validators.validateLoginPassword,
                            enabled: !authProvider.isLoading,
                            onFieldSubmitted: (_) => _handleLogin(),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: authProvider.isLoading
                                      ? null
                                      : (value) {
                                          setState(
                                            () => _rememberMe = value ?? false,
                                          );
                                        },
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              GestureDetector(
                                onTap: authProvider.isLoading
                                    ? null
                                    : () {
                                        setState(
                                          () => _rememberMe = !_rememberMe,
                                        );
                                      },
                                child: Text(
                                  'Remember Me',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          PrimaryButton(
                            label: 'Log In',
                            isLoading: authProvider.isLoading,
                            onPressed: _handleLogin,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: theme.textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: authProvider.isLoading
                            ? null
                            : () {
                                authProvider.clearError();
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.signup);
                              },
                        child: Text(
                          'Sign Up',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
