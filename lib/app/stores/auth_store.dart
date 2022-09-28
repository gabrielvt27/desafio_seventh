import 'package:desafio_seventh/app/models/tokenization.dart';
import 'package:desafio_seventh/app/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthStore {
  final AuthService _authService;
  Tokenization? _token;

  AuthStore(this._authService) {
    _handleAuthState();
  }

  get isLogged => _token != null;

  _handleAuthState() async {
    final jwt = await _authService.getPreferenceToken();

    if (jwt != null) {
      _token = Tokenization(accessToken: jwt);
      Modular.to.pushReplacementNamed('/home');
    }
  }

  setToken(Tokenization? token) async {
    _token = token;

    if (token == null) {
      _authService.removePreferenceToken();
    } else {
      _authService.setPreferenceToken(token.accessToken);
    }
  }
}
