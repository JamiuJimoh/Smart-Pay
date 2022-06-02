import 'package:flutter/cupertino.dart';

enum AuthType { register, login }

class AuthProvider extends ChangeNotifier {
  String fullName;
  String email;
  String password;
  String otp;
  String pin;
  AuthType authType;
  AuthProvider({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.otp = '',
    this.pin = '',
    this.authType = AuthType.register,
  });

  void toggleAuthType() {
    if (authType == AuthType.register) {
      updateWith(authType: AuthType.login);
    } else {
      updateWith(authType: AuthType.register);
    }
  }

  List<String> toggleAuthPageText() {
    if (authType == AuthType.register) {
      return ['Already have an account', ' Sign In'];
    } else {
      return ['Don\'t have an account yet', ' Sign Up'];
    }
  }

  void updateWith({
    String? fullName,
    String? email,
    String? password,
    String? otp,
    String? pin,
    AuthType? authType,
  }) {
    this.fullName = fullName ?? this.fullName;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.otp = otp ?? this.otp;
    this.pin = pin ?? this.pin;
    this.authType = authType ?? this.authType;

    notifyListeners();
  }

  @override
  String toString() {
    return 'AuthProvider(fullName: $fullName, email: $email, password: $password, otp: $otp, pin: $pin, authType: $authType)';
  }
}
