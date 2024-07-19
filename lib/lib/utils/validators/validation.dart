


class TValidator{
  static String? validateEmail(String? value){
    if(value == null ){
      return "Email is required.";
    }
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w]+\.)+[\w-]{2,4}$");
    if (!emailRegExp.hasMatch(value)){
      return 'Invalid email address.';
    }
      return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty) {
      return "Phone number is required.";
    }

    final phoneRegExp= RegExp(r'^\d{10}$');
    if(!phoneRegExp.hasMatch(value)){
      return 'Invalid phone number format (10 digits required.';
    }
    return null ;
  }
  static String? validateField(String? value){
    if(value == null || value == 'null' || value.isEmpty) {
      return "This field is required.";
    }
    return null ;
  }

  static  String?  validatePassword(String? value) {
    print('value----------------------$value');
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
  static   String? validateConfirmPassword(String? value1, String? value2) {
    if (value1 == null || value1.isEmpty) {
      return 'Confirm password is required';
    }
    if (value1 != value2) {
      return 'Passwords do not match';
    }
    return null;
  }
}