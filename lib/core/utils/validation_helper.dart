class ValidationHelper {
  static final RegExp nameRegex = RegExp(r'^[a-zA-Z\s.]+$');
  static final RegExp numberRegex = RegExp(r'^\d+$');
  static final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    } else if (!nameRegex.hasMatch(value.trim())) {
      return 'Invalid name';
    } else {
      return null;
    }
  }

  static String? validateMobileNumber(String? value, int maxDigits) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (value.trim().length < maxDigits ||
        !numberRegex.hasMatch(value.trim())) {
      return 'Mobile number should be $maxDigits digits';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!emailRegex.hasMatch(value.trim())) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.trim().length < 6) {
      return 'Password must contain 6 characters';
    } else {
      return null;
    }
  }

  static String? validateOtp(String? value) {
    if (value == null || value.length < 4) {
      return 'Please enter 4 Digit OTP';
    } else {
      return null;
    }
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    } else {
      return null;
    }
  }
}
