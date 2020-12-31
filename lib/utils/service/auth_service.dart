import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  static AuthService _instance;

  final FlutterAppAuth appAuth = FlutterAppAuth();

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  bool isAdmin = false;

  Map<String, dynamic> userInfo;

  AuthService._();

  static AuthService getInstance() {
    if (_instance == null) {
      _instance = AuthService._();
    }
    return _instance;
  }

  Future<TokenResponse> authenticate() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    TokenResponse result;
    if (storedRefreshToken == null) {
      result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
            'weasylearn-mobile', 'ro.weasylearn://login-callback',
            issuer: 'https://accounts.weasylearn.ro/auth/realms/weasylearn-local',
            scopes: [
              'openid',
              'profile',
              'offline_access'
            ],
            promptValues: [
              'login'
            ]
        ),
      );
    } else {
      result = await appAuth.token(TokenRequest(
        'weasylearn-mobile', 'ro.weasylearn://login-callback',
        issuer: 'https://accounts.weasylearn.ro/auth/realms/weasylearn-local',
        refreshToken: storedRefreshToken,
      ));
    }
    secureStorage.write(key: 'refresh_token', value: result.refreshToken);
    userInfo = parseIdToken(result.idToken);
    final parsedAccessToken = parseIdToken(result.accessToken);
    isAdmin = (parsedAccessToken['resource_access']['weasylearn-be']['roles'] as List).contains('Admin');
    return result;
  }

  void logout() async{
    await secureStorage.delete(key: 'refresh_token');
  }

  String getUsername() {
    return userInfo['preferred_username'];
  }

  String getName() {
    return userInfo['family_name'];
  }

  String getSurname() {
    return userInfo['given_name'];
  }

  static Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }
}
