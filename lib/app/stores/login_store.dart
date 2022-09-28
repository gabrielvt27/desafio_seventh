import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:desafio_seventh/app/models/login_model.dart';
import 'package:desafio_seventh/app/utils/api_response.dart';

class LoginStore {
  String? _user;
  String? _password;

  final ValueNotifier<ApiResponse> loginState =
      ValueNotifier<ApiResponse>(ApiResponse.initial());

  final AuthStore _authStore;

  LoginStore(this._authStore);

  set user(String val) => _user = val;
  set password(String val) => _password = val;

  login() async {
    loginState.value = ApiResponse.initial();

    if (_validateInputs) {
      loginState.value = ApiResponse.error("Campos não preenchidos");
      return;
    }

    loginState.value = ApiResponse.loading();

    // _user = "candidato-seventh";
    // _password = "8n5zSrYq";

    try {
      final loginModel = LoginModel(user: _user!, password: _password!);
      await _authStore.loginUser(loginModel);
      loginState.value = ApiResponse.completed();
      Modular.to.pushReplacementNamed('/home/');
    } catch (e) {
      loginState.value = ApiResponse.error(e.toString());
    }
  }

  bool get _validateInputs =>
      _user == null ||
      _user!.isEmpty ||
      _password == null ||
      _password!.isEmpty;
}
