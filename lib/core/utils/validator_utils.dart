class ValidatorUtils {
  static String? validateRequiredField({required String value}) {
    String? message;
    if (value.trim().isEmpty) {
      message = "Field is required";
    }
    return message;
  }

  static String? validateRequiredFieldWithLength({
    required String value,
    required int length,
  }) {
    value = value.trim();
    String? message;
    if (value.isEmpty) {
      message = "Field is required";
    } else if (value.length < length) {
      message = "Input too short";
    }
    return message;
  }

  static String? validateEmail({required String email}) {
    String? message;
    if (email.isEmpty == true) {
      message = 'Email is required';
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.trim())) {
      message = "Invalid email";
    }
    return message;
  }

  static String? validatePasswordAndConfirmPassword({
    required String pwd,
    required String confPwd,
  }) {
    String? message;
    if (pwd.isEmpty) {
      message = 'Password is required';
      return message;
    }

    if (confPwd.isEmpty) {
      message = "Confirm password is required";
      return message;
    }
    if (pwd != confPwd) {
      message = "Passwords do not match";
      return message;
    }
    if (pwd.length < 8) {
      message = "Password must be at least 8 characters";
    }

    if (!RegExp(".*[0-9].*").hasMatch(pwd)) {
      message = 'Password must contain a number';
      return message;
    }
    if (!RegExp('.*[A-Z].*').hasMatch(pwd)) {
      message = 'Password must contain an upper case letter';
      return message;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd)) {
      message = 'Password must contain a special symbol eg. !@%';
      return message;
    }

    return message;
  }

  static String? validatePassword({
    required String pwd,
  }) {
    String? message;

    // Remove whitespace and check if empty
    if (pwd.trim().isEmpty) {
      return 'Password is required';
    }

    // Minimum length (at least 8 characters)
    if (pwd.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Maximum length (optional, e.g., 128 characters)
    if (pwd.length > 128) {
      return 'Password cannot exceed 128 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(pwd)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(pwd)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(pwd)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pwd)) {
      return 'Password must contain at least one special character';
    }

    // Check for repeating characters (e.g., "aaa")
    if (RegExp(r'(.)\1\1').hasMatch(pwd)) {
      return 'Password cannot contain three or more repeating characters';
    }

    // Check for sequential characters (e.g., "abc" or "123")
    if (_hasSequentialCharacters(pwd)) {
      return 'Password cannot contain sequential characters';
    }

    // Check for common patterns (e.g., "password", "qwerty")
    if (_isCommonPassword(pwd.toLowerCase())) {
      return 'Password is too common';
    }

    // Check for whitespace
    if (pwd.contains(' ')) {
      return 'Password cannot contain spaces';
    }

    return null; // Password is valid
  }

// Helper function to check for sequential characters
  static bool _hasSequentialCharacters(String pwd) {
    const sequences = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String lowerPwd = pwd.toLowerCase();

    for (int i = 0; i < lowerPwd.length - 2; i++) {
      String substring = lowerPwd.substring(i, i + 3);
      if (sequences.contains(substring) ||
          sequences.split('').reversed.join().contains(substring)) {
        return true;
      }
    }
    return false;
  }

// Helper function to check for common passwords
  static bool _isCommonPassword(String pwd) {
    const commonPasswords = [
      'password',
      'qwerty',
      '123456',
      'admin',
      'letmein',
      'welcome',
      'monkey',
      'dragon',
      'abc123',
      'football'
    ];
    return commonPasswords.contains(pwd);
  }

  static String? validatePhoneNumber({required String phoneNumber}) {
    String? message;
    if (phoneNumber.trim().isEmpty) {
      message = 'Phone number is required';
    } else {
      // Remove any non-digit characters except the optional leading +
      final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
      if (!RegExp(r'^\+?\d{1,15}$').hasMatch(cleaned)) {
        message = 'Phone number must start with an optional + followed by up to 15 digits';
      }
    }
    return message;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.length < 2) {
      return 'Username must be at least 2 characters';
    }
    if (value.length > 20) {
      return 'Username must be no more than 20 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    if (value.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    return null;
  }


  

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      return 'First name must be at least 2 characters';
    }

    if (trimmed.length > 100) {
      return 'First name must be no more than 100 characters';
    }

    // يسمح بالحروف من كل اللغات والمسافات فقط
    final nameRegExp = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (!nameRegExp.hasMatch(trimmed)) {
      return 'First name can only contain letters and spaces';
    }

    return null;
  }
  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      return 'First name must be at least 2 characters';
    }

    if (trimmed.length > 100) {
      return 'First name must be no more than 100 characters';
    }

    // يسمح بالحروف من كل اللغات والمسافات فقط
    final nameRegExp = RegExp(r'^[\p{L}\s]+$', unicode: true);
    if (!nameRegExp.hasMatch(trimmed)) {
      return 'First name can only contain letters and spaces';
    }

    return null;
  }


  static String? validateDateOfBirth(DateTime? date) {
    if (date == null) {
      return 'Date of birth is required';
    }
    final now = DateTime(2025, 6, 15); // Current date
    final age = now.year - date.year -
        ((now.month > date.month ||
            (now.month == date.month && now.day >= date.day))
            ? 0
            : 1);
    if (age < 18) {
      return 'You must be at least 18 years old';
    }
    return null;
  }

  static String? validateCountry(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Country is required';
    }
    if (value.length > 7) {
      return 'Country code must be no more than 7 characters';
    }
    return null;
  }

  static String? validateLeverage(
      String? value, String Function(String) extractLeverage) {
    if (value == null || value.trim().isEmpty) {
      return 'Leverage is required';
    }
    final leverage = int.tryParse(extractLeverage(value));
    if (leverage == null || leverage <= 0) {
      return 'Leverage must be a number greater than 0';
    }
    return null;
  }

  static String? validateDeposit(
      String? value, double Function(String) extractDeposit) {
    if (value == null || value.trim().isEmpty) {
      return 'Deposit is required';
    }
    final deposit = extractDeposit(value);
    if (deposit <= 0) {
      return 'Deposit must be a number greater than 0';
    }
    return null;
  }

 
}
