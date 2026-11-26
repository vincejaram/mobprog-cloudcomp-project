import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_branding.dart';
import '../../../core/widgets/app_feedback.dart';
import '../../../core/widgets/app_inputs.dart';
import '../providers/auth_provider.dart';
import '../widgets/password_strength_indicator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  PasswordStrengthResult _passwordStrength = const PasswordStrengthResult(
    level: PasswordStrengthLevel.empty,
    progress: 0.0,
    label: '',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();
    final authProvider = context.read<AuthProvider>();
    authProvider.clearError();

    if (!_formKey.currentState!.validate()) return;

    final result = await authProvider.register(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
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
    final isDark = theme.brightness == Brightness.dark;
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  const SizedBox(height: AppSpacing.lg),
                  ThemeAwareCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            controller: _firstNameController,
                            label: 'First Name',
                            prefixIcon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.name,
                            validator: Validators.validatefirstName,
                            enabled: !authProvider.isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          CustomTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            prefixIcon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.name,
                            validator: Validators.validatelastName,
                            enabled: !authProvider.isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          CustomTextField(
                            controller: _usernameController,
                            label: 'Username',
                            prefixIcon: Icons.alternate_email_rounded,
                            validator: Validators.validateUsername,
                            enabled: !authProvider.isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validators.validateEmail,
                            enabled: !authProvider.isLoading,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          PasswordField(
                            controller: _passwordController,
                            label: 'Password',
                            validator: Validators.validateSignupPassword,
                            enabled: !authProvider.isLoading,
                            onChanged: (value) {
                              setState(() {
                                _passwordStrength =
                                    Validators.evaluatePasswordStrength(value);
                              });
                            },
                            onFieldSubmitted: (_) => _handleSignUp(),
                          ),
                          PasswordStrengthIndicator(
                            strength: _passwordStrength,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          PrimaryButton(
                            label: 'Create Account',
                            isLoading: authProvider.isLoading,
                            onPressed: _handleSignUp,
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
                        'Already have an account? ',
                        style: theme.textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: authProvider.isLoading
                            ? null
                            : () {
                                authProvider.clearError();
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.login);
                              },
                        child: Text(
                          'Log In',
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
