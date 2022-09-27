import 'package:desafio_seventh/app/guards/auth_guard.dart';
import 'package:desafio_seventh/app/pages/home_page.dart';
import 'package:desafio_seventh/app/pages/login_page.dart';
import 'package:desafio_seventh/app/services/auth_service.dart';
import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:desafio_seventh/app/stores/login_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => AuthService(i())),
        Bind.singleton((i) => AuthStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const HomePage(), guards: [AuthGuard()]),
        ModuleRoute('/login', module: LoginModule()),
      ];
}

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => LoginStore(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LoginPage()),
      ];
}
