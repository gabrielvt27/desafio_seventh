abstract class ICacheService {
  Future get(String key);
  Future<bool> set(String key, value);
  Future<bool> remove(String key);
}
