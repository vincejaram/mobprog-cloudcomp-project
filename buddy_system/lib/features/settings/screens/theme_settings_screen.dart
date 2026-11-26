import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../../../core/widgets/app_branding.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final secondaryTextColor = theme.brightness == Brightness.dark
        ? AppColors.darkTextSec
        : AppColors.lightTextSec;

    return Scaffold(
      appBar: AppBar(title: const Text('Theme Settings')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Appearance',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const SizedBox(height: AppSpacing.lg),
                  _ThemeOptionCard(
                    title: 'Light Mode',
                    subtitle: 'Bright surfaces for daytime focus.',
                    isSelected: themeProvider.themeMode == ThemeMode.light,
                    preview: const _ThemePreviewThumbnail(
                      isLight: true,
                      isSystem: false,
                    ),
                    onTap: () => themeProvider.setThemeMode(ThemeMode.light),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ThemeOptionCard(
                    title: 'Dark Mode',
                    subtitle: 'Designed for low-light comfort.',
                    isSelected: themeProvider.themeMode == ThemeMode.dark,
                    preview: const _ThemePreviewThumbnail(
                      isLight: false,
                      isSystem: false,
                    ),
                    onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ThemeOptionCard(
                    title: 'System Default',
                    subtitle: 'Automatically matches your device settings.',
                    isSelected: themeProvider.themeMode == ThemeMode.system,
                    preview: const _ThemePreviewThumbnail(
                      isLight: true,
                      isSystem: true,
                    ),
                    onTap: () => themeProvider.setThemeMode(ThemeMode.system),
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

class _ThemeOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final Widget preview;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.preview,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryTextColor = theme.brightness == Brightness.dark
        ? AppColors.darkTextSec
        : AppColors.lightTextSec;

    return ThemeAwareCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      borderColor: isSelected ? AppColors.primary : null,
      borderWidth: isSelected ? 2.0 : 1.0,
      child: Row(
        children: [
          preview,
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: secondaryTextColor,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : theme.colorScheme.outline,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check_rounded, size: 15, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }
}

class _ThemePreviewThumbnail extends StatelessWidget {
  final bool isLight;
  final bool isSystem;

  const _ThemePreviewThumbnail({required this.isLight, required this.isSystem});

  @override
  Widget build(BuildContext context) {
    if (isSystem) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 64,
          height: 54,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Expanded(child: _MiniPaletteHalf(isLight: true)),
              Expanded(child: _MiniPaletteHalf(isLight: false)),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 64,
      height: 54,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isLight ? AppColors.lightBg : AppColors.darkBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLight ? AppColors.lightBorder : AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 8,
            width: 28,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(
            height: 18,
            decoration: BoxDecoration(
              color: isLight ? AppColors.lightSurface : AppColors.darkSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 4),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniPaletteHalf extends StatelessWidget {
  final bool isLight;

  const _MiniPaletteHalf({required this.isLight});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isLight ? AppColors.lightBg : AppColors.darkBg,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: isLight ? AppColors.lightSurface : AppColors.darkSurface,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
