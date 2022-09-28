import 'package:desafio_seventh/app/constants.dart';
import 'package:desafio_seventh/app/services/http/http_client_service.dart';

class VideoPlayerRepository {
  final IHttpClientService _httpClient;

  VideoPlayerRepository(this._httpClient);

  Future<String> getVideoUrlByFileName(String fileName) async {
    final response = await _httpClient.get('$kApiRoute/video/$fileName');
    return response['url'];
  }
}
