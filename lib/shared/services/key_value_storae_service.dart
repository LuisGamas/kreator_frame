abstract class KeyValueStorageService {
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getKeyValue<T>(String key);
  Future<bool> removeKey(String key);
}
