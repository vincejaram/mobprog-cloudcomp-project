import 'package:flutter/material.dart';

import '../../../config/app_config.dart';
import '../../../core/utils/validators.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final PasswordStrengthResult strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  Color _resolveColor() {
    switch (strength.level) {
      case PasswordStrengthLevel.empty:
        return Colors.transparent;
      case PasswordStrengthLevel.weak:
        return AppColors.error;
      case PasswordStrengthLevel.fair:
        return AppColors.warning;
      case PasswordStrengthLevel.good:
        return AppColors.primary;
      case PasswordStrengthLevel.strong:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (strength.level == PasswordStrengthLevel.empty) {
      return const SizedBox.shrink();
    }

    final color = _resolveColor();
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: strength.progress,
            minHeight: 6,
            backgroundColor: theme.colorScheme.outline.withValues(alpha: 0.4),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password strength',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.brightness == Brightness.dark
                    ? AppColors.darkTextSec
                    : AppColors.lightTextSec,
              ),
            ),
            Text(
              strength.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
