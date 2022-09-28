import 'package:flutter_modular/flutter_modular.dart';

import 'package:dio/dio.dart';

import 'package:desafio_seventh/app/stores/auth_store.dart';
import 'package:desafio_seventh/app/errors/app_exception.dart';
import 'package:desafio_seventh/app/services/http/http_client_service.dart';

class DioClientServiceImp implements IHttpClientService {
  final Dio _dio = Dio(BaseOptions(
    headers: {
      'content-type': 'application/json',
    },
  ));

  DioClientServiceImp() {
    _setUpDio();
  }

  _setUpDio() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final authStore = Modular.get<AuthStore>();
          final token = authStore.token;

          if (token != null) {
            options.headers.addAll({'X-Access-Token': token.accessToken});
          }

          return handler.next(options);
        },
        onError: (e, handler) async {
          final authStore = Modular.get<AuthStore>();
          if (e.response?.statusCode == 401) {
            authStore.logoutUser();
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future get(String url) async {
    dynamic responseJson;
    try {
      final response = await _dio.get(url);
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
      responseJson = _returnResponse(e.response!);
    } catch (e) {
      throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  @override
  Future post(String url, data) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(
        url,
        data: data,
      );
      responseJson = _returnResponse(response);
    } on DioError catch (e) {
      responseJson = _returnResponse(e.response!);
    } catch (e) {
      throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 400:
        throw BadRequestException(response.data['message']);
      case 401:
        throw UnauthorizedException(response.data['message']);
      case 404:
        throw NotFoundException(response.data['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
