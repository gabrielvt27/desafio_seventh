import 'package:flutter_modular/flutter_modular.dart';

import 'package:desafio_seventh/app/pages/login_page.dart';
import 'package:desafio_seventh/app/guards/auth_guard.dart';
import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:desafio_seventh/app/stores/login_store.dart';
import 'package:desafio_seventh/app/pages/video_player_page.dart';
import 'package:desafio_seventh/app/stores/video_player_store.dart';
import 'package:desafio_seventh/app/repositories/auth_repository.dart';
import 'package:desafio_seventh/app/repositories/video_player_repository.dart';
import 'package:desafio_seventh/app/services/http/dio_client_service_impl.dart';
import 'package:desafio_seventh/app/services/cache/shared_preferences_cache_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => DioClientServiceImp()),
        Bind.singleton((i) => SharedPreferencesCacheServiceImp()),
        Bind.singleton((i) => AuthRepository(i(), i())),
        Bind.singleton((i) => AuthStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/home/',
            module: HomeModule(),
            transition: TransitionType.leftToRight,
            guards: [AuthGuard()]),
        ModuleRoute(
          '/login/',
          module: LoginModule(),
          transition: TransitionType.fadeIn,
        ),
      ];
}

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => VideoPlayerRepository(i())),
        Bind.singleton((i) => VideoPlayerStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const VideoPlayerPage()),
      ];
}

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => LoginStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LoginPage()),
      ];
}
