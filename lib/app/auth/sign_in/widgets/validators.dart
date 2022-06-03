abstract class StringValidator {
  bool isValidName(String value);
  bool isValidEmail(String value);
  bool isValidPassword(String value);
  bool isValidConfirmPassword(String password, String confirmPassword);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValidName(String value) {
    return value.isNotEmpty && value.length >= 2 && value.length <= 50;
  }

  @override
  bool isValidEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  @override
  bool isValidPassword(String value) {
    return value.isNotEmpty && value.length >= 6 && strContainsNum(value);
  }

  @override
  bool isValidConfirmPassword(String password, String confirmPassword) {
    return isValidPassword(password) && password == confirmPassword;
  }

  bool strContainsNum(String value) {
    return RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+").hasMatch(value);
  }
}

mixin SignInValidators {
  final StringValidator nameValidator = NonEmptyStringValidator();
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator confirmPasswordValidator = NonEmptyStringValidator();

  static const String invalidNameErrorText =
      'Full name must contain 2 or more characters';
  static const String invalidEmailErrorText = 'Email is invalid';
  static const String invalidPasswordErrorText = 'Invalid password';
  static const String invalidConfirmPasswordErrorText = 'Password must match ';
}
