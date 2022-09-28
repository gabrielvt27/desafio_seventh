import 'package:desafio_seventh/app/constants.dart';
import 'package:desafio_seventh/app/models/login_model.dart';
import 'package:desafio_seventh/app/models/tokenization.dart';
import 'package:desafio_seventh/app/services/cache/cache_service.dart';
import 'package:desafio_seventh/app/services/http/http_client_service.dart';

class AuthRepository {
  final IHttpClientService _httpClient;
  final ICacheService _cacheService;

  AuthRepository(this._httpClient, this._cacheService);

  Future<String?> getPreferenceToken() async {
    return await _cacheService.get(kPreferenceTokenName);
  }

  setPreferenceToken(String accessToken) async {
    await _cacheService.set(kPreferenceTokenName, accessToken);
  }

  removePreferenceToken() async {
    await _cacheService.remove(kPreferenceTokenName);
  }

  Future<Tokenization> loginWithUserAndPassword(LoginModel loginModel) async {
    final response =
        await _httpClient.post('$kApiRoute/login', loginModel.toMap());
    return Tokenization(accessToken: response['token']);
  }
}
