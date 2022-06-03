import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user_info.dart';
import 'api_path.dart';

abstract class AuthBase {
  Future<String> fetchEmailToken(String email);
  Future<bool> verifyEmailToken(String email, String token);
  Future<String> register(UserInfo user);
  Future<String> dashboard(String token);
  Future<String> login(String email, String password);
  Future<void> logout();
}

class AuthRepo implements AuthBase {
  @override
  Future<String> fetchEmailToken(String email) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.fetchToken),
        headers: {
          'content-type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        body: json.encode({'email': email}),
      );

      final body = json.decode(response.body);
      return body['data']['token'] ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyEmailToken(String email, String token) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.verifyToken),
        headers: {
          'content-type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        body: json.encode({'email': email, 'token': token}),
      );

      final body = json.decode(response.body);
      return body['status'] ?? false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> register(UserInfo user) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.register),
        headers: {
          'content-type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        body: user.toJson(),
      );

      final body = json.decode(response.body);
      return body['data']['token'] ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> dashboard(String token) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.dashboard),
        headers: {'Authorization': 'Bearer $token'},
      );

      final body = json.decode(response.body);
      return body['data']['secret'] ?? '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.logout),
        headers: {
          'Accept': 'application/json',
        },
      );

      json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.login),
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json; charset=utf-8',
        },
        body: json.encode(
            {'email': email, 'password': password, 'device_name': 'mobile'}),
      );

      final body = json.decode(response.body);
      return body['data']['token'] ?? '';
    } catch (e) {
      rethrow;
    }
  }
}
