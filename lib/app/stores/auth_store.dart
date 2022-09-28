import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_seventh/app/models/login_model.dart';
import 'package:desafio_seventh/app/models/tokenization.dart';
import 'package:desafio_seventh/app/repositories/auth_repository.dart';

class AuthStore {
  final AuthRepository _authRepository;
  Tokenization? _token;

  AuthStore(this._authRepository) {
    _handleAuthState();
  }

  Tokenization? get token => _token;
  get isLogged => _token != null;

  _handleAuthState() async {
    final jwt = await _authRepository.getPreferenceToken();

    if (jwt != null) {
      _token = Tokenization(accessToken: jwt);
      Modular.to.pushReplacementNamed('/home/');
    }
  }

  loginUser(LoginModel loginModel) async {
    final token = await _authRepository.loginWithUserAndPassword(loginModel);
    setToken(token);
  }

  logoutUser() async {
    await setToken(null);
    Modular.to.pushReplacementNamed('/login/');
  }

  setToken(Tokenization? token) async {
    _token = token;

    if (token == null) {
      _authRepository.removePreferenceToken();
    } else {
      _authRepository.setPreferenceToken(token.accessToken);
    }
  }
}
