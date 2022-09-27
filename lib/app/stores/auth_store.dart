import 'package:desafio_seventh/app/models/tokenization.dart';

class AuthStore {
  Tokenization? _token;
  get isLogged => _token != null;

  AuthStore() {
    _handleAuthState();
  }

  _handleAuthState() {}

  set token(Tokenization? token) {
    // guardar/apagar token
    _token = token;
  }
}
