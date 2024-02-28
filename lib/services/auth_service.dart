import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:helloworld/helpers/constants.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;

  Auth0 auth0 = Auth0(auth0Domain, auth0ClientId);
  UserProfile? profile;

  AuthService._internal();

  Future login() async {
    final credentials = await auth0.webAuthentication().login(
          audience: auth0Audience,
        );
    profile = credentials.user;
    return;
  }

  Future signup() async {
    final credentials = await auth0
        .webAuthentication()
        .login(audience: auth0Audience, parameters: {
      'screen_hint': 'signup',
    });
    profile = credentials.user;
    return;
  }

  Future logout() async {
    await auth0.webAuthentication().logout();
    profile = null;
    return;
  }
}
