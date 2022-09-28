import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return Modular.get<AuthStore>().isLogged;
  }
}
