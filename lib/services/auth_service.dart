import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:helloworld/helpers/constants.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;

  Auth0 auth0 = Auth0(auth0Domain, auth0ClientId);
  UserProfile? profile;

  AuthService._internal();

  Future init() async {
    final isLoggedIn = await auth0.credentialsManager.hasValidCredentials();
    if (isLoggedIn) {
      final credentials = await auth0.credentialsManager.credentials();
      profile = credentials.user;
    }
    return profile;
  }

  Future login() async {
    final credentials = await auth0.webAuthentication().login(
          audience: auth0Audience,
        );
    profile = credentials.user;
    return profile;
  }

  Future signup() async {
    final credentials = await auth0
        .webAuthentication()
        .login(audience: auth0Audience, parameters: {
      'screen_hint': 'signup',
    });
    profile = credentials.user;
    return profile;
  }

  Future logout() async {
    await auth0.webAuthentication().logout();
    profile = null;
    return;
  }
}
