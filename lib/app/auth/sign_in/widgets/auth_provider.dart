import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:smart_pay/models/country.dart';
import 'package:smart_pay/models/user_info.dart';
import 'package:smart_pay/repos/auth.dart';

enum AuthType { register, login }

class AuthProvider extends ChangeNotifier {
  String fullName;
  String email;
  String password;
  String otp;
  String otpResponse;
  String token;
  String pin;
  Country? country;
  AuthType authType;
  String secretMessage;
  final AuthBase auth;
  AuthProvider({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.otp = '',
    this.otpResponse = '',
    this.token = '',
    this.pin = '',
    this.secretMessage = '',
    this.country,
    this.authType = AuthType.register,
    required this.auth,
  }) {
    fetchAndSetCountries();
  }

  var canSubmit = false;
  var isLoading = false;

  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  final _countries = <Country>[];
  List<Country> get countries => _countries;

  // toggleAuthType switches the auth type
  void toggleAuthType() {
    if (authType == AuthType.register) {
      updateWith(authType: AuthType.login);
    } else {
      updateWith(authType: AuthType.register);
    }
  }

  // toggleAuthPageText switches the toggler text based on authType
  List<String> toggleAuthPageText() {
    if (authType == AuthType.register) {
      return ['Already have an account?', ' Sign In'];
    } else {
      return ['Don\'t have an account yet?', ' Sign Up'];
    }
  }

  // checkSubmit checks if the form fields are filled
  void checkSubmit() {
    if (authType == AuthType.register) {
      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        canSubmit = false;
        notifyListeners();
      } else {
        canSubmit = true;
        notifyListeners();
      }
      return;
    }

    if (authType == AuthType.login) {
      if (email.isEmpty || password.isEmpty) {
        canSubmit = false;
        notifyListeners();
      } else {
        canSubmit = true;
        notifyListeners();
      }
      return;
    }
  }

  String encryptedEmail() {
    if (email.isNotEmpty) {
      final splitted = email.split('@');
      final mail = splitted[0];
      var encryptEmail = '';
      for (var i = 0; i < mail.length; i++) {
        encryptEmail += '*';
      }
      return '$encryptEmail@${splitted.last}';
    } else {
      return '*******@mail.com';
    }
  }

  Future<void> fetchAndSetCountries() async {
    final rawData = await rootBundle.loadString('assets/countries.json');
    final data = json.decode(rawData) as List;
    final countries = data.map((e) => Country.fromMap(e)).toList();
    _countries.addAll(countries);
  }

  List<Country> findCountry(String searchTerm) {
    if (searchTerm.isEmpty) {
      return _countries;
    } else {
      return _countries.where((e) {
        final i = e.name.toLowerCase();
        final j = e.iso2.toLowerCase();
        final query = searchTerm.toLowerCase();

        return i.contains(query) || j.contains(query);
      }).toList();
    }
  }

  /// REQUESTS

  Future<String> fetchEmailToken() async {
    try {
      isLoading = true;
      notifyListeners();
      final res = await auth.fetchEmailToken(email);
      updateWith(otpResponse: res);
      isLoading = false;
      notifyListeners();
      return res;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> verifyEmailToken() async {
    try {
      isLoading = true;
      notifyListeners();
      final res = await auth.verifyEmailToken(email, otp);
      isLoading = false;
      notifyListeners();
      return res;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register() async {
    try {
      isLoading = true;
      notifyListeners();
      final res = await auth.register(UserInfo(
        fullname: fullName,
        email: email,
        password: password,
        country: country!.iso2.toUpperCase(),
      ));
      updateWith(token: res);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> login() async {
    try {
      isLoading = true;
      notifyListeners();
      final res = await auth.login(email, password);
      updateWith(token: res);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<String> dashboard() async {
    try {
      isLoading = true;
      final res = await auth.dashboard(token);
      isLoading = false;
      return res;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      notifyListeners();
      await auth.logout();
      isLoggedIn = false;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  /// REQUESTS END

  void updateWith({
    String? fullName,
    String? email,
    String? password,
    String? otp,
    String? otpResponse,
    String? pin,
    String? secretMessage,
    Country? country,
    String? token,
    AuthType? authType,
  }) {
    this.fullName = fullName ?? this.fullName;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.otp = otp ?? this.otp;
    this.otpResponse = otpResponse ?? this.otpResponse;
    this.pin = pin ?? this.pin;
    this.secretMessage = secretMessage ?? this.secretMessage;
    this.token = token ?? this.token;
    this.country = country ?? this.country;
    this.authType = authType ?? this.authType;

    notifyListeners();
  }

  @override
  String toString() {
    return 'AuthProvider(fullName: $fullName, email: $email, password: $password, otp: $otp, otpResponse: $otpResponse, token: $token, pin: $pin, country: $country, authType: $authType, secretMessage: $secretMessage, auth: $auth)';
  }
}
