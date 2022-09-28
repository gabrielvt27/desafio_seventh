abstract class IHttpClientService {
  Future get(String url);
  Future post(String url, data);
}
