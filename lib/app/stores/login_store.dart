import 'package:desafio_seventh/app/errors/auth_exception.dart';
import 'package:desafio_seventh/app/models/login_model.dart';
import 'package:desafio_seventh/app/services/auth_service.dart';
import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:flutter/cupertino.dart';

class LoginStore {
  String? _user;
  String? _password;

  final ValueNotifier<String?> _error = ValueNotifier<String?>(null);

  final AuthService _authService;
  final AuthStore _authStore;

  LoginStore(this._authService, this._authStore);

  set user(String val) => _user = val;
  set password(String val) => _password = val;

  get error => error.value;

  login() async {
    _error.value = null;

    try {
      final loginModel = LoginModel(user: _user!, password: _password!);
      final token = await _authService.loginWithUserAndPassword(loginModel);
      _authStore.token = token;
    } on AuthException catch (e) {
      _error.value = e.message;
    } catch (e) {
      print(e.toString());
      _error.value = "Houve um erro inesperado";
    }
  }
}
