class APIPath {
  static const _baseUrl = 'https://smart-pay-mobile.herokuapp.com/api/v1';

  static String get fetchToken => '$_baseUrl/auth/email';

  static String get verifyToken => '$_baseUrl/auth/email/verify';

  static String get register => '$_baseUrl/auth/register';

  static String get dashboard => '$_baseUrl/dashboard';

  static String get logout => '$_baseUrl/auth/logout';

  static String get login => '$_baseUrl/auth/login';
}
