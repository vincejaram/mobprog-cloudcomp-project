enum PasswordStrengthLevel { empty, weak, fair, good, strong }

class PasswordStrengthResult {
  final PasswordStrengthLevel level;
  final double progress;
  final String label;

  const PasswordStrengthResult({
    required this.level,
    required this.progress,
    required this.label,
  });
}

class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validateFullName(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Please enter your full name.';
    }
    if (trimmed.length < 2) {
      return 'Name must be at least 2 characters long.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Please enter your email address.';
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  static String? validateSignupPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create a password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Include at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Include at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Include at least one number.';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Please enter a username.';
    }
    if (trimmed.length < 3) {
      return 'Username must be at least 3 characters.';
    }
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(trimmed)) {
      return 'ONly letters, numbers, dots, and underscores allowed.';
    }
    return null;
  }

  static PasswordStrengthResult evaluatePasswordStrength(String password) {
    if (password.isEmpty) {
      return const PasswordStrengthResult(
        level: PasswordStrengthLevel.empty,
        progress: 0.0,
        label: '',
      );
    }

    int score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-]').hasMatch(password)) score++;

    if (score <= 2) {
      return const PasswordStrengthResult(
        level: PasswordStrengthLevel.weak,
        progress: 0.25,
        label: 'Weak',
      );
    } else if (score == 3) {
      return const PasswordStrengthResult(
        level: PasswordStrengthLevel.fair,
        progress: 0.50,
        label: 'Fair',
      );
    } else if (score == 4 || score == 5) {
      return const PasswordStrengthResult(
        level: PasswordStrengthLevel.good,
        progress: 0.75,
        label: 'Good',
      );
    } else {
      return const PasswordStrengthResult(
        level: PasswordStrengthLevel.strong,
        progress: 1.0,
        label: 'Strong',
      );
    }
  }
}
