import 'dart:convert';

class UserInfo {
  final String fullname;
  final String email;
  final String password;
  final String country;
  final String? deviceName;
  UserInfo({
    required this.fullname,
    required this.email,
    required this.password,
    required this.country,
    this.deviceName,
  });

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullname,
      'email': email,
      'password': password,
      'country': country,
      'device_name': 'mobile',
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserInfo(fullname: $fullname, email: $email, password: $password, country: $country, deviceName: $deviceName)';
  }
}
