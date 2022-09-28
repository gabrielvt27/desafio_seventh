import 'package:desafio_seventh/app/constants.dart';
import 'package:desafio_seventh/app/errors/auth_exception.dart';
import 'package:desafio_seventh/app/models/login_model.dart';
import 'package:desafio_seventh/app/models/tokenization.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<String?> getPreferenceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kPreferenceTokenName);
  }

  setPreferenceToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kPreferenceTokenName, accessToken);
  }

  removePreferenceToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kPreferenceTokenName);
  }

  Future<Tokenization> loginWithUserAndPassword(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        '$kApiRoute/login',
        data: loginModel.toMap(),
        options: Options(headers: {
          'content-Type': 'application/json',
        }),
      );
      return Tokenization(accessToken: response.data['token']);
    } on DioError catch (e) {
      throw [400, 401].contains(e.response!.statusCode)
          ? AuthException(e.response!.data['message'])
          : Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
