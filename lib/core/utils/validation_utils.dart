class ValidationUtils {
  /// Validates password strength:
  /// - At least 8 characters
  /// - Contains at least one uppercase letter
  /// - Contains at least one lowercase letter
  /// - Contains at least one number
  /// - Contains at least one special character
  static String? validatePassword(String? value, bool isAr) {
    if (value == null || value.isEmpty) {
      return isAr ? "كلمة المرور مطلوبة" : "Password is required";
    }
    
    if (value.length < 8) {
      return isAr 
          ? "يجب أن تكون كلمة المرور 8 أحرف على الأقل" 
          : "Password must be at least 8 characters";
    }
    
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return isAr 
          ? "يجب أن تحتوي على حرف كبير واحد على الأقل" 
          : "Must contain at least one uppercase letter";
    }
    
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return isAr 
          ? "يجب أن تحتوي على حرف صغير واحد على الأقل" 
          : "Must contain at least one lowercase letter";
    }
    
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return isAr 
          ? "يجب أن تحتوي على رقم واحد على الأقل" 
          : "Must contain at least one number";
    }
    
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return isAr 
          ? "يجب أن تحتوي على رمز خاص واحد على الأقل (!@#\$%)" 
          : "Must contain at least one special character (!@#\$%)";
    }
    
    return null;
  }
}
