import 'package:flutter/material.dart';

import '../../config/app_config.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool showTagline;

  const AppLogo({
    super.key,
    this.size = 64,
    this.showText = true,
    this.showTagline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secoundaryTextColor = theme.brightness == Brightness.dark
        ? AppColors.darkTextSec
        : AppColors.lightTextSec;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          child: Image.asset(
            'assets/images/logo.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
        ),
        if (showText) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'BuddySytem',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        ],
        if (showTagline) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            'Stay Accountable. Build Habits. Keep Your Streak Alive.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: secoundaryTextColor,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryTextColor = theme.brightness == Brightness.dark
        ? AppColors.darkTextSec
        : AppColors.lightTextSec;

    return Column(
      children: [
        const AppLogo(size: 68, showText: true, showTagline: true),
        const SizedBox(height: AppSpacing.xl),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

class ThemeAwareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;

  const ThemeAwareCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(
          color: borderColor ?? theme.colorScheme.outline,
          width: borderWidth,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: child,
    );
    if (onTap == null) return cardContent;

    return InkWell(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      onTap: onTap,
      child: cardContent,
    );
  }
}
