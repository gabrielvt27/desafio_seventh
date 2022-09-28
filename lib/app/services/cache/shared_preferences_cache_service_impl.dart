import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:desafio_seventh/app/services/cache/cache_service.dart';

class SharedPreferencesCacheServiceImp implements ICacheService {
  final completer = Completer<SharedPreferences>();

  SharedPreferencesCacheServiceImp() {
    _init();
  }

  _init() async {
    final instance = await SharedPreferences.getInstance();
    completer.complete(instance);
  }

  @override
  Future get(String key) async {
    final instance = await completer.future;
    return instance.get(key);
  }

  @override
  Future<bool> set(String key, value) async {
    final instance = await completer.future;
    switch (value.runtimeType) {
      case int:
        return await instance.setInt(key, value);
      case bool:
        return await instance.setBool(key, value);
      case double:
        return await instance.setDouble(key, value);
      case String:
        return await instance.setString(key, value);
      default:
        return false;
    }
  }

  @override
  Future<bool> remove(String key) async {
    final instance = await completer.future;
    return instance.remove(key);
  }
}
