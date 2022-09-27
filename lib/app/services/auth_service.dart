import 'package:desafio_seventh/app/constants.dart';
import 'package:desafio_seventh/app/errors/auth_exception.dart';
import 'package:desafio_seventh/app/models/login_model.dart';
import 'package:desafio_seventh/app/models/tokenization.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Tokenization> loginWithUserAndPassword(LoginModel loginModel) async {
    Response response;
    try {
      response = await _dio.post(
        '$kApiRoute/login',
        data: loginModel.toMap(),
        options: Options(headers: {
          'content-Type': 'application/json',
        }),
      );
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }

    switch (response.statusCode) {
      case 200:
        return Tokenization(accessToken: response.data.token);
      case 400:
      case 401:
        throw AuthException(response.data.message);
      default:
        throw Exception(response.data.message);
    }
  }
}
